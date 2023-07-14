FROM ruby:3.2.2

# Stage : Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential vim pip libssl-dev sassc && \
  rm -rf /var/lib/apt/lists/*

# Update rubygems
RUN gem update --system

# Stage : Install detect-secrets
RUN pip install detect-secrets --break-system-packages

# Stage setup profile
ARG EXPORT_CONFIG="\
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt\n\
export N_PREFIX=\$HOME/.n\n\
export PATH=\$HOME/.npm/bin:\$HOME/.n/bin:\$HOME/.local/bin:$PATH\n\
export EDITOR=vim\n\
\n\
alias start_server='bundle exec rails s -p \$PORT -b 0.0.0.0'\n\
"
RUN echo $EXPORT_CONFIG >> /etc/profile
RUN echo $EXPORT_CONFIG >> /etc/bash.bashrc

SHELL ["/bin/bash", "-l", "-c"]

# Stage : Install node
ARG NODE_VERSION=20.4.0
RUN apt-get update -qq && apt-get install -y npm && rm -rf /var/lib/apt/lists/*
RUN npm config set prefix $HOME/.npm
RUN npm i -g n
RUN n $NODE_VERSION
RUN npm install --location=global npm@latest
RUN npm config set prefix $HOME/.npm
RUN npm i -g yarn
RUN corepack enable
RUN yarn set version berry
