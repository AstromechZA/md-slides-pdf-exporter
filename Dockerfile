FROM node:9-alpine

# Installs latest Chromium (68) package.
RUN apk update && \
  apk upgrade && \
  echo @3.8 https://ftp.acc.umu.se/mirror/alpinelinux.org/v3.8/community >> /etc/apk/repositories && \
  echo @3.8 https://ftp.acc.umu.se/mirror/alpinelinux.org/v3.8/main >> /etc/apk/repositories && \
  apk add --no-cache \
    freetype@3.8 \
    harfbuzz@3.8 \
    chromium@3.8 \
    nss@3.8 \
    dumb-init

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Puppeteer v1.7.0 works with Chromium 68.
RUN yarn add puppeteer@1.7.0

RUN mkdir /app /source /output

# Add user so we don't need --no-sandbox.
RUN addgroup -S pptruser && adduser -S -g pptruser pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /app /output

# Run everything after as non-privileged user.
USER pptruser

ADD script.js /app/script.js

ENTRYPOINT ["dumb-init", "--", "node", "/app/script.js"]
