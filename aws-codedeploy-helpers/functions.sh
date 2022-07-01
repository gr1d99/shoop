#!/usr/bin/env bash

before_install() {
    rm -rf /home/ubuntu/shop
}

after_install() {
    cd /home/ubuntu/shop && chown -R $USER .
    cp /home/ubuntu/shop/nginx.conf /etc/nginx.conf
}

application_start() {
    chmod 777 /home/ubuntu/shop/logs/ -R
    bundle install
    bundle exec rails db:prepare
    service nginx start
}

application_stop(){
    service nginx stop
}
