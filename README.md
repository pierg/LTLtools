# Docker Image for running LTL tools

Tools supported: 
* [strix](https://strix.model.in.tum.de)
* [nuXmv](https://nuxmv.fbk.eu)

###Building commands

`docker buildx create --name mybuilder --use
`

`docker buildx build --platform linux/x86_64,linux/arm/v7 -t username/imagename:tag --push .`

###Running command

`docker run -it --platform linux/x86_64 pmallozzi/ltltools:latest`