#!/bin/sh
#
# Copyright (c) 2017 Red Hat, Inc. All rights reserved. This copyrighted material 
# is made available to anyone wishing to use, modify, copy, or
# redistribute it subject to the terms and conditions of the GNU General
# Public License v.2.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#
#
# Author: Brian Brock <bbrock@redhat.com>
#
#
# fixup.sh
#
# Tweaks a machine post-install to have the basics that I like on every 
# test system.
#
# Much of the functionality varies with RHEL or Fedora version, but those 
# details aren't here yet.  It's presumed that all of the directories exist 
# and are populated.  Most of this is just personal taste.
#
# Most useful if you're frequently (re)installing RHEL and need 
# functionality outside kickstart.ks
#
# If you're using this, you should really try to move the functionality you 
# need to a kickstart file (or similar higher-level tool).
#
#



basedir=~/setup
version=$(rpm -qf --queryformat="%{VERSION}" /etc/redhat-release | sed -e 's/^\([[:digit:]]\).*/\1/')


if [ -e ${basedir}/${version}/repos.d/*.repo ] ; then
	echo "Installing repos..."
	/bin/ls $(basename ${basedir}/${version}/repos.d/*.repo) 2>/dev/null
	sudo cp -n ${basedir}/${version}/repos.d/*.repo /etc/yum.repos.d 2>/dev/null
	echo
fi

echo "Installing test support packages..."
if [ -e ${basedir}/${version}/rpms/*.rpm ] ; then
	sudo yum --skip-broken install ${basedir}/${version}/rpms/*.rpm 
fi
sudo yum --skip-broken -q install xorg-x11-xauth vim-enhanced yum-plugin-changelog

echo "...done."

# earlier, needed to disable firewall when testing something. I might re-enable this later.
#echo -n "Disabling firewall... "
#if [ $version = 7 ] ; then
#	echo "...disabling firewalld"
#	systemctl stop firewalld
#	systemctl disable firewalld
#else
#	echo "...disabling iptables"
#	iptables -F
#	service iptables stop
#	chkconfig iptables off
#fi
#echo

if [ -e ${basedir}/${version}/run.d/* ] ; then
	echo "Running addons..."
	for ii in ${basedir}/${version}/run.d/* ; do
		echo "...running $ii"
		$ii
		echo "-----"
		echo
	done
fi


echo "reconfiguring boot and apps..."
sudo sed -i 's/\(FONT.*\)/#\1/' /etc/vconsole.conf
echo "FONT=t" >> /etc/vconsole.conf
sudo sed -i -e 's/rhgb quiet//g' /boot/efi/EFI/fedora/grub.cfg
sudo sed -i -e 's/vconsole.font=".*"/vconsole.font=t/g' /boot/efi/EFI/fedora/grub.cfg
echo "\tCHECK /boot/efi/EFI/fedora/grub.cfg"
cat >> ~/.config/Terminal/terminalrc << EOF
ColorForeground=White
ColorBackground=Black
EOF
echo "...done"
