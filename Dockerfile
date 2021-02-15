FROM alpine:3.11

LABEL maintainer="Jean Carlos da Silva Ferreira <jeansferreira@gmail.com>"

ENV PYTHONUNBUFFERED=1

RUN echo "**** install Python ****"
RUN apk add --no-cache python3
RUN if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi
RUN echo "**** install pip ****"
RUN python3 -m ensurepip
RUN rm -r /usr/lib/python*/ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools wheel google-cloud-storage
RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi
ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre

ENV PENTAHO_VERSION=8.3
ENV PDI_BUILD=8.3.0.0-371
ENV JRE_HOME=${JAVA_HOME}
ENV PENTAHO_JAVA_HOME=${JAVA_HOME}
ENV PENTAHO_HOME=/opt/pentaho
ENV KETTLE_HOME=/opt/pentaho/data-integration
ENV PATH=${PATH}:${JAVA_HOME}/bin

RUN echo wget -qO /tmp/pdi-ce.zip https://sourceforge.net/projects/pentaho/files/Pentaho%20${PENTAHO_VERSION}/client-tools/pdi-ce-${PDI_BUILD}.zip

RUN apk update && \
    apk --no-cache add libressl && \
    apk add openjdk8-jre bash && \
    apk add --virtual build-dependencies ca-certificates openssl && \
    update-ca-certificates

RUN mkdir -p ${PENTAHO_HOME}

#RUN wget -qO /tmp/pdi-ce.zip https://sourceforge.net/projects/pentaho/files/Pentaho%20${PENTAHO_VERSION}/client-tools/pdi-ce-${PDI_BUILD}.zip

ADD pdi-ce-8.3.0.0-371.zip /tmp/pdi-ce.zip
RUN unzip -q /tmp/pdi-ce.zip -d ${PENTAHO_HOME}

RUN rm -f /tmp/pdi-ce.zip
RUN apk del build-dependencies
RUN chmod -R g+w ${PENTAHO_HOME}
RUN chmod -R +x ${PENTAHO_HOME}

RUN ls -l ${PENTAHO_HOME}/
RUN pwd

#Patch to restore images https://jira.pentaho.com/browse/PDI-17948

RUN wget -qO /tmp/static.tgz https://jira.pentaho.com/secure/attachment/100366/data-integration-static-folder.gz
RUN gzip -dc /tmp/static.tgz |tar -xvf - -C /opt/pentaho/data-integration/
#ADD py/* /opt/pentaho/data-integration

ADD docker-entrypoint.sh ${KETTLE_HOME}/docker-entrypoint.sh

VOLUME ["/opt/pentaho/repository"]

EXPOSE 7373

WORKDIR $KETTLE_HOME

#CMD ["/bin/bash", "./docker-entrypoint.sh", "carte.sh"]
#CMD ["/bin/bash", "carte.sh"]
#CMD ["/bin/bash", "kitchen.sh"]



