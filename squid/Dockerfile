# ubuntu 18.04
FROM phusion/baseimage:0.11

# environment variable
ENV USER root
ENV TZ 'Asia/Taipei'
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true


# copy script into container
COPY squid.conf /root/
COPY sec_file /root/
COPY ip_white_list /root/
COPY install_suqid.sh /usr/local/sbin/
COPY gen_auth.py /usr/local/sbin/
COPY squid_start /usr/local/sbin/
COPY squid_stop /usr/local/sbin/
COPY squid_restart /usr/local/sbin/
COPY run.sh /etc/my_init.d/


RUN sed -i '1, $s/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list && \
	# update & upgrade & install requirements
	apt-get update && \
    # apt-get dist-upgrade -y && \
    apt-get --force-yes -o Dpkg::Options::="--force-confold" --force-yes -o Dpkg::Options::="--force-confdef" -fuy dist-upgrade && \
    # sudo
    apt-get install -y sudo && \
    # python3 environment
    sudo apt-get install -y python3 python3-setuptools python3-dev python3-pip python3-lxml && \
    # python2 environment
    sudo apt-get install -y python2.7 python-pip python-setuptools python-dev build-essential libssl-dev libffi-dev && \
    # man、vim、tmux、zsh、git、tar、zip、ssh
    sudo apt-get install -y man vim tmux zsh git tar unzip openssh-server && \
    # wget、curl、nc、nmap、net-tools、file
    sudo apt-get install -y wget curl netcat nmap net-tools file kmod iptables dnsmasq iputils-ping && \
	# ssh allow root login
	echo 'root:root' | chpasswd && sudo sed -i 's/\#PermitRootLogin\ yes/PermitRootLogin\ yes/g' /etc/ssh/sshd_config && service ssh reload; service ssh start && rm -f /etc/service/sshd/down && /etc/my_init.d/00_regen_ssh_host_keys.sh\
	# set correct time
	export TZ='Asia/Taipei' && \
	export DEBIAN_FRONTEND=noninteractive && \
    export DEBCONF_NONINTERACTIVE_SEEN=true && \
    sudo apt-get install -y ntpdate && \
    # install tzdata, ntp without interactive
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata ntp && \
    touch /etc/my_init.d/run && \
    echo "#!/bin/sh" >> /etc/my_init.d/run && \
    echo "sudo /etc/init.d/ntp stop ; sudo cp -f /usr/share/zoneinfo/Asia/Taipei /etc/localtime  ; sudo ntpdate TIME4.google.com ; sudo /etc/init.d/ntp start" >> /etc/my_init.d/run && \
    sudo chmod +x /etc/my_init.d/run && \
	# pip2 settings
	sudo pip2 install --upgrade pip && sudo pip install requests lxml numpy && \
    # pip3 settings
    sudo pip3 install --upgrade pip && sudo pip3 install requests && \
	# set config files
	chsh -s $(which zsh) && cd ~ && git clone --recursive https://github.com/sheng9571/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && make && cd ~ && \
    
    
    # lxml requirements
    sudo apt-get install -y libxml2-dev libxslt-dev && \
    
    # copy pip2 to default pip
    sudo cp /usr/local/bin/pip2 /usr/local/bin/pip && \

    # mkdir volumes
    mkdir -p /opt/data && \

    # install squid requirement
    sudo apt-get update && sudo apt-get install -y apache2-utils && \

    # install squid
    chmod 755 /usr/local/sbin/install_suqid.sh && /usr/local/sbin/install_suqid.sh && \

	# clean
	sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# HTTP: 8725 & HTTPS: 9487
EXPOSE 8725
# EXPOSE 8725 9487
