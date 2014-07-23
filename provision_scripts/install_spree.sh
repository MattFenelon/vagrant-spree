#!/usr/bin/env bash

# ImageMagick. A dependency of Spree.
identify -version
if [ $? == 0 ]; then
    echo "Skipping ImageMagick installation as it's already installed."
else
    sudo apt-get install -y imagemagick
fi

# Install PhantomJS. A headless browser. Used in end-to-end testing.
if which phantomjs > /dev/null; then
  echo "Skipping PhantomJS installation as it's already installed."
else
  sudo apt-get install -y -q=1 phantomjs
fi

# Install SQLlite - required for new Rails sites
sudo apt-get install -y -q=1 libmysqlclient-dev
