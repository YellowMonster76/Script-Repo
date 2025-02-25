#!/bin/bash

# Run this script with:
# wget https://raw.githubusercontent.com/YellowMonster76/Script-Repo/main/Installs/script-template.sh --no-check-certificate && sudo bash script-template.sh


#-----------------------------------#
#             VARIABLES             #
#-----------------------------------#

this_script_url="https://raw.githubusercontent.com/YellowMonster76/Script-Repo/main/Installs/script-template.sh"
this_script_name="TEMPLATE"
formatter_url="https://raw.githubusercontent.com/YellowMonster76/TaskFormatter/main/bash_task_formatter/task_formatter.sh"
scriptname=$0

# Initialize success flag
success=0

# Determine the user (use the first argument if provided, otherwise fallback)
USER_TO_RUN_AS="${1:-$SUDO_USER}"
USER_HOME=$(eval echo ~$USER_TO_RUN_AS)


#-----------------------------------#
#             FORMATTER             #
#-----------------------------------#

if [ ! -f "task_formatter.sh" ]; then
    wget $formatter_url --no-check-certificate -O task_formatter.sh > /dev/null 2>&1
fi

source ./task_formatter.sh

#-----------------------------------#
#             FUNCTIONS             #
#-----------------------------------#


# Function to update packages
update_upgrade_packages() {
    sudo apt-get update > /dev/null 2>&1
    echo -e "Packages Updated $CHECK_MARK"
    sudo apt-get upgrade -y > /dev/null 2>&1
    echo -e "Packaged Upgraded $CHECK_MARK"
    sudo apt-get autoremove -y > /dev/null 2>&1
    echo -e "Packages Cleaned $CHECK_MARK"
}

# remove artifacts
remove_script() {
    if [ -f "$0" ]; then
        echo "Deleted master script..."
        rm -- "$0"
    fi
    if [ -f "task_formatter.sh" ]; then
        rm task_formatter.sh
    fi
    echo -e "Cleaned up $CHECK_MARK"
}

# Remove created files on Failure
cleanup_files() {
    echo -e "Cleaned up $CHECK_MARK"
}


#-----------------------------------#
#             MAIN LOGIC            #
#-----------------------------------#

'''
Run functions with this format:

    format_output {function_name} "Function Description"

    Example:
        
        format_output update_upgrade_packages "Update and Upgrade Packages"


To add in success monitoring when script is run from master.sh, run like this:

if ! format_output {function_name} "Function Description"; then
    cleanup_files
    success=1
fi

if ! format_output {function_name} "Function Description"; then
    cleanup_files
    success=1
fi

'''

# Print header
print_header "$this_script_name" "$this_script_url"

echo -e "Running as User: $USER_TO_RUN_AS\nUser Home: $USER_HOME\n"


# Run the functions with formatted output
if ! format_output update_upgrade_packages "Update and Upgrade Packages"; then
    cleanup_files
    success=1
fi


format_output remove_script "Cleaning up"

# Print final message
final_message "$this_script_name" $success

# Exit with appropriate status
exit $success
