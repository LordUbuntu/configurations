#!/usr/bin/bash
# system setup script

echo """

######################
# SETTING UP POP_OS! #
######################

"""

echo """

#####################
# SETTING UP SYSTEM #
#####################

"""
# setup of system specifics goes here


echo """

#####################
# SETTING UP COMMON #
#####################

"""
# setup common system environment
pushd ../common >/dev/null
source setup.sh
popd >/dev/null
