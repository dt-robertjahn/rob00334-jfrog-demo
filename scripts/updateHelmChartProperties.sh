#!/bin/bash

# https://www.jfrog.com/confluence/display/JFROG/Artifactory+REST+API#ArtifactoryRESTAPI-SetItemProperties

# This script a pipeline 'demo' script that adds JFrog chart properties by calling the JFrog API
# These can be adjusted, but these are the properties added
# deployedOnCluster
# deploymentTimestamp

JFROG_BASE_URL=$1       # https://dtdemos.jfrog.io
JFROG_API_KEY=$2
JFROG_REPO=$3           # art-docker-dynatrace
JFROG_ARTIFACT=$4       # /demoapp/0.1.6 or demoapp-0.1.0.tgz
JFROG_PROPERTIES=$5     # prop1=value1|prop2=value2|prop3=value3
                        # sepererate with a pipe character

TIME=$(date +%s)
JFROG_ARTIFACT_URL=${JFROG_BASE_URL}/api/storage/${JFROG_REPO}/${JFROG_ARTIFACT}?properties=${JFROG_PROPERTIES}
# API expectes %7C for | character
JFROG_ARTIFACT_URL=$(echo $JFROG_ARTIFACT_URL | sed "s/|/\%7C/g")
echo "================================================================="
echo "Updating Helm Chart Properties"
echo "JFROG_REPO       = $JFROG_REPO "
echo "JFROG_ARTIFACT   = $JFROG_ARTIFACT"
echo "JFROG_PROPERTIES = $JFROG_PROPERTIES"
echo "JFROG_FULL_URL   = $JFROG_ARTIFACT_URL"
echo "================================================================="

curl --write-out "Request response code: %{http_code}\n" \
    --silent --location --request PUT ${JFROG_ARTIFACT_URL} \
    --header "Accept:application/json" \
    --header "X-Jfrog-Art-Api:${JFROG_API_KEY}"
