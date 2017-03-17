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
# cdk-start.sh
#
# start vagrant
#
#
#       run cdk-install-stage1.sh before this
#       run cdk-start.sh and then cleanup any problems (this script)
#       run cdk-install-stage2.sh
#
#
# 2017-03-17 - Alpha quality
#


echo "Starting vagrant and spawning shell"

echo "scl enable sclo-vagrant1 bash"
scl enable sclo-vagrant1 bash
