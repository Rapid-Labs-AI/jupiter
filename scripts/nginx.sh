#!/usr/bin/bash

# Replace {YOUR_PROJECT_MAIN_DIR_NAME} with your actual project directory name
PROJECT_MAIN_DIR_NAME="jupiter"

# Replace {FOLDER_NAME_WHERE_SETTINGS_FILE_EXISTS} with the folder name where your nginx configuration file exists
FOLDER_NAME_WHERE_SETTINGS_FILE_EXISTS="jupiter"

# Reload systemd daemon
sudo systemctl daemon-reload

# Remove default Nginx site if exists
sudo rm -f /etc/nginx/sites-enabled/default

# Copy Nginx configuration file
sudo cp "/home/ubuntu/$PROJECT_MAIN_DIR_NAME/nginx/nginx.conf" "/etc/nginx/sites-available/$FOLDER_NAME_WHERE_SETTINGS_FILE_EXISTS"

# Check if symbolic link already exists
if [ -e "/etc/nginx/sites-enabled/$FOLDER_NAME_WHERE_SETTINGS_FILE_EXISTS" ]; then
    # Remove existing symbolic link
    sudo rm "/etc/nginx/sites-enabled/$FOLDER_NAME_WHERE_SETTINGS_FILE_EXISTS"
fi

# Create symbolic link to enable Nginx site
sudo ln -s "/etc/nginx/sites-available/$FOLDER_NAME_WHERE_SETTINGS_FILE_EXISTS" "/etc/nginx/sites-enabled/"

echo "Symbolic link created."

# Add www-data user to ubuntu group
sudo gpasswd -a www-data ubuntu

# Restart Nginx service
sudo systemctl restart nginx
