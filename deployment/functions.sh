#!/usr/bin/env bash

before_install() {
    sudo rm -rf /home/shoop
}

after_install() {
    sudo cp /home/shoop/deployment/shoop_nginx.conf /etc/nginx/sites-available/shoop.conf
    if [ -f "/etc/nginx/sites-enabled/shoop.conf" ]
    then
      sudo unlink /etc/nginx/sites-enabled/shoop.conf
      sudo ln -s /etc/nginx/sites-available/shoop.conf /etc/nginx/sites-enabled/shoop.conf
    else
      sudo ln -s /etc/nginx/sites-available/shoop.conf /etc/nginx/sites-enabled/shoop.conf
    fi
}

application_start() {
#    sudo -i -u shoop << EOF
#    rvm install 3.2.0
#    rvm use 3.2.0 --default
#    rvm autolibs disable
#
#    cd /home/shoop/shoop
#    bundle install
#    bundle exec rails db:prepare
#EOF
    sudo service nginx start
}

application_stop() {
  sudo service nginx stop
}
