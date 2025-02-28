# Dockerfile Documentation

This Dockerfile sets up an environment with Ubuntu 24.04, OpenJDK 7, and Apache Tomcat 7. It performs the following steps:

1. **Base Image**: Uses `ubuntu:24.04` as the base image.
2. **Install Dependencies**: Updates package lists and installs `wget`, `unzip`, and `nano`.
3. **Copy JDK**: Copies the JDK tarball to the container.
4. **Extract JDK**: Creates the JVM directory, extracts the JDK, and sets up environment variables for Java.
5. **Copy Tomcat**: Copies the Apache Tomcat tarball to the container.
6. **Extract Tomcat**: Extracts Tomcat, moves it to `/opt/tomcat`, and removes unnecessary webapps.
7. **Configure Tomcat**: Changes Tomcat's default port to 80 and sets execution permissions for Tomcat scripts.
8. **Custom Context**: Replaces the `context.xml` file for the Tomcat manager with a custom configuration.
9. **Entrypoint Script**: Copies and sets execution permissions for the entrypoint script.
10. **Expose Port**: Exposes port 80.
11. **Entrypoint and CMD**: Sets the entrypoint and default command to start Tomcat.

# docker-entrypoint.sh Documentation

This script is the entrypoint for the Docker container. It performs the following steps:

1. **Check Environment Variables**: Ensures `TOMCAT_USER` and `TOMCAT_PASSWORD` are set.
2. **Configure Tomcat Users**: Creates the `tomcat-users.xml` file with the necessary roles and the provided user credentials.
3. **Start Tomcat**: Executes the `catalina.sh run` command to start Tomcat.

# docker-compose.yml Documentation

This Docker Compose file defines the service for running the Tomcat container. It includes:

1. **Service Definition**: Defines the `tomcat7-jdk7` service.
2. **Image and Build**: Specifies the image to use and the build context.
3. **Ports**: Maps port 80 of the container to port 80 on the host.
4. **Environment Variables**: Passes `TOMCAT_USER` and `TOMCAT_PASSWORD` from the `.env` file to the container.
5. **Volumes**: Mounts a volume for Tomcat configuration.
6. **Entrypoint and Command**: Specifies the entrypoint script and the command to run Tomcat.

# .env Documentation

Create the file with the following variables:

1. **TOMCAT_USER**: The username for Tomcat.
2. **TOMCAT_PASSWORD**: The password for Tomcat.

---
# Documentação do Dockerfile

Este Dockerfile configura um ambiente com Ubuntu 24.04, OpenJDK 7 e Apache Tomcat 7. Ele executa os seguintes passos:

1. **Imagem Base**: Usa `ubuntu:24.04` como imagem base.
2. **Instalar Dependências**: Atualiza as listas de pacotes e instala `wget`, `unzip` e `nano`.
3. **Copiar JDK**: Copia o tarball do JDK para o contêiner.
4. **Extrair JDK**: Cria o diretório JVM, extrai o JDK e configura variáveis de ambiente para o Java.
5. **Copiar Tomcat**: Copia o tarball do Apache Tomcat para o contêiner.
6. **Extrair Tomcat**: Extrai o Tomcat, move-o para `/opt/tomcat` e remove webapps desnecessários.
7. **Configurar Tomcat**: Altera a porta padrão do Tomcat para 80 e define permissões de execução para os scripts do Tomcat.
8. **Contexto Personalizado**: Substitui o arquivo `context.xml` do gerenciador do Tomcat por uma configuração personalizada.
9. **Script de Entrypoint**: Copia e define permissões de execução para o script de entrypoint.
10. **Expor Porta**: Expõe a porta 80.
11. **Entrypoint e CMD**: Define o entrypoint e o comando padrão para iniciar o Tomcat.

# Documentação do docker-entrypoint.sh

Este script é o entrypoint para o contêiner Docker. Ele executa os seguintes passos:

1. **Verificar Variáveis de Ambiente**: Garante que `TOMCAT_USER` e `TOMCAT_PASSWORD` estejam definidos.
2. **Configurar Usuários do Tomcat**: Cria o arquivo `tomcat-users.xml` com os papéis necessários e as credenciais do usuário fornecidas.
3. **Iniciar Tomcat**: Executa o comando `catalina.sh run` para iniciar o Tomcat.

# Documentação do docker-compose.yml

Este arquivo Docker Compose define o serviço para executar o contêiner Tomcat. Ele inclui:

1. **Definição de Serviço**: Define o serviço `tomcat7-jdk7`.
2. **Imagem e Build**: Especifica a imagem a ser usada e o contexto de build.
3. **Portas**: Mapeia a porta 80 do contêiner para a porta 80 no host.
4. **Variáveis de Ambiente**: Passa `TOMCAT_USER` e `TOMCAT_PASSWORD` do arquivo `.env` para o contêiner.
5. **Volumes**: Monta um volume para a configuração do Tomcat.
6. **Entrypoint e Comando**: Especifica o script de entrypoint e o comando para executar o Tomcat.

# Documentação do .env

Crie o arquivo com as váriaveis:

1. **TOMCAT_USER**: O nome de usuário para o Tomcat.
2. **TOMCAT_PASSWORD**: A senha para o Tomcat.