FROM elixir:1.9.4-alpine as base_image
RUN mkdir /app
WORKDIR /app
ENV LC_ALL=zh_CN.UTF-8

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories \
 && sed -i "s/nl.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories \
 && apk upgrade \
 && apk update \
 && apk add \
    bash \
    openssl \
    curl \
    build-base \
    alpine-sdk \
    coreutils \
    git \
    tzdata

RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

RUN export HEX_HTTP_TIMEOUT=120 \
    && export HEX_MIRROR="https://hexpm.upyun.com" \
    && env \
    && echo "MIX_ENV = > $MIX_ENV" \
    && mix local.rebar --force \
    && mix local.hex --force

FROM base_image as pre_builder
# FROM jiker-prebuild:1.0 as builder
# FROM elixir:1.6-alpine as builder

ENV REPLACE_OS_VARS true
ENV PORT 4000
ARG MIX_ENV
# ENV MIX_ENV=${MIX_ENV}

ARG ENVIRONMENT

WORKDIR /app

COPY mix.exs mix.lock ./
COPY config config
COPY apps/oauth_gateway/mix.exs /app/apps/oauth_gateway/mix.exs
COPY apps/oauth_gateway_web/mix.exs /app/apps/oauth_gateway_web/mix.exs

RUN export HEX_HTTP_TIMEOUT=120 \
    && export HEX_MIRROR="https://hexpm.upyun.com" \
    && env \
    && echo "MIX_ENV = > $MIX_ENV" \
    && mix deps.get \
    && mix deps.compile

FROM pre_builder as builder

WORKDIR /app

COPY . /app/

RUN export HEX_HTTP_TIMEOUT=120 \
    && export HEX_MIRROR="https://hexpm.upyun.com" \
    && env \
    && echo "MIX_ENV = > $MIX_ENV" \
    && mix compile

COPY ./rel/scripts/docker-entrypoint.sh .
COPY ./rel/scripts/migrate-and-run.sh .
RUN ["chmod", "+x", "/app/docker-entrypoint.sh"]
RUN ["chmod", "+x", "/app/migrate-and-run.sh"]

# ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["/app/docker-entrypoint.sh"]

CMD ["/app/migrate-and-run.sh"]
