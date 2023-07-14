FROM ruby:3.2.2-alpine

ARG HOME=/root
ARG NODE_VERSION=20.4.0
ARG EXPORT_CONFIG="\
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt\n\
export N_PREFIX=$HOME/.n\n\
export PATH=$HOME/.npm/bin:$HOME/.n/bin:$HOME/.local/bin:$PATH\n\
export EDITOR=vim\n\
\n\
alias start_server='bundle exec rails s -p $PORT -b 0.0.0.0'\n\
"

RUN echo -e $EXPORT_CONFIG >> $HOME/.profile

SHELL ["/bin/sh", "-l", "-c"]

# Stage : Install dependencies
RUN apk add --no-cache bash git jq nodejs npm vim

# Stage : Install detect-secrets
RUN apk add --no-cache --virtual .detect-secrets-deps py-pip \
  && pip install detect-secrets --break-system-packages \
  && apk del .detect-secrets-deps

# Stage : Install node
RUN npm config set prefix $HOME/.npm
RUN npm i -g n
RUN n $NODE_VERSION
RUN npm install --location=global npm@latest
RUN npm config set prefix $HOME/.npm
RUN npm i -g yarn
RUN corepack enable
RUN yarn set version berry
