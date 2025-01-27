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

```
1° Criar uma imagem docker do seu projeto funcionando em modo de produção
2° Criar um arquivo de configuração do seu ci/cd (Jenkins, Gitlab, Github Actions) e logando no mesmo com o seu repositorio
3° No pipeline pode fazer pre-deploy, deploy, post-deploy por exemplo (testes, build, deploy, etc)
4° No pipeline criar login com seu armazenador de imagens (dockerhub, github, etc)
5° Fazer o build da imagem e enviar para o repositorio(dockerhub, github, etc)
6° Fazer o deploy do seu projeto no kubernetes ou outro container manager (k8s, docker swarm)
```

# Teste de carga

```bash
kubectl get svc -n primeira-app

kubectl run fortio -n primeira-app -it --rm --image=fortio/fortio -- load -c 50 -qps 6000 -t 120s http://10.96.216.121:80/k8s

```

# Subir imagem para o dockerhub

```bash

# login no dockerhub

docker login

# Build da imagem

docker build -t ericl123/ap-ts-erick:v6 .

# subir imagem para o dockerhub

docker push ericl123/ap-ts-erick:v6

# rodar k8s

kubectl apply -f k8s/deployment.yaml

```

# Self-healing example

```yaml
# startupProbe - verifica se o container está pronto para receber requisições
 startupProbe:
           # exec:
           #   command: ["/bin/sh", "-c", "sleep 30"]
           httpGet:
             path: /healthz
             port: 3000
           # se o container não responder em 10 segundos, ele será considerado como falho
           failureThreshold: 3
           # se o container responder em 10 segundos, ele será considerado como funcionando
           successThreshold: 1
           # timeout de 1 segundo para cada requisição
           timeoutSeconds: 1
           # verifica a cada 10 segundos
           periodSeconds: 10
           # delay de 10 segundos para iniciar a verificação
           initialDelaySeconds: 10

# readinessProbe - verifica se o container está pronto para receber requisições
         readinessProbe:
           httpGet:
             path: /readyz
             port: 3000
           failureThreshold: 3
           successThreshold: 1
           timeoutSeconds: 1
           periodSeconds: 10
           initialDelaySeconds: 10

# livenessProbe - verifica se o container está funcionando
         livenessProbe:
           httpGet:
             path: /health
             port: 3000
           periodSeconds: 20
           successThreshold: 1
           failureThreshold: 3
           initialDelaySeconds: 10

```
