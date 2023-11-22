#!/bin/bash

# Simple bash script used for testing git commands and scripts
# Copy this script into an empty directory, not yet initialized
# Initializes a git repo with an initial commit, files, and changes
# Great for testing how something like git stash -u/-k/-S/-a works

# ignored: this file is added to .gitignore
# not-added: regular file, not added to the repo
# working: committed to the repo, then modified
# staged: committed to the repo, then modified, then staged
# staged-then-working: committed, modified, staged, then modified again


git init
echo "ignored" >> .gitignore
echo 1 >> ignored
echo 1 >> not-added
echo 1 >> staged
echo 1 >> working
echo 1 >> staged-then-working
git add staged working staged-then-working .gitignore
git commit -m "initial commit"
echo 2 >> staged
echo 2 >> working
echo 2 >> staged-then-working
echo 2 >> not-added
echo 2 >> ignored
git add staged staged-then-working
echo 3 >> staged-then-working
