FROM node:20-alpine
RUN apk add --no-cache git
RUN git clone --depth 1 https://github.com/EvolutionAPI/evolution-api.git /app
WORKDIR /app
RUN npm install -g pnpm
RUN pnpm config set ignore-scripts true
RUN pnpm install --no-frozen-lockfile

# Generar el Prisma Client (no necesita conexión a la BD, solo el schema)
ENV DATABASE_PROVIDER=postgresql
RUN npx prisma generate --schema ./prisma/postgresql-schema.prisma

EXPOSE 8080
CMD ["npx", "tsx", "src/main.ts"]
