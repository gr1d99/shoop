#!/usr/bin/env bash

chown -R $USER .
bin/setup
sudo service nginx restart
