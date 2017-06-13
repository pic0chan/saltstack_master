#!/bin/bash

rails __5.0.0.1__ new hello_app
cd hello_app
bundle install

sudo yum install -y epel-release
sudo yum install -y nodejs --enablerepo=epel
