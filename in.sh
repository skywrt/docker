#!/bin/bash

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    curl -fsSL https://github.com/skywrt/docker/releases/download/latest/linux.sh | bash -s docker --mirror Aliyun
}

# Function to deploy xiaoya service
deploy_xiaoya() {
    echo "Deploying xiaoya service..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/skywrt/docker/main/install.sh)"
}

# Function to uninstall xiaoya service
uninstall_xiaoya() {
    echo "Uninstalling xiaoya service..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/skywrt/docker/main/uninstall.sh)"
}

# Function for xiaoya storage clean tool
xiaoya_storage_clean() {
    echo "Running xiaoya storage clean tool..."
    bash -c "$(curl -sLk https://xiaoyahelper.ddsrem.com/aliyun_clear.sh | tail -n +2)" -s 5
}

# Main script
echo "Welcome to the setup script!"

# Choose action
echo "Please choose an action:"
echo "1. Install Docker"
echo "2. Deploy xiaoya service"
echo "3. Uninstall xiaoya service"
echo "4. Run xiaoya storage clean tool"
echo "5. Exit"

read -p "Enter your choice [1-5]: " choice

case $choice in
    1)
        install_docker
        ;;
    2)
        deploy_xiaoya
        ;;
    3)
        uninstall_xiaoya
        ;;
    4)
        xiaoya_storage_clean
        ;;
    5)
        echo "Exiting script."
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Setup script completed."
