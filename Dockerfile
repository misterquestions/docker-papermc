FROM openjdk:11-slim-buster
RUN apt-get update \
  && apt upgrade -y \
  && apt install -y wget
WORKDIR /minecraft
COPY entrypoint.sh .
VOLUME /minecraft
EXPOSE 25565/udp 25565/tcp
RUN chmod +x entrypoint.sh
ENTRYPOINT [ "/minecraft/entrypoint.sh" ]