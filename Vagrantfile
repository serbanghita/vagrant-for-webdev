# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/home/vagrant/www", owner: "vagrant", group: "vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  	vb.customize ["modifyvm", :id, "--cpus", "2"]
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
  
    # Customize the amount of memory on the VM:
    vb.memory = "2048"

    vb.customize ["modifyvm", :id, "--vram", "256"]

    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # config.vm.provision :shell, privileged: true, inline: <<-SHELL
  #   apt-get update
  #   apt-get install git unzip curl libxss1 ubuntu-desktop gnome-terminal indicator-session unity-lens-applications --yes --no-install-recommends
  # SHELL
  # config.vm.provision :shell, privileged: false, inline: <<-SHELL
  #   mkdir -p ~/.config/autostart
  #   mkdir -p ~/.ssh
  #   echo -e "Host *\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
  #   echo -e "[Desktop Entry]\nType=Application\nExec=gnome-terminal --working-directory="/home/vagrant"\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enable=true\nName[en_US]=Terminal\nName=Terminal\nComment[en_US]=\nComment=\n" > ~/.config/autostart/gnome-terminal.desktop
  #   sudo sed -ie '/^XKBLAYOUT=/s/".*"/"it"/' /etc/default/keyboard && udevadm trigger --subsystem-match=input --action=change
  # SHELL

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

  config.vm.provision "shell", inline: <<-SHELL
  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

  apt-get update
	apt-get upgrade
	dpkg --configure -a
	dpkg -l amdgpu-pro

	apt-get -qqy install apt-transport-https ca-certificates curl software-properties-common

	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	apt-get install -y nodejs

	curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
	echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

	apt-get install -y google-chrome-stable firefox openjdk-8-jre-headless

	apt-get install -y xinit xfce4 xfce4-terminal lightdm xserver-xorg-video-amdgpu ubuntu-session

	apt-get install -y virtualbox-guest-additions-iso virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms

    apt-get install docker-ce

	echo "allowed-users=anybody" >> /etc/X11/Xwrapper.config
	echo "needs-root-rights=yes" >> /etc/X11/Xwrapper.config
	echo "[SeatDefaults]" >> /etc/lightdm/lightdm.conf
	echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
	echo "user-session=xfce" >> /etc/lightdm/lightdm.conf
	echo "autologin-user=vagrant" >> /etc/lightdm/lightdm.conf
	echo "autologin-user-timeout=0" >> /etc/lightdm/lightdm.conf
	chmod +x /etc/X11/Xsession

	usermod -a -G tty vagrant

	curl -# -L -S https://download.jetbrains.com/webstorm/WebStorm-2018.1.4.tar.gz --output WebStorm.tar.gz
	mkdir -p WebStorm && tar xfz WebStorm.tar.gz -C WebStorm --strip-components 1
	chown -R vagrant:vagrant WebStorm

	updatedb

	if [ "$(tty)" = "/dev/tty1" -o "$(tty)" = "/dev/vc/1" ] ; then
  		startxfce4
	fi
  SHELL
end
