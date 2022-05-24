# Adapted from https://github.com/timbru31/docker-ruby-node/blob/master/2.7/16/Dockerfile
# Using dependency references from https://pages.github.com/versions/

# 2.7.3 is GitHub Pages 226 compatible
ARG RUBY_VERSION
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION_NUMBER

FROM ruby:${RUBY_VERSION}

ARG GH_PAGES_VERSION
ARG NODE_MAJOR_VERSION

# Label Reference: https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.created="${BUILD_DATE}"
LABEL org.opencontainers.image.title="Blog-in-a-box Container"
LABEL org.opencontainers.image.description="The container used by blog-in-a-box. Ruby, node, jekyll, and necessary packages."
LABEL org.opencontainers.image.url="https://github.com/excellalabs/blog-in-a-box-container"
LABEL org.opencontainers.image.documentation="https://github.com/excellalabs/blog-in-a-box-container"
LABEL org.opencontainers.image.source="https://github.com/excellalabs/blog-in-a-box"
LABEL org.opencontainers.image.revision="${VCS_REF}"
LABEL org.opencontainers.image.vendor="Excella"
LABEL org.opencontainers.image.version="${VERSION_NUMBER}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.authors="Sean Killeen <sean.killeen@excella.com>"

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

RUN gem install bundler

#################################################################
#                  Installing node                              #
#################################################################

RUN curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x | bash -\
    && apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    && apt-get upgrade -qq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*\
    && npm install -g yarn@1

RUN node -v
RUN npm -v
RUN npm install -g cspell markdownlint-cli

EXPOSE 4000