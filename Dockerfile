# ARG can be placed before FROM, useful as constants
ARG NODE_VERSION=12.15.0

# FROM - use this as base image, AS - alias
FROM node:${NODE_VERSION}-alpine AS build_container

# WORKDIR - use this as root ( . will equal /workdir )
WORKDIR /workdir

# COPY <host path> <container path>, WORKDIR affects this
COPY . .

# RUN <command> - executes the command in the default bash
# RUN npm install
# RUN npm run test
# RUN npm run build

# add a new line
RUN echo "" >> .dockerignore
# ignore spec files for deploy
RUN echo "**/*spec.ts" >> .dockerignore

FROM node:${NODE_VERSION} AS deploy_container

WORKDIR /workdir
COPY --from=build_container . .

# ARG NODE_ENV=production

# RUN ls


# since NODE_ENV is production, no dev dependencies
# will be intalled in this container
# RUN npm install
# RUN npm run start