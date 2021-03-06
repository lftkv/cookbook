FROM node:13-buster-slim as build

WORKDIR /app
RUN yarn global add gatsby-cli && gatsby telemetry --disable
ADD package.json yarn.lock ./
RUN yarn --production --frozen-lockfile --non-interactive

ADD . ./
RUN gatsby build


FROM abiosoft/caddy:1.0.3-no-stats
RUN echo 'tls off' >> /etc/Caddyfile
COPY --from=build /app/public /srv