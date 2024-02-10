# Adapted from https://github.com/timbru31/docker-ruby-node/blob/master/2.7/16/Dockerfile
# Using dependency references from https://pages.github.com/versions/

# 2.7.4 is GitHub Pages 229 compatible
ARG RUBY_VERSION=2.7.4

FROM ruby:${RUBY_VERSION}

# NOTE: These args need to stay below the FROM line in order for Docker to recognize them.
ARG BUILD_DATE
ARG VCS_REF
ARG GH_PAGES_VERSION=229
ARG NODE_MAJOR_VERSION=20
# Bundler 2.4.x is the last to support ruby < 3.0.0
ARG BUNDLER_VERSION=2.4.22

RUN echo "RUBY_VERSION=${RUBY_VERSION}"
RUN echo "BUNDLER_VERSION=${BUNDLER_VERSION}"
RUN echo "BUILD_DATE=${BUILD_DATE}"
RUN echo "VCS_REF=${VCS_REF}"
RUN echo "GH_PAGES_VERSION=${GH_PAGES_VERSION}"
RUN echo "NODE_MAJOR_VERSION=${NODE_MAJOR_VERSION}"

# Label Reference: https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.title="Blog-in-a-box Container"
LABEL org.opencontainers.image.description="The container used by blog-in-a-box. Ruby, node, jekyll, and necessary packages."
LABEL org.opencontainers.image.url="https://github.com/excellalabs/blog-in-a-box-container"
LABEL org.opencontainers.image.documentation="https://github.com/excellalabs/blog-in-a-box-container"
LABEL org.opencontainers.image.source="https://github.com/excellalabs/blog-in-a-box"
LABEL org.opencontainers.image.revision="${VCS_REF}"
LABEL org.opencontainers.image.vendor="Sean Killeen"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.authors="Sean Killeen <SeanKilleen@gmail.com>"

LABEL ruby_version="${RUBY_VERSION}"
LABEL gh_pages_version="${GH_PAGES_VERSION}"
LABEL node_major_version="${NODE_MAJOR_VERSION}"

VOLUME /docs
WORKDIR /docs

######################################################
#             Installling Base + Ruby Stuff          #
######################################################

RUN apt-get -y update

RUN apt-get -y install \
    git \
    tzdata \
    dos2unix

RUN gem install bundler -v ${BUNDLER_VERSION}

#################################################################
#                  Installing node                              #
#################################################################

RUN curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x | bash -\
    && apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    && apt-get upgrade -qq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*\
    && npm install -g npm\
    && npm install -g yarn@1

RUN node -v
RUN npm -v
RUN npm install -g cspell markdownlint-cli
RUN npm install -g markdownlint-cli2

EXPOSE 4000
