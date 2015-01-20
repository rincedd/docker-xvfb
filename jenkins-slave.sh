#!/bin/bash

if [ "x$SLAVE_JNLP_URL" == "x" ] ; then
  echo "ERROR: Jenkins Slave JNLP URL has not been set."
  exit 1
fi

if [ "x$MASTER_URL" == "x" ] ; then
  echo "ERROR: Jenkins Master URL has not been set."
  exit 1
fi

JENKINS_SLAVE_BINDIR=/usr/local/lib/jenkins

mkdir -p ${JENKINS_SLAVE_BINDIR}

wget $MASTER_URL/jnlpJars/slave.jar -O ${JENKINS_SLAVE_BINDIR}/slave.jar

exec java -jar ${JENKINS_SLAVE_BINDIR}/slave.jar -jnlpUrl ${SLAVE_JNLP_URL}