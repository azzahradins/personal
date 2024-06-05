FROM node:21.7.3-alpine AS base
WORKDIR /app
COPY . .
RUN npm install

FROM base as builder
WORKDIR /app
RUN npm run build

FROM node:21.7.3-alpine as runner
WORKDIR /app
COPY --from=builder /app/dist .
ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321

CMD node ./server/entry.mjs