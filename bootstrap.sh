#!/bin/bash

cd ~

echo updating package information >/dev/null 2>&1
sudo apt-add-repository -y ppa:nginx/stable >/dev/null 2>&1
sudo apt-get -y update >/dev/null 2>&1

sudo apt-get install -y build-essential >/dev/null 2>&1
sudo apt-get install -y software-properties-common >/dev/null 2>&1 
sudo apt-get install -y python-software-properties >/dev/null 2>&1

# Packages required for compilation of some stdlib modules
sudo apt-get install -y tklib zlib1g-dev libssl-dev >/dev/null 2>&1
sudo apt-get install -y libreadline-dev >/dev/null 2>&1
sudo apt-get install -y libxml2 libxml2-dev libxslt1-dev libmysqlclient-dev >/dev/null 2>&1
sudo apt-get install -y libsqlite3-dev >/dev/null 2>&1
sudo apt-get install -y nodejs npm git >/dev/null 2>&1
sudo apt-get install -y nginx >/dev/null 2>&1

# START rbenv setup #
touch ~/.bash_profile
sudo -u vagrant git clone git://github.com/sstephenson/rbenv.git ~/.rbenv >/dev/null 2>&1
sudo -u vagrant echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
sudo -u vagrant echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
sudo -u vagrant git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build >/dev/null 2>&1
sudo -u vagrant echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
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
