#!/bin/bash

# Define color codes for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print messages
print_header() { echo -e "${YELLOW}========== $1 ==========${NC}"; }
print_error() { echo -e "${RED}ERROR: $1${NC}"; }
print_success() { echo -e "${GREEN}$1${NC}"; }
print_info() { echo -e "${YELLOW}$1${NC}"; }

# Deployment Information
display_info() {
    echo -e "${YELLOW}Deployment Information:${NC}"
    echo -e "Environment: ${GREEN}$ENVIRONMENT${NC}"
    echo -e "Registry: ${GREEN}$REGISTRY${NC}"
    echo -e "Repository: ${GREEN}$IMAGE_NAME${NC}"
}

# Define repositories
GITLAB_REPO="registry.gitlab.bigd.no"
GITLAB_PATH="homelab/k8s/k3sa/app-code/portfolio"
DOCKERHUB_REPO="docker.io"
DOCKERHUB_PATH="mnordbye/portfolio"

# Image details
GITLAB_IMAGE_NAME="$GITLAB_REPO/$GITLAB_PATH"
DOCKERHUB_IMAGE_NAME="$DOCKERHUB_REPO/$DOCKERHUB_PATH"

# Prompt for environment selection
print_header "Select Environment"
echo "1) Prod"
echo "2) Stage"
echo "3) Latest"
echo "4) Custom (Enter custom tag)"

read -p "Enter your choice (1-4): " ENV_CHOICE

case $ENV_CHOICE in
    1) ENVIRONMENT="prod" ;;
    2) ENVIRONMENT="stage" ;;
    3) ENVIRONMENT="latest" ;;
    4) 
        read -p "Enter custom tag: " CUSTOM_TAG
        if [ -z "$CUSTOM_TAG" ]; then
            print_error "Custom tag cannot be empty. Exiting..."
            exit 1
        fi
        ENVIRONMENT=$CUSTOM_TAG
        ;;
    *)
        print_error "Invalid choice. Exiting..."
        exit 1
        ;;
esac

# Prompt for registry selection
print_header "Select Registry"
echo "1) GitLab"
echo "2) Docker Hub"

read -p "Enter your choice (1 or 2): " REGISTRY_CHOICE

if [ "$REGISTRY_CHOICE" -eq 1 ]; then
    REGISTRY="GitLab"
    IMAGE_NAME=$GITLAB_IMAGE_NAME
    REGISTRY_URL=$GITLAB_REPO
elif [ "$REGISTRY_CHOICE" -eq 2 ]; then
    REGISTRY="Docker Hub"
    IMAGE_NAME=$DOCKERHUB_IMAGE_NAME
    REGISTRY_URL=$DOCKERHUB_REPO
else
    print_error "Invalid choice. Exiting..."
    exit 1
fi

# Display deployment information before proceeding
print_header "Deployment Information"
display_info

# Confirm before proceeding
read -p "Do you want to proceed with the deployment? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    print_error "Operation cancelled by user."
    exit 1
fi

# Define the full image tag
TAG="$IMAGE_NAME:$ENVIRONMENT"

# Log in to the selected registry
print_info "Logging into $REGISTRY..."
echo "$REGISTRY_PASSWORD" | docker login $REGISTRY_URL -u "$REGISTRY_USERNAME" --password-stdin

if [ $? -eq 0 ]; then
    print_info "Building Docker image..."
    docker build -t $TAG -f docker/Dockerfile .

    print_info "Pushing image to $REGISTRY..."
    docker push $TAG

    print_success "Docker image successfully pushed to $REGISTRY!"
else
    print_error "Failed to log in to $REGISTRY. Exiting..."
    exit 1
fi

print_success "Deployment to $ENVIRONMENT environment completed!"
