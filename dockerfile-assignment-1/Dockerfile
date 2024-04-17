FROM node:6-alpine

# HEALTHCHECK on http://localhost:3000
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD wget -qO- http://localhost:3000 || exit 1


EXPOSE 3000

RUN apk add --update --no-cache tini

RUN mkdir -p /usr/src/app
# Create a user and then change to that user

WORKDIR /usr/src/app

COPY package.json package.json

RUN npm install && npm cache clean --force

COPY . .

CMD ["tini", "--", "node", "./bin/www"]