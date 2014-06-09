#!/usr/bin/env bash

# ImageMagick. A dependency of Spree.
identify -version
if [ $? == 0 ]; then
    echo "Skipping ImageMagick installation as it's already installed."
else
    sudo apt-get install -y imagemagick
fi
