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
# cdk-install-stage2.sh
#
# Install CDK 2.x vagrant box
#	2nd stage
#
# 	run cdk-install-stage1.sh before this
#	run cdk-start.sh and then cleanup any problems
#	run cdk-install-stage2.sh
#
#
# 2017-03-17 - Alpha quality
#

echo "CDK 2.x installation stage 2"

# last commands run:
#echo "scl enable sclo-vagrant1 bash"
#scl enable sclo-vagrant1 bash
#echo '-----------'
echo "vagrant global-status:"
vagrant global-status
echo '-----------'


# install and configure vagrant boxes
pushd $HOME/cdk
unzip cdk*.zip

pushd cdk/plugins
ls -l *.gem
vagrant plugin install ./vagrant-registration-*.gem ./vagrant-service-manager-*.gem ./vagrant-sshfs-*.gem
echo "installed vagrant plugins:"
vagrant plugin list
popd

echo "adding vagrant box"

pushd install
export BOX="cdkv2"
vagrant box add --name $BOX ./rhel-cdk-kubernetes-7*.x86_64.vagrant-libvirt.box
echo '----------'
echo "vagrant box list"
vagrant box list
popd

echo "Installation complete!"
