#!/bin/bash

sudo yum install -y git gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel bzip2
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export RBENV_ROOT="${HOME}/.rbenv"' >> ${HOME}/.bash_profile
echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> ${HOME}/.bash_profile
echo 'eval "$(rbenv init -)"' >> ${HOME}/.bash_profile
