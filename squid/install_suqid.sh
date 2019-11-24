#!/bin/sh
squid=4.9
squid_v1=$(echo ${squid} | cut -d "." -f1)
squid_v2=$(echo ${squid} | cut -d "." -f2)
squid=${squid_v1}.${squid_v2}
http_port=8725
https_port=9487
cert=sheng_CA
out_dir=/opt/data

sudo apt-get update
sudo apt-get install -y build-essential fakeroot devscripts gawk gcc-multilib dpatch libssl-dev openssl squid-langpack ssl-cert libcrypto++-dev
sudo apt-get build-dep -y squid3
cd ~
mkdir squid && cd squid
wget -O squid.tar.xz wget http://www.squid-cache.org/Versions/v${squid_v1}/squid-${squid}.tar.xz
tar -Jxvf squid.tar.xz && mv squid-${squid} squid && rm -f squid.tar.xz && cd squid

# build squid & enable SSL support
./configure --enable-ssl --with-openssl --enable-http-violations --enable-ssl-crtd
make -j$(nproc) && sudo make install
sudo ln -fs /usr/local/squid/sbin/squid /usr/local/bin/

# generate SSL cert
cd /usr/local/squid
sudo mkdir ssl_cert
sudo chown nobody:nogroup ssl_cert
sudo chmod 700 ssl_cert
cd ssl_cert
# This puts the private key and the self-signed certificate in the same file
openssl req -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -keyout ${cert}.pem -out ${cert}.pem -subj "/C=TW/ST=Taipei/L=Taipei/O=Global Security/OU=IT Department/CN=sheng.lab"

# generate certification for client browser
cd /usr/local/squid/ssl_cert
openssl x509 -in ${cert}.pem -outform DER -out ${cert}.der
cp ${cert}.der ~/${cert}.crt
# import this cert into client browser
cp ${cert}.der ${out_dir}/${cert}.der

# create openssl cache folder
sudo mkdir -p /usr/local/squid/var/lib
sudo mkdir -p /usr/local/squid/var/cache/squid/
sudo /usr/local/squid/libexec/security_file_certgen -c -s /usr/local/squid/var/lib/ssl_db -M 4MB
sudo /usr/local/squid/libexec/security_file_certgen -c -s /usr/local/squid/var/cache/squid/ssl_db -M 4MB
sudo chown nobody:nogroup -R /usr/local/squid/var/lib/ssl_db
sudo chown nobody:nogroup -R /usr/local/squid/var/cache/squid/ssl_db

# create log file
sudo mkdir -p /usr/local/squid/var/logs
sudo chmod 777 /usr/local/squid/var/logs
touch /usr/local/squid/var/logs/access.log
touch /usr/local/squid/var/logs/cache.log
touch /usr/local/squid/var/logs/netdb.state
sudo chmod 777 /usr/local/squid/var/logs/*

# setting up squid.conf
# sudo sed -i s/http\_port\ 3128/http\_port\ ${http_port}/g /usr/local/squid/etc/squid.conf
# line=$(sudo sed -n "/http\_port\ ${p}/=" /usr/local/squid/etc/squid.conf)

# clean
cd ~ && rm -rf squid
