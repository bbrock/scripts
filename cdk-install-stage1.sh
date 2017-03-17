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
#
# cdk-install-stage1.sh
#
# Install dependencies for CDK, configure user's vagrant
#	1st stage
#
#       run cdk-install-stage1.sh (this script)
#       run cdk-start.sh and then cleanup any problems
#       run cdk-install-stage2.sh
#
#
# 2017-03-17 - Alpha quality
#

echo "CDK 2.x installation stage 1"

sudo subscription-manager register --auto-attach
sudo subscription-manager repos --enable rhel-server-rhscl-7-rpms
sudo subscription-manager repos --enable rhel-7-server-optional-rpms
mkdir -p ~/tmp/vagrant-install

echo "Installing centos scl repo"
pushd ~/tmp/vagrant-install
wget --recursive --no-directories --no-host-directories http://mirror.centos.org/centos/7/extras/x86_64/Packages/centos-release-scl-2-2.el7.centos.noarch.rpm
rpm2cpio ./centos-release-scl-2-2.el7.centos.noarch.rpm | cpio -idmv
sudo cp etc/yum.repos.d/CentOS-SCLo-scl.repo /etc/yum.repos.d/
sudo cp etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-SIG-SCLo /etc/pki/rpm-gpg/
popd

echo "Installing support packages"
sudo yum groupinstall "Virtualization Host"
# XXX - some of this might be trimmed depending on RHEL (or Fedora) flavor and release
sudo yum groupinstall base, core, virtualization-hypervisor, virtualization-tools
sudo yum install libvirt-devel rpm-build zlib-devel ruby-devel rh-ruby22-ruby-devel gcc-c++

# startup
echo "startup"
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo yum install sclo-vagrant1 sclo-vagrant1-vagrant-libvirt sclo-vagrant1-vagrant-libvirt-doc
sudo cp /opt/rh/sclo-vagrant1/root/usr/share/vagrant/gems/doc/vagrant-libvirt-*/polkit/10-vagrant-libvirt.rules /etc/polkit-1/rules.d
sudo systemctl restart libvirtd
sudo systemctl restart polkit

# give user perms to run vagrant boxes
echo "configuring /etc/group"
echo "groups before install"
grep $USER /etc/group
echo '-----------'
sudo usermod -a -G vagrant $USER
echo "groups after install"
grep $USER /etc/group
echo '-----------'
echo "vagrant group contains:"
grep vagrant /etc/group
echo "id:"
id

echo "installing remaining docker pieces"
vagrant service-manager install-cli docker

echo "scl enable sclo-vagrant1 bash ... spawning shell on container"
scl enable sclo-vagrant1 bash
echo '-----------'
