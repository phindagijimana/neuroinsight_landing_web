#!/bin/bash

# NeuroInsight Landing Page Deployment Script
# This script helps deploy the landing page locally or to various hosting platforms

set -e

echo "🚀 NeuroInsight Landing Page Deployment"
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    print_error "index.html not found. Please run this script from the NeuroInsight_landing_page directory."
    exit 1
fi

print_info "Detected NeuroInsight landing page files"

# Function to serve locally
serve_local() {
    print_info "Starting local development server..."
    print_info "Available options:"
    echo "1. Python HTTP server (simple)"
    echo "2. Node.js http-server (requires npm install -g http-server)"
    echo "3. PHP built-in server (requires php)"
    echo "4. Use browser to open index.html directly"

    read -p "Choose server type (1-4): " choice

    case $choice in
        1)
            if command -v python3 &> /dev/null; then
                print_info "Starting Python HTTP server on http://localhost:8000"
                python3 -m http.server 8000
            else
                print_error "Python3 not found. Please install Python3."
                exit 1
            fi
            ;;
        2)
            if command -v http-server &> /dev/null; then
                print_info "Starting Node.js HTTP server on http://localhost:8080"
                http-server -p 8080
            else
                print_warning "http-server not installed. Installing globally..."
                npm install -g http-server
                print_info "Starting Node.js HTTP server on http://localhost:8080"
                http-server -p 8080
            fi
            ;;
        3)
            if command -v php &> /dev/null; then
                print_info "Starting PHP development server on http://localhost:8000"
                php -S localhost:8000
            else
                print_error "PHP not found. Please install PHP."
                exit 1
            fi
            ;;
        4)
            print_info "Opening index.html directly in default browser..."
            if command -v xdg-open &> /dev/null; then
                xdg-open index.html
            elif command -v open &> /dev/null; then
                open index.html
            else
                print_warning "Could not detect browser command. Please manually open index.html"
            fi
            ;;
        *)
            print_error "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Function to deploy to GitHub Pages
deploy_github_pages() {
    print_info "Deploying to GitHub Pages..."

    # Check if git is initialized
    if [ ! -d ".git" ]; then
        print_warning "No git repository found. Initializing..."
        git init
        git add .
        git commit -m "Initial commit: NeuroInsight landing page"
    fi

    # Check if remote is set
    if ! git remote get-url origin &> /dev/null; then
        read -p "Enter your GitHub repository URL: " repo_url
        git remote add origin "$repo_url"
    fi

    # Create gh-pages branch if it doesn't exist
    if ! git branch -r | grep -q "origin/gh-pages"; then
        print_info "Creating gh-pages branch..."
        git checkout -b gh-pages
        git push -u origin gh-pages
    else
        print_info "Switching to gh-pages branch..."
        git checkout gh-pages
        git merge main --no-edit || git merge master --no-edit || true
    fi

    # Push to GitHub Pages
    print_info "Pushing to GitHub Pages..."
    git add .
    git commit -m "Deploy landing page to GitHub Pages" || true
    git push origin gh-pages

    print_status "Deployed to GitHub Pages!"
    print_info "Your site should be available at: https://YOUR_USERNAME.github.io/YOUR_REPO_NAME"
}

# Function to create deployment package
create_package() {
    print_info "Creating deployment package..."

    timestamp=$(date +"%Y%m%d_%H%M%S")
    package_name="neuroinsight_landing_${timestamp}.zip"

    # Create zip file
    zip -r "$package_name" . -x "*.git*" "*deploy.sh*" "*README.md*" "*.DS_Store"

    print_status "Created deployment package: $package_name"
    print_info "You can upload this to any web hosting service (Netlify, Vercel, etc.)"
}

# Function to check deployment readiness
check_readiness() {
    print_info "Checking deployment readiness..."

    # Check for required files
    required_files=("index.html" "styles.css" "README.md")
    for file in "${required_files[@]}"; do
        if [ -f "$file" ]; then
            print_status "Found $file"
        else
            print_warning "Missing $file"
        fi
    done

    # Check for external links
    if grep -q "github.com/phindagijimana/neuroinsight_local" index.html; then
        print_status "GitHub link configured"
    else
        print_warning "GitHub link not found in index.html"
    fi

    if grep -q "urmc.rochester.edu" index.html; then
        print_status "URMC link configured"
    else
        print_warning "URMC link not found in index.html"
    fi

    # Check for accessibility
    if grep -q "alt=" index.html; then
        print_status "Alt text found for images"
    else
        print_warning "Consider adding alt text for images"
    fi

    print_info "Readiness check complete!"
}

# Main menu
show_menu() {
    echo
    echo "Available deployment options:"
    echo "1. Serve locally for testing"
    echo "2. Deploy to GitHub Pages"
    echo "3. Create deployment package"
    echo "4. Check deployment readiness"
    echo "5. Exit"
    echo
}

# Main loop
while true; do
    show_menu
    read -p "Choose an option (1-5): " choice

    case $choice in
        1)
            serve_local
            ;;
        2)
            deploy_github_pages
            ;;
        3)
            create_package
            ;;
        4)
            check_readiness
            ;;
        5)
            print_info "Goodbye!"
            exit 0
            ;;
        *)
            print_error "Invalid choice. Please select 1-5."
            ;;
    esac

    echo
    read -p "Press Enter to continue..."
done
