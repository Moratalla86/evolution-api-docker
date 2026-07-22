FROM node:20-alpine

RUN apk add --no-cache git

RUN git clone --depth 1 --branch v1.8.2 https://github.com/EvolutionAPI/evolution-api.git /app

WORKDIR /app

RUN npm install -g pnpm && pnpm install --prod

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
