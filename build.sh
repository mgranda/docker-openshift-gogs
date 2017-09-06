#!/bin/bash
docker build . -t wkulhanek/gogs:latest
docker tag wkulhanek/gogs:latest wkulhanek/gogs:11.29
docker push wkulhanek/gogs:latest
docker push wkulhanek/gogs:11.29
