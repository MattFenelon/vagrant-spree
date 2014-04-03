#!/usr/bin/env bash

## Ruby ##

RUBY_VERSION="2.1.1"
RAILS_VERSION="4.0.3"
SPREE_VERSION="2.1.0"

test -d ~/.rbenv
if [ $? == 0 ]; then
    echo "Skipping rbenv installation as it's already installed"
else
    echo 'Installing rbenv'
    # rbenv is used to install Ruby
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

    # Add ~/.rbenv/bin to your $PATH for access to the rbenv command-line utility.
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    # Add rbenv init to your shell to enable shims and autocompletion.
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

test -d ~/.rbenv/plugins/ruby-build
if [ $? == 0 ]; then
    echo "Skipping ruby-build plugin installation as it's already installed"
else
    echo 'Installing ruby-build plugin'
    # Install ruby-build plugin for rbenv to install Ruby
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

if [ $(rbenv version-name) == $RUBY_VERSION ]; then
    echo "Skipping installation of Ruby as $(rbenv version-name) is already installed."
else
    echo "Installing Ruby $RUBY_VERSION"
    # Suggested packages for Ruby
    sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev

    # Install Ruby (--keep causes ruby-build to not delete the source for Ruby)
    rbenv install $RUBY_VERSION --keep
    # Set the system Ruby to version 2.1.1
    rbenv global $RUBY_VERSION
fi

# Install SQLlite - required for new Rails sites 
sudo apt-get install -y libsqlite3-dev
# Install node.js - required for new Rails sites
sudo apt-get install -y nodejs

# Ruby on Rails
if $(gem list "rails" -v $RAILS_VERSION --installed); then
    echo "Skipping installation of Ruby on Rails $RAILS_VERSION as it's already installed."
else
    echo "Installing Ruby on Rails $RAILS_VERSION"
    gem install rails --version $RAILS_VERSION --no-ri --no-rdoc
fi

# Bundler
if $(gem list "bundler" --installed); then
    echo "Skipping installation of Bundler as it's already installed."
else
    echo "Installing Bundler"
    gem install bundler
fi

# ImageMagick. A dependency of Spree.
identify -version
if [ $? == 0 ]; then
    echo "Skipping ImageMagick installation as it's already installed."
else
    rm -r tmp-ImageMagick
    mkdir tmp-ImageMagick
    pushd tmp-ImageMagick

    wget --no-verbose http://www.imagemagick.org/download/ImageMagick.tar.bz2
    tar -xjf ImageMagick.tar.bz2 --strip=1

    ./configure
    make
    sudo make install
fi
popd

# Spree
if $(gem list "spree_cmd" -v "~>$SPREE_VERSION" --installed); then
    echo "Skipping installation of spree_cmd $SPREE_VERSION as it's already installed."
else
    echo "Installing spree_cmd ~>$SPREE_VERSION"
    gem install spree_cmd --version "~>$SPREE_VERSION"
fi
