FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json ./

RUN npm install

COPY . .

FROM node:18-slim

COPY --from=builder /app /app

EXPOSE 3000

CMD [ "npm", "start" ]
