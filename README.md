# Pentaho Image
Imagem do Docker para Pentaho 8.3+ 


## Como usar

Clonar o repositório do git para criar uma imagem do Pentaho em ambiente local.

```
#git clone https://github.com/jeansferreira/docker-etl-pentaho.git
#cd arql-etl-pentaho
```

Para criar a imagem do Pentaho em ambiente local, execute o seguinte comando:
```
#docker build -t <user>/<name imagem>:<tag> .
Exemplo:
#docker build -t jeansferreira/pdi:1 .
```

Depois execute o seguinte comando para verificar se a imagem foi criada:
```
#docker images
```

## Executar um JOB com a imagem criada

Clonar o projeto de exemplo do Job.

```
#git clone https://gitlab.aquare.la/Aqrl-Platform/aqrl-pdi-job-exemplo.git
#cd aqrl-pdi-job-exemplo
```

## Para dar um build no exemplo e verificar se a imagem está funcionando

Comandos:
```
#docker build -t my-pdi-job-aqrl:1 .
#docker run --rm --entrypoint /bin/bash my-pdi-job-aqrl:1 -c "sh runJob.sh Teste job_teste_1 Debug"
```
