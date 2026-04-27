# Phase de build
FROM node:20-alpine AS build

WORKDIR /app

# Copy dependency files first (cache layer)
COPY package*.json ./

RUN npm ci

COPY . .

# Remove devDependencies after install
RUN npm prune --omit=dev


# Prod image
FROM node:20-alpine AS production

WORKDIR /app

ENV NODE_ENV=production

# create non-root user
RUN addgroup -S nodejs && adduser -S nodejs -G nodejs

# copy only necessary files
COPY --from=build /app/package*.json ./
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/src ./src

USER nodejs

EXPOSE 3000

CMD ["node", "src/index.js"]