#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y tzdata
gem install bundler -v 2.0.1
# before_install
mysql -u root -e "GRANT ALL ON *.* TO 'travis'@'%';"
wget -N https://chromedriver.storage.googleapis.com/2.35/chromedriver_linux64.zip -P ~/
unzip ~/chromedriver_linux64.zip -d ~/
rm ~/chromedriver_linux64.zip
sudo mv -f ~/chromedriver /usr/local/share/
sudo chmod +x /usr/local/share/chromedriver
sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
# install
bundle install --jobs=3 --retry=3
# script
bundle exec rake test_app
bundle exec rake spec
