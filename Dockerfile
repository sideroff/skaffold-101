# ARG can be placed before FROM, useful as constants
ARG NODE_VERSION=12.15.0

# FROM - use this as base image, AS - alias
FROM node:${NODE_VERSION}-alpine AS build_container

# WORKDIR - use this as root ( . will equal /workdir )
WORKDIR /workdir

# COPY <host path> <container path>, WORKDIR affects this
# * Turns out, it only affects the second param
COPY . .

# RUN <command> - executes the command in the default bash
RUN npm install
RUN npm run test
RUN npm run build

# this wont work since .dockerignore is not affecting COPY commands
# add a new line
# RUN echo "" >> .dockerignore
# ignore spec files for deploy
# RUN echo "**/*spec.ts" >> .dockerignore

# so until it does, we can use a script
RUN npm run docker-setup


FROM node:${NODE_VERSION} AS deploy_container

# set to production so subsequent node scripts
# such as npm install will only execute whats
# required for production
ARG NODE_ENV=production

# a sort of flag to the docker host that this 
# port will be listened to, does not actually expose
EXPOSE 3000/tcp

WORKDIR /workdir

# COPY doesn't take WORKDIR for --from into account
# but it does take WORKDIR for the current container ???
COPY --from=build_container /workdir .

# since NODE_ENV is production, no dev dependencies
# will be intalled in this container
RUN npm install

# will fail since jest hasn't been installed
# RUN npm run test

# CMD - will run this when we run a container from this image
# start will work because we have the built version from build_container
CMD ["npm", "run", "start"]