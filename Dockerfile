# Estágio 1: Build
FROM node:18 AS build

WORKDIR /usr/src/app

# Copia apenas arquivos essenciais para instalação
COPY package.json package-lock.json ./

# Instala todas as dependências (necessário para o build)
RUN npm install

# Copia o restante do código e executa o build
COPY . .

# Build do projeto
RUN npm run build

# Instala apenas as dependências de produção
RUN npm ci --only=production

# Estágio 2: Produção
FROM node:current-alpine3.21

WORKDIR /usr/src/app

# Copia a pasta `dist` gerada no build
COPY --from=build /usr/src/app/dist ./dist

# Copia o arquivo do Prisma (schema.prisma) para o container de produção (comentado - banco de dados)
# COPY --from=build /usr/src/app/prisma ./prisma

# Copia apenas as dependências de produção
COPY --from=build /usr/src/app/node_modules ./node_modules

# Copia apenas as dependências de produção
COPY --from=build /usr/src/app/package.json ./package.json

# Copia o arquivo .env para o container de produção (comentado - pode conter configs de banco)
# COPY .env ./.env

# Expõe a porta usada pelo aplicativo
EXPOSE 3000

# Define o comando para iniciar a aplicação
CMD ["npm", "run", "start:prod"]
