#!/usr/bin/env bash

before_install() {
  sudo rm -rf /home/shoop/shoop
}

after_install() {
    cd /home/shoop/shoop

    # nginx config
    sudo touch /etc/nginx/sites-enabled/shoop.conf
    sudo touch /etc/nginx/conf.d/shoop.conf
    sudo cp /home/shoop/shoop/deployment/shoop.nginx.conf /etc/nginx/sites-enabled/shoop.conf
}

application_start() {
    sudo -i -u shoop << EOF
    rvm use 3.2.0 --default
    rvm autolibs disable

    cd /home/shoop/shoop
    bundle install
    bundle exec rails db:prepare
    rails start -b 0.0.0.0
EOF
    sudo service nginx start
}

application_stop() {

  sudo service nginx stop
}
