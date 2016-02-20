#!/bin/bash

cd ~

function install() {
    apt-get install -y "$@" >/dev/null 2>&1
}

echo updating package information
sudo apt-get -y update >/dev/null 2>&1

# Install default packages
install build-essential software-properties-common python-software-properties

sudo apt-add-repository -y ppa:nginx/stable >/dev/null 2>&1

# Packages required for compilation of some stdlib modules
install tklib zlib1g-dev libssl-dev libreadline-dev libxml2 libxml2-dev \
libxslt1-dev libmysqlclient-dev libsqlite3-dev nodejs npm git nginx

# START rbenv setup #
sudo -u vagrant git clone git://github.com/sstephenson/rbenv.git ~/.rbenv >/dev/null 2>&1
sudo -u vagrant echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
sudo -u vagrant echo 'eval "$(rbenv init -)"' >> ~/.bashrc
sudo -u vagrant git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build >/dev/null 2>&1
sudo -u vagrant echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
sudo -u vagrant echo 'gem: --no-ri --no-rdoc' >> ~/.gemrc
# END rbenv setup #

# START ruby setup #
sudo -u vagrant -i rbenv install 2.2.3 >/dev/null 2>&1
sudo -u vagrant -i rbenv global 2.2.3 >/dev/null 2>&1
sudo -u vagrant -i rbenv rehash >/dev/null 2>&1
sudo -u vagrant -i ruby -v >/dev/null 2>&1
# END ruby setup #

echo installing rails >/dev/null 2>&1
sudo -u vagrant -i gem install bundler >/dev/null 2>&1
sudo -u vagrant -i gem install rails -v 4.2.4 -N >/dev/null 2>&1
sudo -u vagrant -i rbenv rehash >/dev/null 2>&1

# Add symbolic
sudo ln -s /usr/bin/nodejs /usr/bin/node >/dev/null 2>&1

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 >/dev/null 2>&1
