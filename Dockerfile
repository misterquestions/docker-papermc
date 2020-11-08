FROM openjdk:11-slim-buster
RUN apt-get update \
  && apt upgrade -y \
  && apt install -y wget
WORKDIR /minecraft
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
EXPOSE 25565/udp 25565/tcp
ENTRYPOINT [ "./entrypoint.sh" ]