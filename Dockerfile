FROM node:20-alpine

RUN apk add --no-cache git

RUN git clone --depth 1 https://github.com/EvolutionAPI/evolution-api.git /app

WORKDIR /app

RUN npm install -g pnpm
RUN pnpm config set ignore-scripts true
RUN pnpm install --no-frozen-lockfile

# Localizar schema.prisma y generar el cliente de base de datos
RUN npx prisma generate --schema=$(find . -name "schema.prisma" | head -n 1)

EXPOSE 8080

# Ejecutar directamente el punto de entrada TypeScript
CMD ["npx", "tsx", "src/main.ts"]
