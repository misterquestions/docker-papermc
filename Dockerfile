FROM openjdk:11-slim-buster
RUN apt-get update \
  && apt upgrade -y \
  && apt install -y wget
WORKDIR /minecraft
COPY minecraft.sh .
VOLUME /minecraft
EXPOSE 25565/udp 25565/tcp
ENTRYPOINT [ "./minecraft.sh" ]