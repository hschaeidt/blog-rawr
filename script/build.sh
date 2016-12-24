#!/bin/bash
# needs permissions: chmod ugo+x
set -ev

# misc configuration
git config user.name "Travis CI"
git config user.email "he.schaeidt@gmail.com"
COMMIT_MESSAGE="Auto build #${TRAVIS_BUILD_NUMBER} by travis"

# Get the deploy key by using Travis's stored variables to decrypt travis_blog.enc
openssl aes-256-cbc -K $encrypted_48c6a28eef24_key -iv $encrypted_48c6a28eef24_iv -in travis_blog.enc -out travis_blog -d
chmod 600 travis_blog
eval `ssh-agent -s`
ssh-add travis_blog

# prepare phase
THEME="https://github.com/dim0627/hugo_theme_tropic.git" #hugo theme repository
THEME_NAME="tropic" #the dir name of the theme in the themes folder
TARGET_REPO="git@github.com:hschaeidt/blog.git"
TARGET_BRANCH="gh-pages"

git clone $THEME "themes/${THEME_NAME}" #get a copy of the theme
git clone $TARGET_REPO public
(cd public && git checkout $TARGET_BRANCH)

# build phase
hugo --theme=$THEME_NAME

# deploy phase
cd public
git add -A #add all changes
git commit -m $COMMIT_MESSAGE
git push
# done
