#!/bin/bash
#
# This script will update existing action (example bu default) with a docker
# container action (specified as 1st mandatory parameter)

IMAGE=$1
ACTION=${2:-example}

wsk action update --docker $ACTION $IMAGE
