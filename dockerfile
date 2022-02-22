FROM lsiobase/rdesktop-web:alpine

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="arouzing"

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache --virtual=build-dependencies grep awk
RUN 
# https://github.com//
LOCATION=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/obsidianmd/obsidian-releases/archive/Obsidian-" substr($2, 3, length($2)-3) ".AppImage"}') \
; curl -L -o /home/abc/obsidian.AppImage $LOCATION && \ chmod +x /home/abc/obsidian.AppImage 


# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /data