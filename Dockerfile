FROM node:18-alpine as development

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./
RUN npm ci

COPY --chown=node:node . .

USER node



FROM node:18-alpine as build

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

# Need access to the nestjs cli from the development stage
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .

RUN npm run build

ENV NODE_ENV production

# Reinstall in production mode, removing the existing node_modules, for an optimizaed build
RUN npm ci --only=production && npm cache clean --force

USER node



FROM node:18-alpine as production

COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist

CMD ["node", "dist/main.js"]
