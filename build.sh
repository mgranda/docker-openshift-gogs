#!/bin/bash
export VERSION=11.91
docker build . -t quay.io/gpte-devops-automation/gogs:${VERSION}
docker tag quay.io/gpte-devops-automation/gogs:${VERSION} quay.io/gpte-devops-automation/gogs:latest
docker push quay.io/gpte-devops-automation/gogs:${VERSION}
docker push quay.io/gpte-devops-automation/gogs:latest
git tag ${VERSION}
git push origin ${VERSION}
