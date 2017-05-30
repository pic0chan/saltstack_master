#!/bin/bash

sudo yum install -y git gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel bzip2
git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

echo'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile
echo'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile
echo'eval "$(rbenv init -)"' >> /etc/profile
source /etc/profile
