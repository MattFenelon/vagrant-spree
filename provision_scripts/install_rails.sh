#!/usr/bin/env bash

RAILS_VERSION="4.2.1"

# Install SQLlite - required for new Rails sites
sudo apt-get install -y libsqlite3-dev

# Install PhantomJS
sudo apt-get install build-essential chrpath libssl-dev libxft-dev
sudo apt-get install libfreetype6 libfreetype6-dev
sudo apt-get install libfontconfig1 libfontconfig1-dev

export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
sudo tar xvjf $PHANTOM_JS.tar.bz2
sudo mv $PHANTOM_JS /usr/local/share
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

# Install node.js - required for new Rails sites
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs

# Install CasperJS - required for headless testing
sudo npm install -g casperjs

# Ruby on Rails
if $(gem list "rails" -v $RAILS_VERSION --installed); then
    echo "Skipping installation of Ruby on Rails $RAILS_VERSION as it's already installed."
else
    echo "Installing Ruby on Rails $RAILS_VERSION"
    gem install rails --version $RAILS_VERSION --no-ri --no-rdoc
    rbenv rehash
fi
