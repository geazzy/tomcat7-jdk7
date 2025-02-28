#!/bin/bash
set -e

# Verifica se as variáveis de ambiente estão definidas
if [ -z "$TOMCAT_USER" ] || [ -z "$TOMCAT_PASSWORD" ]; then
  echo "Erro: As variáveis de ambiente TOMCAT_USER e TOMCAT_PASSWORD devem estar definidas."
  exit 1
fi

# Cria o arquivo tomcat-users.xml com as roles necessárias
cat > "$CATALINA_HOME/conf/tomcat-users.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users>
  <role rolename="admin"/>
  <role rolename="admin-gui"/>
  <role rolename="manager-gui"/>
  <role rolename="manager-status"/>
  <role rolename="manager-script"/>
  <role rolename="manager-jmx"/>
  <user username="${TOMCAT_USER}" password="${TOMCAT_PASSWORD}" roles="admin-gui,admin-script,manager-gui,manager-status,manager-script,manager-jmx"/>
</tomcat-users>
EOF
 


echo "Arquivo tomcat-users.xml configurado com o usuário '${TOMCAT_USER}'."

# Inicia o Tomcat
exec catalina.sh run
