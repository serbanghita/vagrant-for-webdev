apt-get update
apt-get upgrade
dpkg --configure -a
dpkg -l amdgpu-pro

apt-get -qqy install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

sudo apt-get install -y gcc g++ make

###################
# Install node.js #
###################
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get install -y nodejs

####################
# Install browsers #
####################
curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
apt-get install -y google-chrome-stable firefox openjdk-8-jre-headless

apt-get install -y xinit xfce4 xfce4-terminal lightdm xserver-xorg-video-amdgpu ubuntu-session
apt-get install -y virtualbox-guest-additions-iso virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms

##################
# Install Docker #
##################
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker vagrant

echo "allowed-users=anybody" >> /etc/X11/Xwrapper.config
echo "needs-root-rights=yes" >> /etc/X11/Xwrapper.config
echo "[SeatDefaults]" >> /etc/lightdm/lightdm.conf
echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
echo "user-session=xfce" >> /etc/lightdm/lightdm.conf
echo "autologin-user=vagrant" >> /etc/lightdm/lightdm.conf
echo "autologin-user-timeout=0" >> /etc/lightdm/lightdm.conf
chmod +x /etc/X11/Xsession
usermod -a -G tty vagrant

###############
# Install IDE #
###############
# curl -# -L -S https://download.jetbrains.com/webstorm/WebStorm-2018.1.4.tar.gz --output WebStorm.tar.gz
# mkdir -p WebStorm && tar xfz WebStorm.tar.gz -C WebStorm --strip-components 1
# chown -R vagrant:vagrant WebStorm
sudo snap install --classic code

updatedb

if [ "$(tty)" = "/dev/tty1" -o "$(tty)" = "/dev/vc/1" ] ; then
    startxfce4
fi