FROM node:20-alpine

RUN apk add --no-cache git

RUN git clone --depth 1 https://github.com/EvolutionAPI/evolution-api.git /app

WORKDIR /app

RUN npm install -g pnpm
RUN pnpm config set ignore-scripts true
RUN pnpm install --no-frozen-lockfile

EXPOSE 8080

CMD ["npx", "tsx", "src/main.ts"]
