#!/usr/bin/env bash

RAILS_VERSION="4.1.7"

# Install SQLlite - required for new Rails sites
sudo apt-get install -y libsqlite3-dev

# Install node.js - required for new Rails sites
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs

# Ruby on Rails
if $(gem list "rails" -v $RAILS_VERSION --installed); then
    echo "Skipping installation of Ruby on Rails $RAILS_VERSION as it's already installed."
else
    echo "Installing Ruby on Rails $RAILS_VERSION"
    gem install rails --version $RAILS_VERSION --no-ri --no-rdoc
    rbenv rehash
fi
