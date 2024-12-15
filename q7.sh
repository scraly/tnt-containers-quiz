#!/bin/bash

########################
# include the magic
########################
. bin/demo-magic.sh

# hide the evidence
clear

# Pre-requisites: skopeo, distribution registry (https://github.com/distribution/distribution)

# QUESTION 7
p '# Copie de l'image ubi-micro dans la registry locale'
pe 'skopeo copy docker://registry.redhat.io/ubi9/ubi-micro:latest docker://sherinefedora:5000/ubi9/ubi-micro:latest'
p '# Inspection de l'image: Son digest? celui de sa layer principale?'
pe 'skopeo inspect docker://sherinefedora:5000/ubi9/ubi-micro:latest'
digest=`skopeo inspect docker://sherinefedora:5000/ubi9/ubi-micro:latest | jq .Digest | tr -d '"'`
blob_digest=`skopeo inspect docker://sherinefedora:5000/ubi9/ubi-micro:latest | jq .Layers.[0]| tr -d '"'`
p '# Suppression de l'image'
pe "curl -X DELETE https://sherinefedora:5000/v2/ubi9/ubi-micro/manifests/$digest"
p '# Verification: le tag existe-t-il encore?'
pe 'skopeo inspect docker://sherinefedora:5000/ubi9/ubi-micro:latest'
p '# Verification: et le blob?'
pe "curl https://sherinefedora:5000/v2/ubi9/ubi-micro/blobs/$blob_digest -o /tmp/blob"
pe 'ls -l /tmp/blob'
