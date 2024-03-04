# WordPress-Maintenance-Script
This script is designed to automate the maintenance process for WordPress installations on a server. It verifies the integrity of WordPress core files, filters out common non-critical warnings, logs any discrepancies found, and sends a detailed report via email if any issues are detected. It's intended to help website administrators maintain the security and integrity of their WordPress sites efficiently.

## :warning: Important Warning

Before using this script, please be aware of the following important considerations:

- **Data Safety**: Ensure you have **backups** of your WordPress installations. While this script is designed to enhance security and integrity by checking for file discrepancies, it's crucial to have a rollback plan.

- **Testing Environment**: It's highly recommended to **test the script in a controlled environment** before deploying it on a production server. This ensures that it behaves as expected and does not inadvertently affect your live sites.

- **Email Configuration**: This script sends reports via email. Ensure that your server is configured to send emails and that the email address specified in the script is correct and capable of receiving emails.

- **Permissions**: Running this script requires certain permissions. Make sure the user executing the script has the necessary permissions to access and modify the WordPress installations.

- **Customization**: Review and customize the script as necessary for your environment. This includes setting the correct email address, adjusting the path to your WordPress installations, and potentially modifying the cron job schedule.

Failure to adhere to these considerations could result in unintended consequences for your WordPress installations. Use this script responsibly and at your own risk.


## How It Works

The script performs the following actions:

- **Searches** for all WordPress installations in each user's directory on the server.
- **Verifies** the integrity of WordPress core files against the official WordPress version to ensure they haven't been altered or corrupted.
- **Ignores** common but non-critical warnings like missing or extra files that are known and often intentional.
- **Logs** any discrepancies or potential security issues found during the verification process.
- **Sends** a detailed HTML email report if issues are detected, highlighting the affected WordPress installations for further action. **Make sure to have SSMTP configured!**
- Automatically **runs every 12 hours** to ensure ongoing monitoring and security.

## Installation

To use this script, follow these steps:

1. **Download the Script**: Clone this repository or download the script file directly to your server.

    ```
    git clone https://github.com/wnstify/WordPress-Maintenance-Script.git
    ```

2. **Make the Script Executable**: Change the script's permissions to make it executable.

    ```
    chmod +x wp_maintenance.sh
    ```

3. **Configure Email Address**: Edit the script to include your email address where you'd like to receive notifications.

4. **Set Up Cron Job**: Schedule the script to run automatically every 12 hours or run it straight away.

    ```
    crontab -e
    0 */12 * * * /path/to/wp_maintenance.sh
    ./wp_maintenance.sh
    ```

## Usage

After installation, the script will run automatically according to the schedule set in the cron job. You can also run the script manually to initiate the maintenance process:


## Contributing

Contributions to improve the script and add new features are welcome. If you have suggestions or improvements, please fork the repository and submit a pull request.

1. **Fork the Repository**: Click the 'Fork' button on the GitHub repository page.
2. **Clone Your Fork**: Clone your forked repository to your local machine.

    ```
    git clone https://github.com/yourusername/yourrepositoryname.git
    ```

3. **Create a New Branch**: Make your changes in a new git branch.

    ```
    git checkout -b your-branch-name
    ```

4. **Commit Your Changes**: Commit your changes with a descriptive commit message.

5. **Push to Your Fork**: Push your changes to your fork on GitHub.

    ```
    git push origin your-branch-name
    ```

6. **Submit a Pull Request**: Go to the original repository you forked, switch to your branch, and click 'Pull request'.

For more information on contributing, please read the [CONTRIBUTING.md](https://github.com/wnstify/WordPress-Maintenance-Script/blob/main/CONTRIBUTING.md) file (if available) in the repository.

## License

This project is licensed under the [MIT License](LICENSE.md) - see the LICENSE file for details.

