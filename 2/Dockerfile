# install deps
FROM node:18-alpine AS deps
WORKDIR /app
COPY app/package.json ./
RUN npm install

# build the application
FROM node:18-alpine AS builder
WORKDIR /app
COPY app/ ./
COPY --from=deps /app/node_modules ./node_modules
RUN npm run build
RUN mkdir -p /app/public

# production runner
FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

# expose port 3000
EXPOSE 3000

CMD ["npm", "run", "start"]
