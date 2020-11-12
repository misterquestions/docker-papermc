FROM openjdk:11-slim-buster
RUN apt-get update \
  && apt upgrade -y \
  && apt install -y wget
WORKDIR /minecraft
COPY entrypoint.sh /minecraft
RUN chmod a+x entrypoint.sh
EXPOSE 25565/udp 25565/tcp
ENTRYPOINT [ "/minecraft/entrypoint.sh" ]