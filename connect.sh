#!/bin/bash

echo 'pass' | openconnect \
 --user=username@cr14.net \
 --passwd-on-stdin \
 --protocol=anyconnect \
 --authgroup=EX \
 vpn.cr14.net
