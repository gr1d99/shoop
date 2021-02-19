#!/usr/bin/env bash

chown -R $USER /var/www/shoop
service nginx restart
