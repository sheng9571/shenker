#!/bin/sh
htpasswd=/usr/local/squid/passwd
outdir=/opt/data

chmod 755 /usr/local/sbin/gen_auth.py
chmod 755 /usr/local/sbin/squid_start
chmod 755 /usr/local/sbin/squid_stop
chmod 755 /usr/local/sbin/squid_restart

# install squid
# "/usr/local/sbin/install_suqid.sh"
sudo mv /root/squid.conf "${outdir}/squid.conf"

# check file exist or not
if [ -f "${outdir}/squid.conf" ]; then
    :
else
    touch "${outdir}/squid.conf"
fi

sudo rm -f /root/squid.conf
sudo rm -f /usr/local/squid/etc/squid.conf
sudo ln -fs "${outdir}/squid.conf" /usr/local/squid/etc/squid.conf



# squid authenticaton
sudo mv /root/sec_file "${outdir}/sec_file"

if [ -f "${outdir}/sec_file" ]; then
    :
else
    touch "${outdir}/sec_file"
fi

sudo rm -f /root/sec_file
sudo ln -fs "${outdir}/sec_file" /root/sec_file


sudo mv /root/ip_white_list "${outdir}/ip_white_list"

if [ -f "${outdir}/ip_white_list" ]; then
    :
else
    touch "${outdir}/ip_white_list"
fi

sudo rm -f /root/ip_white_list
sudo ln -fs "${outdir}/ip_white_list" /root/ip_white_list

"$(which python2)" /usr/local/sbin/gen_auth.py /root/sec_file $htpasswd



"/usr/local/sbin/squid_start"
