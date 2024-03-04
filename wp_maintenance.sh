#!/bin/bash

log_file="/tmp/wp_maintenance_log_$(date +'%Y-%m-%d').txt"
error_log="/tmp/wp_errors_$(date +'%Y-%m-%d').html" # Note the .html extension
email_address="notifications@example.com"
server_hostname=$(hostname)

# Initialize the HTML error log with a header to identify it's an error log
echo "<html><head><style>h2{color: #333;}p{font-family: Arial, sans-serif;}</style></head><body>" > "$error_log"
exec > >(tee "$log_file") 2>&1
echo "Starting WordPress maintenance process..."

error_found=false # Flag to track if any errors were found

for user_dir in /home/*; do
    for wp_dir in "$user_dir"/webapps/*; do
        if [ -f "$wp_dir"/wp-config.php ]; then
            wp_install_dir="$wp_dir"
            user=$(basename "$user_dir")

            echo "Processing WordPress site in $wp_install_dir for user $user"
            checksum_output=$(su - $user -c "cd $wp_install_dir; wp core verify-checksums --include-root" 2>&1)
            echo "$checksum_output"

            if ! echo "$checksum_output" | grep -q "Success: WordPress installation verifies against checksums."; then
                error_found=true # Set flag to true if any error is found
                echo "<h2>Error at $wp_install_dir</h2>" >> "$error_log"
                # Convert output to HTML paragraphs
                echo "$checksum_output" | sed 's/$/<br>/' | awk '{print "<p>" $0 "</p>"}' >> "$error_log"
            fi

            echo "Maintenance completed for $wp_install_dir"
        else
            echo "No WordPress installations found in $wp_dir for $user."
        fi
    done
done

echo "</body></html>" >> "$error_log"

echo "Finished processing all WordPress sites."

if $error_found && [ -s "$error_log" ]; then
    echo "Sending error log to $email_address"
    # Prepare and send the HTML email
    {
        echo "To: $email_address"
        echo "From: $email_address"
        echo "Subject: WordPress Maintenance Errors $(date +'%Y-%m-%d') - $server_hostname"
        echo "MIME-Version: 1.0"
        echo "Content-Type: text/html"
        echo
        cat "$error_log"
    } | ssmtp "$email_address"

    echo "Error log sent to $email_address."
else
    echo "No errors found. No email sent."
fi
