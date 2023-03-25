#!/bin/bash

TOMCAT_DIR="/c/program files/apache software foundation/tomcat 9.0"
WAR_FILE=/d/task-1/binary/webSocket.war
WAR_NAME=webSocket.war

USERNAME="admin"
PASSWORD="pass"
TC_URL="http://localhost:8080/manager/text"

function deploy_war {
  "$TOMCAT_DIR"/bin/shutdown.bat
  rm -rf "$TOMCAT_DIR"/webapps/$WAR_NAME*
  cp $WAR_FILE "$TOMCAT_DIR"/webapps/
  "$TOMCAT_DIR"/bin/startup.bat
  echo "Deployed"
}

function undeploy_war {
    "$TOMCAT_DIR"/bin/shutdown.bat
    rm -rf "$TOMCAT_DIR"/webapps/$WAR_NAME*
    "$TOMCAT_DIR"/bin/startup.bat
    echo "Undeployed"
}

function deploy_curl {
  eval curl -T "$WAR_FILE" "$TC_URL/deploy?path=/webSocket" -u "$USERNAME:$PASSWORD"
  echo "Deployed with curl"
}

function undeploy_curl {
  curl "$TC_URL/undeploy?path=/webSocket" -u "$USERNAME:$PASSWORD"
  echo "Undeployed with curl"
}

case "$1" in
deploy)
  deploy_war
  ;;
undeploy)
  undeploy_war
  ;;
deploy-curl)
  deploy_curl
  ;;
undeploy-curl)
  undeploy_curl
  ;;
*)
  echo "Usage: $0 {deploy|undeploy|deploy-curl|undeploy-curl}"
  exit 1
esac