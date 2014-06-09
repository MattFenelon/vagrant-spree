#!/usr/bin/env bash

# Sets up the database for the Spree store.

DATABASE_NAME=dev

pushd /vagrant

bundle install

if psql -lqt | cut -d \| -f 1 | grep -w $DATABASE_NAME; then
  echo "Skipping Spree store set up as the pg database $DATABASE_NAME already exists"
else
  rails g spree:install --migrate=false --sample=false --seed=false --skip --admin-email="spree@example.com" --admin-password="spree123" --auto-accept
  bundle exec rake db:migrate
  bundle exec rake db:seed
  bundle exec rake spree_sample:load
fi

popd
