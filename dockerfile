FROM lsiobase/rdesktop-web:alpine

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="arouzing"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    flatpak && \ 
    flatpak install flathub md.obsidian.Obsidian

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /data