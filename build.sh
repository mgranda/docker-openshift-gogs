#!/bin/bash
export VERSION=11.79
docker build . -t wkulhanek/gogs:${VERSION}
docker tag wkulhanek/gogs:${VERSION} wkulhanek/gogs:latest
docker push wkulhanek/gogs:${VERSION}
docker push wkulhanek/gogs:latest
git tag ${VERSION}
git push origin ${VERSION}
