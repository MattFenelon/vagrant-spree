#!/usr/bin/env bash

## Ruby ##

RUBY_VERSION="2.2.1"

if [ -d ~/.rbenv ]; then
    echo "Updating rbenv installation"

    pushd ~/.rbenv && git pull
    popd
else
    echo 'Installing rbenv'
    # rbenv is used to install Ruby
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

    cat <<-EOH > .bashrc-rbenv
# Add ~/.rbenv/bin to your $PATH for access to the rbenv command-line utility.
export PATH="\$HOME/.rbenv/bin:\$PATH"

# Add rbenv init to your shell to enable shims and autocompletion.
eval "\$(rbenv init -)"
EOH

    cat <<-EOH > .bashrc
# Added by Vagrant provisioning script
source .bashrc-rbenv

# Original .bashrc below
# vvvvvvvvvvvvvvvvvvvvvv

$(cat .bashrc)
EOH
fi

source .bashrc

if [ -d ~/.rbenv/plugins/ruby-build ]; then
    echo "Updating ruby-build plugin installation"

    pushd ~/.rbenv/plugins/ruby-build && git pull
    popd
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
    sudo apt-get install -y autoconf bison build-essential curl libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

    # Install Ruby (--keep causes ruby-build to not delete the source for Ruby)
    RUBY_CONFIGURE_OPTS=--enable-shared rbenv install $RUBY_VERSION --keep

    # Set the system Ruby to the version that was just installed
    rbenv global $RUBY_VERSION

    echo "gem: --no-ri --no-rdoc" > ~/.gemrc
fi

# Bundler
if [ $(gem list "bundler" --installed) ]; then
    echo "Skipping installation of Bundler as it's already installed."
else
    echo "Installing Bundler"
    gem install bundler
fi

# Foreman
if [ $(gem list "foreman" --installed) ]; then
    echo "Skipping installation of Foreman as it's already installed."
else
    echo "Installing Foreman"
    gem install foreman
fi

rbenv rehash
