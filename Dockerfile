ARG BUSYBOX_VERSION=1.31.1
ARG OPENJDK_VERSION=8-jre-alpine3.9

FROM busybox:${BUSYBOX_VERSION} as install

COPY [ "./assets/zoho.zip", "." ]

RUN unzip -q zoho.zip

FROM openjdk:${OPENJDK_VERSION}

LABEL maintainer="Lucca Pessoa da Silva Matos - luccapsm@gmail.com" \
        org.label-schema.version="1.0.0" \
        org.label-schema.release-data="12-06-2020" \
        org.label-schema.url="https://github.com/lpmatos" \
        org.label-schema.name="Zoho Upload"

ENV ZOHO_HOME=/opt/zoho \
    ZOHO_UPLOAD_FOLDER=ZohoAnalytics/UploadTool

WORKDIR ${ZOHO_HOME}

RUN set -ex && apk update && apk upgrade -U

RUN apk add --update --no-cache \
      bash=4.4.19-r1 \
      figlet=2.2.5-r0

COPY --from=install [ "/${ZOHO_UPLOAD_FOLDER}/", "." ]

COPY [ "./scripts/zoho", "/usr/local/bin" ]

RUN sed -i "s/JAVA_HOME=jre/JAVA_HOME=\/usr/g" ${ZOHO_HOME}/bin/setEnv.sh && \
    chmod +x /usr/local/bin/zoho && \
    find ${ZOHO_HOME}/bin -iname "*.sh" -type f -exec chmod a+x {} \; -exec echo {} \;;
