next js is used just as a blueprint for an app that would need to be built, tested, and ran

# Docker

## Build image

run `docker build --tag:<name:version> .`  
example for `<name:version>` - `next-app:1.0`

## Start a container with that image

`docker run --publish <host_port>:3000 <name:version>`  
where `<name:version>` is the same you used for the build command  
and `<host_port>` is the port you want the app to listen to outside the container

## Open localhost:<host_port>
