FROM openjdk:16-slim-buster
RUN apt-get update && apt upgrade -y \
  && apt install -y wget \
  && useradd --no-create-home --shell /bin/bash minecraft \
  && mkdir /minecraft \
  && chown -R minecraft:minecraft /minecraft
WORKDIR /minecraft
USER minecraft
COPY minecraft.sh .
VOLUME /minecraft
EXPOSE 25565/udp 25565/tcp
ENTRYPOINT [ "./minecraft.sh" ]