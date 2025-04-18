#!/bin/bash
#/bin/bash ./build.sh sz-demo cq-dps-chart2db-front ${ENVIRONMENT}

set -euo pipefail

# Function to print usage message
usage() {
    echo "Usage: /bin/bash build/build.sh <repository> <project> <profile>"
    exit 1
}

# Check if the required commands are installed
command -v docker >/dev/null 2>&1 || {
    echo "docker is not installed"
    exit 1
}

REPOSITORY="$1"
PROFILE="$3"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"
PROJECTNAME=$2
#PROJECTNAME=`git remote -v | head -1 | awk  '{print $2}' | awk -F/ '{print $NF}' | awk -F. '{print $1}'`-$PROFILE
HARBOR="harbor-in.lrhealth.com:9002"


case "$PROFILE" in
    stg)
	PROJECTNAME="$PROJECTNAME"-stg
        ;;
    prod)
        PROJECTNAME="$PROJECTNAME"-prod
        ;;
    uat)
        PROJECTNAME="$PROJECTNAME"-uat
        ;;
    *)
        usage
        ;;
esac

DOCKER_BUILDKIT=1 docker build --build-arg PROFILE="$PROFILE" -t "$REPOSITORY"/"$PROJECTNAME":"$TIMESTAMP" .
if [ $? -ne 0 ]; then
    echo "Docker build failed for project: $PROJECTNAME"
    exit 1
fi

docker tag "$REPOSITORY"/$PROJECTNAME:$TIMESTAMP "$HARBOR"/"$REPOSITORY"/$PROJECTNAME:$TIMESTAMP
if [ $? -ne 0 ];then
        echo "Docker retag failed for project: $PROJECTNAME"
        exit 1
fi

docker push "$HARBOR"/"$REPOSITORY"/$PROJECTNAME:$TIMESTAMP
if [ $? -ne 0 ];then
        echo "Docker push failed for project $PROJECTNAME"
        exit 1
fi

echo "Docker image built successfully for project $PROJECTNAME"


