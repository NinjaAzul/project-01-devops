# Aprendizado sobre DEVOPS caso de estudo containers dockers

```
//FROM usado para criar uma imagem baseada em uma imagem existente no caso criando com imagem do node:18 do dorckerhub
https://hub.docker.com/layers/library/node/18-slim/images/sha256-08c9a86076fe3c60a2e305b1485225a46768526c5d10eed42e04430e3d20f4aa
FROM node:18-slim

//DIRETORIO QUE VAMOS COLOCAR ESSE PROJETO E DEIXAR RODANDO
WORKDIR /usr/src/app

//COPIA ALGUM ARQUIVO CASO O MESMO SEJA IMPOTANTE
//ou package*.json que importaria junto o package-lock.json
COPY package.json package-lock.json ./

//RUN RODA QUALQUER TIPO DE COMANDO SEJA DE APP OU SO
RUN npm install

COPY . .

RUN npm run build

//EXPOSE MOSTRA QUAL PORTA O CONTAINER NO CONTAIENR O APP VAI ATENDER
EXPOSE 3000

//PASSA ENV para o container a ser criado
ENV

//COMANDO QUE O APP USARA PARA EXECURAR AO INICIAR A IMAGEM
CMD ["npm", "run", "start"]


//como instalar/criar a imagem :v1 = TAG
docker build -t project-01-dev-ops:v1 .

//como rodar a imagem criada

// --rm deleta container ao parar
// --p muda a porta para qualquer uma que queira em sua maquina
// --d roda o container em
//tag gerado : apos o final do comando exemplo V2
// -v volume
// --name da um nome pro container usado para encontrar o mesmo na rede
docker run -v [nome do volume]:[caminho da pasta de trabalho container] --network [nome da rede] -p 3001:3000 -d project-01-dev-ops

exemplo: docker run -v primeiro-volume:/usr/src/app --network primeira-bridge -p 3001:3000 -d project-01-dev-ops:v1 docker run -v primeiro-volume:/usr/src/app --network primeira-bridge -p 3001:3000 -d project-01-dev-ops:v1


//VE TODAS IMAGENS CRIADAS NA MAQUINA
docker image ls project-01-dev-ops

//network lista interfaces REDES E VOLUMES
docker network trabalha com redes

//dconecta o container ao uma rede

docker network connect e8d2f1a6cc1a 901041ea0e42

//acessa o container
docker exec -it 901041ea0e42  ou sh (alpine)
touch

//VOLUMES (diretorio externo criado para garantir efemeridade do container, usado para salvar arquivos que precisam persistir)
docker volume

```

# CI/CD
