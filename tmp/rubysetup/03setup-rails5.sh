#!/bin/bash

install_dir=$1
[[ -z "${install_dir}" ]] && exit 1

cd ${install_dir}
gem install rails -v 5.0.3
rails -v

sudo yum -y install sqlite-devel 
