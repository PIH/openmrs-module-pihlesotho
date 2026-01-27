#!/bin/bash

usage () {
    echo -e "Usage: deploy.sh [SERVER]\n"
    echo -e "Runs mvn clean install openmrs-sdk:deploy' for SERVER, where a server is the "
    echo -e "name of an OpenMRS SDK instance at path '~/openmrs/[SERVER]'.\n"
    echo -e "Example: ./deploy.sh mirebalais\n"
}

if [ $# -eq 0 ]; then
    echo -e "Please provide the name of the server to deploy to as a command line argument.\n"
    usage
    exit 1
fi

SERVER_ID=${1}

mvn clean install openmrs-sdk:deploy -Ddistro=distro/target/distro/web/openmrs-distro.properties -DserverId=${SERVER_ID}
rm -fR ~/openmrs/${SERVER_ID}/configuration
cp -a ./configuration/target/openmrs-packager-config/configuration ~/openmrs/${SERVER_ID}/
