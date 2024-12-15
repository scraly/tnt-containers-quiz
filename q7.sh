#!/bin/bash

########################
# include the magic
########################
. bin/demo-magic.sh

# hide the evidence
clear

# Pre-requisites: skopeo, distribution registry (https://github.com/distribution/distribution)

# QUESTION 7
p '# Copie de ubi-micro dans la registry OVH'
p 'skopeo login -u sunnytech 79352h8v.c1.de1.container-registry.ovh.net'
skopeo login -u sunnytech -p SunnyTech2024 79352h8v.c1.de1.container-registry.ovh.net
pe 'skopeo copy docker://registry.redhat.io/ubi9/ubi-micro:latest docker://79352h8v.c1.de1.container-registry.ovh.net/public/ubi9/ubi-micro:latest --remove-signatures'
p '# Inspection de l'\''image: Son digest? celui de sa layer principale?'
pe 'skopeo inspect docker://79352h8v.c1.de1.container-registry.ovh.net/public/ubi9/ubi-micro:latest'
digest=`skopeo inspect docker://79352h8v.c1.de1.container-registry.ovh.net/public/ubi9/ubi-micro:latest | jq .Digest | tr -d '"'`
blob_digest=`skopeo inspect docker://79352h8v.c1.de1.container-registry.ovh.net/public/ubi9/ubi-micro:latest | jq .Layers.[0]| tr -d '"'`
p '# Suppression de l'\''image'
pe "curl -X DELETE https://79352h8v.c1.de1.container-registry.ovh.net/v2/public/ubi9/ubi-micro/manifests/$digest"
p '# Verification: le tag existe-t-il encore?'
pe 'skopeo inspect docker://79352h8v.c1.de1.container-registry.ovh.net/public/ubi9/ubi-micro:latest'
p '# Verification: et le blob?'
pe "curl https://79352h8v.c1.de1.container-registry.ovh.net/v2/public/ubi9/ubi-micro/blobs/$blob_digest -o /tmp/blob"
pe 'ls -l /tmp/blob'
