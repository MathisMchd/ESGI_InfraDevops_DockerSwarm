# Phase de build
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# Production image avec fichiers strictement nécessaires
FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production

# create non-root user
RUN addgroup -S nodejs && adduser -S nodejs -G nodejs

# copy only necessary files
COPY --from=build /app/package*.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist

USER nodejs

EXPOSE 3000

CMD ["node", "dist/index.js"]