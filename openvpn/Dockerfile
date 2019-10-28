# ubuntu 18.04
FROM phusion/baseimage:0.11

ARG easyrsa
ARG proto
ARG remote
ARG r_port

# environment variable
ENV USER root
ENV TZ 'Asia/Taipei'
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true


# copy script into container
COPY openvpn_setting /usr/bin/
COPY network_settings /usr/bin/
COPY gen_server_conf /usr/bin/
COPY gen_client_conf /usr/bin/
COPY get_client_conf /usr/bin/
COPY verify.py /usr/bin/
COPY gen_account.py /usr/bin/
COPY openvpn_start /usr/bin/
COPY openvpn_stop /usr/bin/
COPY openvpn_restart /usr/bin/
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
    sudo chmod +x /etc/my_init.d/run.sh && \
	# pip2 settings
	sudo pip2 install --upgrade pip && sudo pip install requests lxml numpy && \
    # pip3 settings
    sudo pip3 install --upgrade pip && sudo pip3 install requests && \
	# set config files
	chsh -s $(which bash) && cd ~ && git clone --recursive https://github.com/sheng9571/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && make && cd ~ && \
    
    
    # lxml requirements
    sudo apt-get install -y libxml2-dev libxslt-dev && \
    
    # copy pip2 to default pip
    sudo cp /usr/local/bin/pip2 /usr/local/bin/pip && \

    # mkdir volumes
    mkdir -p /opt/data && \

    # replace ip alias to null
    sudo sed -i s/alias\ ip\=\'curl\ ifconfig\.co\'//g ~/.bashrc && \
    sudo sed -i s/alias\ ip\=\'curl\ ifconfig\.co\'//g ~/.zshrc && \

    # install openvpn
    sudo apt-get install -y openvpn && sudo mkdir -p /etc/openvpn && \
    # install easyrsa
    cd /root && wget -O easyrsa.tgz https://github.com/OpenVPN/easy-rsa/releases/download/v${easyrsa}/EasyRSA-${easyrsa}.tgz && tar -zxvf easyrsa.tgz && mv EasyRSA-${easyrsa} easyrsa && rm -f easyrsa.tgz && \
    # setting OpvnVPN setting from docker-compose.yml
    sudo sed -i s/"\"\/usr\/bin\/gen\_server\_conf\""/"\"\/usr\/bin\/gen\_server\_conf\""\ \-p\ ${proto}/g /etc/my_init.d/run.sh && \
    sudo sed -i s/"\"\/usr\/bin\/get\_client\_conf\""/"\"\/usr\/bin\/get\_client\_conf\""\ \-r\ ${remote}\ \-p\ ${r_port}/g /etc/my_init.d/run.sh && \

	# clean
	sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 5287
