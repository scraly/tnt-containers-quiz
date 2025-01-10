#!/bin/bash

########################
# include the magic
########################
. bin/demo-magic.sh

# hide the evidence
clear

# Pre-requisites: docker

# QUESTION 10

cd gophers-api

p "Build d'une image"
pe 'docker build . -t gophers-api:friday'

pe 'docker image ls gophers-api'

p "Changement de golang 1.20 vers 1.21"
pe 'vi Dockerfile'

pe 'docker build . -t gophers-api:friday'

pe 'docker image ls gophers-api'

pe 'docker images -f dangling=true'

p "Suppression des dangling images, pour libérer de la place"
pe "docker rmi \$(docker images -f dangling=true -q)"

p "/!\ Docker only - Les dangling images n'existent pas avec containerd en image store"

cd ..
