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

# Defaults
DO_SETUP=true

# Handling of script CLI options
unset OPTIND
while getopts "s" opt; do
    case $opt in
        s)
            DO_SETUP=false
            ;;
    esac
done

# hide the evidence
clear

if $DO_SETUP; then
    if [[ ! -z $TYPE_SPEED ]]; then
        SAVED_TYPE_SPEED=$TYPE_SPEED
        unset TYPE_SPEED
    fi

    p "# Preparing demo..."

    # starting from scratch
    for vm in cluster1 cluster2; do
        if [[ -d ~/.minikube/machines/${vm} ]]; then
            p "# Existing ${vm}, deleting..."
            pe "minikube delete -p ${vm}"
        fi

        p "# Creating ${vm}..."
        p "minikube start -p ${vm}"
        minikube start -p ${vm}|tee ${vm}_creation.log

    done

    if [[ ! -z $SAVED_TYPE_SPEED ]]; then
        TYPE_SPEED=$SAVED_TYPE_SPEED
    fi

    p "# Done preparing demo, press <enter> to continue..."
    wait
fi

clear


p "# Welcome to the federation demo"
wait

# Save script root directory
SCRIPT_DIR=$(pwd)

if $DO_SETUP; then
    for vm in cluster1 cluster2; do
        p "minikube start -p ${vm}"
        cat ${vm}_creation.log
        wait
    done
fi

if [ ! -d src ]; then
    ln -s $GOPATH/src/github.com/kubernetes-sigs/federation-v2/ src
fi

pe "kubectl config use-context cluster1"
wait

pe "cd src"

if $DO_SETUP; then
    pe "./scripts/deploy-federation-latest.sh cluster2"
    wait
fi

# # show a prompt so as not to reveal our true nature after
# # the demo has concluded
p "# Thanks for watching the demo!"
wait

# Return to script root directory
cd $SCRIPT_DIR
