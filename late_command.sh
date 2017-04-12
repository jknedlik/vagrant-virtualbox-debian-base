#!/bin/bash

BASEDIR=$(dirname $0)
vagrant_USER=vagrant


# public ssh key for vagrant user
mkdir -m 0700 /home/$vagrant_USER/.ssh
cp "${BASEDIR}/sshkey.pub" /home/$vagrant_USER/.ssh/authorized_keys
chmod 0600 /home/$vagrant_USER/.ssh/authorized_keys
chown -R $vagrant_USER:$vagrant_USER /home/$vagrant_USER/.ssh

# install sudo config
cp "${BASEDIR}/user.sudo" /etc/sudoers.d/${vagrant_USER}
chmod 0440 /etc/sudoers.d/${vagrant_USER}
chown root:root /etc/sudoers.d/${vagrant_USER}

# display grub timeout and login promt after boot
sed -i \
  -e "s/quiet splash//" \
  -e "s/GRUB_TIMEOUT=[0-9]/GRUB_TIMEOUT=0/" \
  /etc/default/grub
update-grub

# clean up
apt-get clean

/media/cdrom/VBoxLinuxAdditions.run
