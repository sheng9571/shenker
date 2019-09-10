# ubuntu 16.04.5
FROM phusion/baseimage:0.9.22

ARG display
ARG novnc
ARG websockify

# environment variable
ENV USER root
ENV DISPLAY ${display}.0


# copy script into container
COPY adbi /usr/local/bin/
COPY build_qemu.sh /usr/local/bin/
COPY dhcp_start.sh /usr/local/bin/
COPY dhcp_stop.sh /usr/local/bin/
COPY dhcp_restart.sh /usr/local/bin/
COPY network.sh /usr/local/bin/
COPY qemu-ifdown /etc/
COPY qemu-ifup /etc/
COPY run.sh /etc/my_init.d/
COPY vm_ip /usr/local/bin/
COPY vm_prepare.sh /usr/local/bin/
COPY vm_restart.sh /usr/local/bin/
COPY vm_start.sh /usr/local/bin/
COPY vm_stop.sh /usr/local/bin/
COPY vnc_restart.sh /usr/local/bin/
COPY vnc_start.sh /usr/local/bin/
COPY vnc_stop.sh /usr/local/bin/


RUN sed -i '1, $s/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list && \
	# update & upgrade & install requirements
	apt-get update && \
    # apt-get dist-upgrade -y && \
    apt-get --force-yes -o Dpkg::Options::="--force-confold" --force-yes -o Dpkg::Options::="--force-confdef" -fuy dist-upgrade && \
    # sudo
    apt-get install -y sudo && \
    # ntp, check time
	sudo apt-get install -y ntp ntpdate && \
    # python3 environment
    sudo apt-get install -y python3 python3-setuptools python3-dev python3-pip python3-lxml && \
    # python2 environment
    sudo apt-get install -y python2.7 python-setuptools python-dev build-essential libssl-dev libffi-dev && \
    # man、vim、tmux、zsh、git、tar、zip、ssh
    sudo apt-get install -y man vim tmux zsh git tar unzip openssh-server && \
    # wget、curl、nc、nmap、net-tools、file
    sudo apt-get install -y wget curl netcat nmap net-tools file kmod iptables dnsmasq iputils-ping && \
	# ssh allow root login
	echo 'root:root' | chpasswd && sudo sed -i 's/\#PermitRootLogin\ yes/PermitRootLogin\ yes/g' /etc/ssh/sshd_config && service ssh reload; service ssh start && rm -f /etc/service/sshd/down && /etc/my_init.d/00_regen_ssh_host_keys.sh\
	# set correct time
	export TZ='Asia/Taipei' && \
    # install tzdata without interactive
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y tzdata && \
    touch /etc/my_init.d/run && \
    echo "#!/bin/sh" >> /etc/my_init.d/run && \
    echo "sudo /etc/init.d/ntp stop ; sudo cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime  ; sudo ntpdate TIME4.google.com ; sudo /etc/init.d/ntp start" >> /etc/my_init.d/run && \
    sudo chmod +x /etc/my_init.d/run && \
	# pip2 settings
	sudo easy_install pip && sudo pip2 install --upgrade pip && sudo pip install requests lxml numpy && \
    # pip3 settings
    sudo pip3 install --upgrade pip && sudo pip3 install requests && \
	# set config files
	chsh -s $(which bash) && cd ~ && git clone --recursive https://github.com/sheng9571/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && make && cd ~ && \
    
    
    # Install cross lib
    # sudo apt-get install -y libc6-armel-cross libc6-armhf-cross libc6-arm64-cross libc6-mipsel-cross libc6-mips-cross libc6-mips64-cross libc6-mips64el-cross libc6-mipsn32-mips64-cross libc6-mipsn32-mips64el-cross && \
    # lxml requirements
    sudo apt-get install -y libxml2-dev libxslt-dev && \
    
    # copy pip2 to default pip
    sudo cp /usr/local/bin/pip2 /usr/local/bin/pip && \

    # mkdir volumes
    mkdir /root/data && \

    # replace ip alias to null
    sudo sed -i s/alias\ ip\=\'curl\ ifconfig\.co\'//g ~/.bashrc && \
    sudo sed -i s/alias\ ip\=\'curl\ ifconfig\.co\'//g ~/.zshrc && \

    # install aosp requirement
    sudo apt-get install -y openjdk-8-jdk libx11-dev libreadline6-dev libgl1-mesa-dev g++-multilib git flex bison gperf build-essential libncurses5-dev tofrodos python-markdown libxml2-utils xsltproc zlib1g-dev dpkg-dev libsdl1.2-dev libesd0-dev git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev libgl1-mesa-dev libxml2-utils xsltproc unzip m4 lib32z-dev ccache && sudo update-alternatives --config java && touch /bin/repo && curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo && chmod a+x /bin/repo && cd ~ && mkdir source && \


    # install noVNC
    cd ~ && wget -nv -O novnc.zip "https://github.com/novnc/noVNC/archive/v${novnc}.zip" && unzip novnc.zip && mv noVNC-${novnc} novnc && rm -f novnc.zip && wget -nv -O websockify.zip "https://github.com/novnc/websockify/archive/v${websockify}.zip" && unzip websockify.zip && mv websockify-${websockify} ./novnc/utils/websockify && rm -f websockify.zip && ln novnc/vnc.html novnc/index.html && \

    # install & setting x11vnc
    sudo apt-get install -y xvfb x11vnc openbox fluxbox menu xterm && \
    # export DISPLAY=:44.0 &
    # /root/novnc/utils/launch.sh --listen 9287 --vnc localhost:5900 &
    # Xvfb :44 -ac &
    # x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :44 -nopw -wait 5 -shared -permitfiletransfer -tightfilexfer -forever -loop -repeat -rfbport 5900 &
    # fluxbox

    # install adb
    sudo apt-get install -y android-tools-adb android-tools-fastboot && \
    
    
    # Install QEMU
    cd ~ && /usr/local/bin/build_qemu.sh && \

    # prepare all files that vm needed
    cd ~ && /usr/local/bin/vm_prepare.sh && \

	# clean
	sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22 9287
