#!/bin/bash

kill -15 `pgrep -f puma`
export RAILS_ENV=production
git reset --hard HEAD
git pull
rake db:migrate assets:precompile
puma -C config/puma.rb -d -e production
