#!/bin/bash

# Auto Push to Git Script
# This script helps you automatically commit and push changes to your Git repository

echo "=========================================="
echo "   Auto Git Push Script"
echo "=========================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: Git is not installed!"
    echo "Please install git first: sudo apt install git"
    exit 1
fi

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "❌ Error: Not a git repository!"
    echo "Run 'git init' first or navigate to your git repository"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "📍 Current branch: $CURRENT_BRANCH"
echo ""

# Check for changes
if [[ -z $(git status -s) ]]; then
    echo "✅ No changes to commit"
    echo "Everything is up to date!"
    exit 0
fi

# Show changed files
echo "📝 Changed files:"
git status -s
echo ""

# Ask for commit message
echo "💬 Enter commit message (or press Enter for default message):"
read -r COMMIT_MESSAGE

# Use default message if empty
if [ -z "$COMMIT_MESSAGE" ]; then
    COMMIT_MESSAGE="Update files - $(date '+%Y-%m-%d %H:%M:%S')"
fi

echo ""
echo "🔧 Adding all changes..."
git add .

echo "💾 Creating commit..."
git commit -m "$COMMIT_MESSAGE"

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to create commit"
    exit 1
fi

echo "🚀 Pushing to remote repository..."
git push origin "$CURRENT_BRANCH"

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ Successfully pushed to $CURRENT_BRANCH!"
    echo "=========================================="
else
    echo ""
    echo "❌ Error: Failed to push to remote"
    echo "Please check your internet connection and Git credentials"
    exit 1
fi