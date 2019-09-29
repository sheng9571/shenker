# ubuntu 14.04.5
FROM phusion/baseimage:0.9.16


RUN sed -i '1, $s/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list && \
	# update & upgrade & install requirements
	apt-get update && \
    apt-get --force-yes -o Dpkg::Options::="--force-confold" --force-yes -o Dpkg::Options::="--force-confdef" -fuy dist-upgrade && \
    # sudo
    apt-get install -y sudo && \
    # ntp, check time
	sudo apt-get install -y ntp ntpdate && \
    # python3 environment
    sudo apt-get install -y python3 python3-setuptools python3-dev python3-pip python3-lxml && \
    # python2 environment
    sudo apt-get install -y python2.7 python-setuptools python-dev build-essential libssl-dev libffi-dev && \
    # man、im、tmux、zsh、git、tar、zip、ssh
    sudo apt-get install -y man vim tmux zsh git tar unzip openssh-server && \
    # wget、curl、nc、nmap、net-tools、file
    sudo apt-get install -y wget curl netcat nmap net-tools file && \
	# ssh allow root login
	echo 'root:root' | chpasswd && sudo sed -i 's/\#PermitRootLogin\ yes/PermitRootLogin\ yes/g' /etc/ssh/sshd_config && service ssh reload; service ssh start && rm -f /etc/service/sshd/down && /etc/my_init.d/00_regen_ssh_host_keys.sh\
	# set correct time
	export TZ='Asia/Taipei' && \
    sudo /etc/init.d/ntp stop && sudo cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && sudo ntpdate TIME4.google.com && sudo /etc/init.d/ntp start && \
    # pip3 settings
    sudo pip3 install --upgrade pip && sudo pip3 install requests && \
	# pip2 settings
	sudo easy_install pip && sudo pip2 install --upgrade pip && sudo pip install requests lxml && \
	# set config files
	chsh -s $(which zsh) && cd ~ && git clone --recursive https://github.com/sheng9571/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && make && cd ~ && \
    
    
    # copy pip2 to default pip
    sudo cp /usr/local/bin/pip2 /usr/local/bin/pip && \

    # mkdir volumes
    mkdir /root/data && \

	# clean
	sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    # show ip
    # ifconfig eth0 2>&- | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'; \
    # ifconfig enp0s31f6 2>&- | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'

EXPOSE 22
