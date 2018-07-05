# ubuntu 14.04.1
FROM phusion/baseimage:0.9.16

RUN sudo sed -i '1, $s/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list && \
	# update & upgrade & install requirements
	sudo apt-get update && \
    sudo apt-get dist-upgrade -y && \
    # ntp, check time
	sudo apt-get install -y ntp ntpdate && \
    # python2 environment
    sudo apt-get install -y python2.7 python-setuptools python-dev build-essential && \
    # python3 environment
    sudo apt-get install -y python3 python3-setuptools python3-dev python3-pip python3-lxml && \
    # sudo、man、im、tmux、zsh、git、tar、zip、ssh
    sudo apt-get install -y sudo man vim tmux zsh git tar unzip openssh-server && \
    # wget、curl、nc、nmap
    sudo apt-get install -y wget curl nmap && \
    # debug tools
    sudo apt-get install -y gdb ltrace strace && \
    # lxml requirements
    sudo apt-get install -y libxml2-dev libxslt-dev && \
    # x64 run x86 lib
    sudo apt-get install -y gcc-multilib g++-4.8-multilib && \
	# ssh allow root login
	echo 'root:root' | chpasswd && sudo sed -i 's/\#PermitRootLogin\ yes/PermitRootLogin\ yes/g' /etc/ssh/sshd_config && service ssh reload; service ssh start && rm -f /etc/service/sshd/down && /etc/my_init.d/00_regen_ssh_host_keys.sh\
	# set correct time
	export TZ='Asia/Taipei' && \
	sudo /etc/init.d/ntp stop && sudo cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime && sudo ntpdate tw.pool.ntp.org && sudo /etc/init.d/ntp start && \
	# pip2 settings
	sudo easy_install pip && sudo pip2 install --upgrade pip && sudo pip install requests lxml && \
    # pip3 settings
    sudo pip3 install --upgrade pip && sudo pip3 install requests && \
	# set config files
	chsh -s $(which zsh) && cd ~ && git clone --recursive https://github.com/sheng9571/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && make && cd ~ && \
    # install python2 latest version
    # ver="2.7.15" && mkdir -p /tmp/python && cd /tmp/python && \
    # wget https://www.python.org/ftp/python/$ver/Python-$ver.tgz && tar xzf Python-$ver.tgz && \
    # cd /tmp/python/Python-$ver && ./configure --enable-optimizations --prefix=/usr/bin/ && make install && \
    # cd /tmp && rm -rf python && cd ~ && \
    # install python3 latest version
    # ver="3.6.5" && mkdir -p /tmp/python && cd /tmp/python && \
    # wget https://www.python.org/ftp/python/$ver/Python-$ver.tgz && tar xzf Python-$ver.tgz && \
    # cd /tmp/python/Python-$ver && ./configure --enable-optimizations --prefix=/usr/bin/ && make && make install && \
    # cd /tmp && rm -rf python && cd ~ && \
    # Install ctf tools & update
    cd ~ && git clone --recursive https://github.com/sheng9571/ctf_tools ~/.ctf_tools && cd ~/.ctf_tools && echo >> ~/.zshrc && cat ctf_rc >> ~/.zshrc && git submodule update --recursive && git pull --recurse-submodules && git submodule foreach --recursive 'git pull origin master || :' && git submodule foreach --recursive 'git pull origin dev || :' && cd ~ && \
    # Install pwntools
    sudo pip install --upgrade pwntools && \
    # Install uncompyle2
    cd ~/.ctf_tools/uncompyle2 && sudo python setup.py install && cd ~ && \
    # Install RsaCtfTool
    sudo apt install -y libgmp-dev libmpfr-dev libmpc-dev && cd ~/.ctf_tools/RsaCtfTool && sudo pip install -r requirements.txt && cd ~ && \
	# clean
	sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    # show ip
    # ifconfig eth0 2>&- | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'; \
    # ifconfig enp0s31f6 2>&- | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'

EXPOSE 22
