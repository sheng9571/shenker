# ubuntu 18.04.5
FROM phusion/baseimage:0.11

ARG gdb_version

RUN sed -i '1, $s/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list && \
	# update & upgrade & install requirements
	apt-get update && \
    apt-get --force-yes -o Dpkg::Options::="--force-confold" --force-yes -o Dpkg::Options::="--force-confdef" -fuy dist-upgrade && \
    # sudo
    apt-get install -y sudo && \
	# set correct time, install ntp, ntpdate tzdata check time
	export TZ='Asia/Taipei' && \
    export DEBIAN_FRONTEND=noninteractive && \
    export DEBCONF_NONINTERACTIVE_SEEN=true && \
    sudo apt-get install -y ntpdate && \
    # install tzdata, ntp without interactive
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata ntp && \
    touch /etc/my_init.d/run && \
    echo "#!/bin/sh" >> /etc/my_init.d/run && \
    echo "sudo /etc/init.d/ntp stop ; sudo cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime  ; sudo ntpdate TIME4.google.com ; sudo /etc/init.d/ntp start" >> /etc/my_init.d/run && \
    sudo chmod +x /etc/my_init.d/run && \
    # python3 environment
    sudo apt-get install -y python3 python3-setuptools python3-dev python3-pip python3-lxml && \
    # python2 environment
    sudo apt-get install -y python2.7 python-pip python-setuptools python-dev build-essential libssl-dev libffi-dev python-pip && \
    # ruby
    sudo apt-get install -y ruby && \
    # man、im、tmux、zsh、git、tar、zip、ssh
    sudo apt-get install -y man vim tmux zsh git tar unzip openssh-server && \
    # wget、curl、nc、nmap、net-tools、
    sudo apt-get install -y wget curl netcat nmap net-tools file && \
    # debug tools
    sudo apt-get install -y ltrace strace nasm && \
    # x64 run x86 lib
    sudo apt-get install -y gcc-multilib g++-4.8-multilib && \
	# ssh allow root login
	echo 'root:root' | chpasswd && sudo sed -i 's/\#PermitRootLogin\ yes/PermitRootLogin\ yes/g' /etc/ssh/sshd_config && service ssh reload; service ssh start && rm -f /etc/service/sshd/down && /etc/my_init.d/00_regen_ssh_host_keys.sh\
    # pip3 settings
    sudo pip3 install --upgrade pip && sudo pip3 install requests && \
	# pip2 settings
	sudo pip2 install --upgrade pip && sudo pip install requests lxml && \
	# set config files
	chsh --shell $(which zsh) && cd ~ && git clone --recursive https://github.com/sheng9571/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && make && cd ~ && \
    
    
    # Install ctf tools & update
    cd ~ && git clone --recursive https://github.com/sheng9571/ctf_tools ~/.ctf_tools && cd ~/.ctf_tools && echo >> ~/.zshrc && cat ctf_rc >> ~/.zshrc && cat ctf_rc >> ~/.bashrc && git submodule update --init --recursive && cd ~ && \
    # Create tools folder
    mkdir -p ~/tools/crypto && mkdir -p ~/tools/reverse && \

    # Install PWN Tool
    # Install GDB
    cd ~ && mkdir -p /usr/local/bin/gdb && sudo apt-get install -y texinfo libncurses-dev libreadline-dev python-dev bison && wget https://ftp.gnu.org/gnu/gdb/gdb-${gdb_version}.tar.xz && tar -Jxvf gdb-${gdb_version}.tar.xz && cd gdb-${gdb_version} && ./configure --prefix=/usr/local/bin/gdb --enable-targets=all --enable-64-bit-bfd --with-python="$(which python3)" --with-system-readline --enable-tui && sudo make -j8 && sudo make install && export PATH=$PATH:/usr/local/bin/gdb/bin && cd ~ && rm -rf gdb-${gdb_version} gdb-${gdb_version}.tar.xz && sudo ln -fs /usr/local/bin/gdb/bin/gdb /usr/bin/gdb && sudo ln -fs /usr/local/bin/gdb/bin/gdbserver /usr/bin/gdbserver && \
    # Install pwntools
    sudo pip2 install --upgrade pwntools && \
    # Install radare2
    mv ~/.ctf_tools/radare2 /opt/ && \
    cd /opt/radare2/sys/ && ./install.sh && cd ~ && \
    # Install qira
    # tar -zxvf ~/.ctf_tools/qira/qira-1.2.tar.gz -C ~/ && cd ~/qira-1.2 && ./install.sh && cd ~ && \
    # Install gdb plugins
    cp -rf ~/.ctf_tools/gdb ~/ && \
    # Install gef
    cp -f ~/.ctf_tools/gef/gef.py ~/gdb/ && \
    # Update checksec
    wget -vO ~/.ctf_tools/checksec/chsec https://github.com/slimm609/checksec.sh/raw/master/checksec && chmod +x ~/.ctf_tools/checksec/chsec && cp ~/.ctf_tools/checksec/chsec /usr/local/bin/chsec && \
    # Install ROPGadget
    sudo pip2 install capstone && sudo pip install --upgrade ropgadget && \
    # Install one_gadget
    sudo gem install one_gadget && \
    # Install QEMU
    sudo apt-get install -y binfmt-support pkg-config libglib2.0-dev libpixman-1-dev flex bison && cd ~/.ctf_tools/qemu && git submodule update --init --recursive && ./configure --prefix=$(cd ..; pwd)/qemu-user-static --static --disable-system --enable-linux-user --enable-debug --target-list=i386-linux-user,x86_64-linux-user,arm-linux-user,aarch64-linux-user,mips-linux-user,mipsel-linux-user,mips64-linux-user,mips64el-linux-user && sudo make -j8 && sudo make install && cd ../qemu-user-static/bin && for i in *; do mv $i $i-static; done && mkdir /usr/local/bin/qemu && cp -rf * /usr/local/bin/qemu && export PATH=$PATH:/usr/local/bin/qemu && cd ~ && \
    # Install cross lib
    sudo apt-get install -y libc6-armel-cross libc6-armhf-cross libc6-arm64-cross libc6-mipsel-cross libc6-mips-cross libc6-mips64-cross libc6-mips64el-cross libc6-mipsn32-mips64-cross libc6-mipsn32-mips64el-cross && \
    # lxml requirements
    sudo apt-get install -y libxml2-dev libxslt-dev && \

    # Install Reverse Tool
    # Install angr
    sudo pip2 install angr && \
    # Install z3
    cd ~/.ctf_tools/z3 && sudo python2 scripts/mk_make.py && cd build && make && sudo make install && \
    # Install afl
    tar -zxvf ~/.ctf_tools/afl/afl.tar.gz -C ~/ && cd ~/afl && make && sudo make install && cd ~ && rm -rf afl && \
    # Install intel pin tool
    tar -zxvf ~/.ctf_tools/pin/pin.tar.gz -C /opt/ && cd ~/ && ln -s /opt/pin/pin /usr/local/bin/pin && \
    # Install intel sde (software development emulator)
    tar -zxvf ~/.ctf_tools/sde/sde.tar.gz -C /opt/ && cd ~/ && ln -fs /opt/sde/sde /usr/local/bin/sde && ln -fs /opt/sde/sde64 /usr/local/bin/sde64 && \
    # Install uncompyle2
    cd ~/.ctf_tools/uncompyle2 && sudo python2 setup.py install && cd ~ && cp -f ~/.ctf_tools/uncompyle2/scripts/uncompyle2 ~/tools/reverse/ && \

    # Install Crypto Tool
    # Install RsaCtfTool
    sudo apt install -y libgmp-dev libmpfr-dev libmpc-dev python3-gmpy2 && cd ~/.ctf_tools/RsaCtfTool && sudo pip3 install -r requirements.txt && sudo pip3 install --upgrade pycrypto && cd ~ && cp -f ~/.ctf_tools/RsaCtfTool/*.py ~/tools/crypto/ && \
    # Install rsatool
    cd ~/.ctf_tools/rsatool && sudo python2 setup.py install && cd ~ && cp -f ~/.ctf_tools/rsatool/rsatool.py ~/tools/crypto/ && \

    # Install Misc Tool
    # Install binwalk
    cd ~/.ctf_tools/binwalk && sudo python setup.py install && sudo apt-get install -y python-lzma && cd ~ && \
    # Install sasquatch (to extract non-standard SquashFS images)
    cd ~/.ctf_tools/sasquatch && sudo apt-get install -y build-essential liblzma-dev liblzo2-dev zlib1g-dev && sudo ./build.sh && cd ~ && \
    # ExifTool
    sudo apt-get install -y libimage-exiftool-perl && \
    # pngcheck
    sudo apt-get install -y pngcheck && \
    # zsteg
    sudo gem install zsteg && \


    # Install my own scripts
    cp -rf ~/.ctf_tools/my_tools ~/tools/ && \
    cp -rf ~/.ctf_tools/pyobd ~/tools/my_tools/ && \
    
    # copy pip2 to default pip
    sudo cp /usr/local/bin/pip2 /usr/local/bin/pip && \

    # mkdir volumes
    mkdir /root/ctf && \

    # fix some bugs in update tools
    sudo sed -i s/sudo\ apt\-get\ install\ \-y\ ruby\ \&\&\ sudo\ gem\ install\ rubygems\-update\ \&\&\ sudo\ update\_rubygems\ \&\&\ sudo\ gem\ install\ rake\ \-v\ 12\.2\.1\ \&\&\ sudo\ gem\ install\ rainbow\ \-v\ 2\.2\.2\ \&\&\ //g ~/tools/my_tools/upall.sh && \

	# clean
    rm -rf ~/.ctf_tools && \
	sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    # show ip
    # ifconfig eth0 2>&- | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'; \
    # ifconfig enp0s31f6 2>&- | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'

EXPOSE 22 3002
