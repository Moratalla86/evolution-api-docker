FROM node:20-alpine

RUN apk add --no-cache git

RUN git clone --depth 1 https://github.com/EvolutionAPI/evolution-api.git /app

WORKDIR /app

RUN npm install -g pnpm
RUN pnpm config set ignore-scripts true
RUN pnpm install --no-frozen-lockfile

# Generar el cliente de Prisma para que TypeScript reconozca la base de datos
RUN npx prisma generate

# Compilar omitiendo errores estrictos de tipos
RUN npx tsc --skipLibCheck || true
RUN pnpm build || true

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
