#!/usr/bin/env bash

##################################
# Configure the pre-import options
##################################
#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=20

########################
# include the magic
########################
. ../demo-magic.sh -n


###################################
# Configure the post-import options
###################################
#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${RED}$(kubectl config current-context) ${WHITE}$ "

# hide the evidence
clear
