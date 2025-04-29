#!/bin/bash

# Find all empty directories and create .gitkeep in them
find . -type d -empty -exec touch {}/.gitkeep \;

# Initialize the Git repository if not already done
if [ ! -d .git ]; then
  git init
fi

# Add all files (including .gitkeep) to the staging area
git add .

# Commit the changes with a message
git commit -m "Initial commit with folder structure and .gitkeep placeholders"

# Check if remote 'origin' is already set
REMOTE_URL=$(git remote get-url origin 2>/dev/null)

if [ -z "$REMOTE_URL" ]; then
  # If no remote is set, ask the user for the remote URL (GitHub repository)
  read -p "Enter your GitHub repository URL (e.g., https://github.com/username/repository.git): " REMOTE_URL
  git remote add origin "$REMOTE_URL"
else
  echo "Remote origin already set: $REMOTE_URL"
fi

# Push to the GitHub repository (this assumes the default branch is 'main')
git push -u origin main

