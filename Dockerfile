FROM ubuntu:24.04

# Atualiza pacotes e instala dependências
RUN apt-get update && \
    apt-get install -y wget unzip nano && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia o arquivo do JDK para o contêiner
COPY jdk-7u80-linux-x64.tar.gz /tmp/

# Cria o diretório e extrai o JDK
RUN mkdir -p /usr/lib/jvm && \
    tar -xzf /tmp/jdk-7u80-linux-x64.tar.gz -C /usr/lib/jvm && \
    mv /usr/lib/jvm/jdk1.7.0_80 /usr/lib/jvm/openjdk-7 && \
    rm /tmp/jdk-7u80-linux-x64.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/openjdk-7
ENV PATH="$JAVA_HOME/bin:$PATH"

# Copia e instala o Apache Tomcat 7
COPY apache-tomcat-7.0.109.tar.gz /tmp/
RUN tar -xzf /tmp/apache-tomcat-7.0.109.tar.gz -C /opt && \
    mv /opt/apache-tomcat-7.0.109 /opt/tomcat && \
    rm /tmp/apache-tomcat-7.0.109.tar.gz && \
    rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/docs

ENV CATALINA_HOME=/opt/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Configura o Tomcat para usar a porta 80
RUN sed -i 's/port="8080"/port="80"/' $CATALINA_HOME/conf/server.xml

# Define permissões de execução
RUN chmod +x $CATALINA_HOME/bin/*.sh

# Substitui o arquivo context.xml do manager com o conteúdo desejado
RUN cat <<'EOF' > $CATALINA_HOME/webapps/manager/META-INF/context.xml
<?xml version="1.0" encoding="UTF-8"?>
<Context antiResourceLocking="false" privileged="true" >
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow=".*" />
  <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)?HashMap"/>
</Context>
EOF


COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expõe a porta 80
EXPOSE 80

# Define o entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Comando padrão para iniciar o Tomcat
CMD ["catalina.sh", "run"]
