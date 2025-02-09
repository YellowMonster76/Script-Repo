#!/bin/bash

FILE_NAME="abctl-v0.24.0-linux-amd64"
DOWNLOAD_URL="https://github.com/airbytehq/abctl/releases/download/v0.24.0/abctl-v0.24.0-linux-amd64.tar.gz"

# Download the file
echo "Downloading $FILE_NAME..."
curl -LO $DOWNLOAD_URL

# Extract the archive
echo "Extracting $FILE_NAME..."
tar -xvzf "$FILE_NAME".tar.gz

#rename extracted archive to abctl
echo "Renaming folder to abctl..."
mv "$FILE_NAME" abctl

# Make abctl executable
echo "Making abctl executable..."
chmod +x abctl/abctl

# Move the executable to /usr/local/bin as sudo
echo "Moving abctl to bin as sudo..."
sudo mv abctl/abctl /usr/local/bin/

#Remove downloaded file
echo "Deleting $FILE_NAME..."
rm "$FILE_NAME".tar.gz

#Delete abctl folder
echo "Deleting abctl folder..."
rm abctl -r

# Verify installation
echo "Verifying installation..."
abctl version
