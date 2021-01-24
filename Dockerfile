ARG NODE_VERSION=latest

FROM node:${NODE_VERSION} AS build_container

WORKDIR /workdir

COPY . .

RUN npm install
RUN npm run test
RUN npm run build

FROM node:${NODE_VERSION} AS deploy_container
ARG NODE_ENV=production
RUN echo "*spec.ts" >> .dockerignore

COPY --from=build_container . .
# since NODE_ENV is production, no dev dependencies
# will be intalled in this container
RUN npm install
RUN npm run start