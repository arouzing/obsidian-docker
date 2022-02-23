FROM lsiobase/rdesktop-web:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG APPIMAGE_EXTRACT_AND_RUN=1
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="arouzing"

RUN \
  echo "**** install packages ****" && \
  apt-get update && apt-get install -y nano libnss3 zenity
RUN \
LOCATION=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/obsidianmd/obsidian-releases/releases/download/v" substr($2, 3, length($2)-4) "/Obsidian-" substr($2, 3, length($2)-4) ".AppImage"}') \
; curl -L -o /opt/obsidian.AppImage $LOCATION
RUN chmod a+x /opt/obsidian.AppImage && \
  ./opt/obsidian.AppImage --appimage-extract

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /data