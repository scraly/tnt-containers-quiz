#!/bin/bash

########################
# include the magic
########################
. bin/demo-magic.sh

# Pre-requisites: docker

# QUESTION 10

cd gophers-api

pe 'docker build . -t gophers-api:friday'

pe 'docker image ls gophers-api'

# Change golang 1.20 to 1.21
pe 'vi Dockerfile'

pe 'docker build . -t gophers-api:friday'

pe 'docker image ls gophers-api'

pe 'docker images -f dangling=true'

p 'Suppression des dangling images, pour libérer de la place'
pe "docker rmi $(docker images -f dangling=true -q)"

cd ..
