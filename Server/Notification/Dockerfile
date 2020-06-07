FROM node:13-slim

# Set the work directory
RUN mkdir -p /usr/app
WORKDIR /usr/app

COPY package.json yarn.lock /usr/app/

RUN yarn install --no-progress --frozen-lockfile && yarn cache clean

# CMD [ "yarn", "start" ]

COPY . .