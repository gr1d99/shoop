#!/usr/bin/env bash

chown -R $USER .
bin/setup
service nginx restart

