FROM openjdk:11-slim-buster
RUN apt-get update \
  && apt upgrade -y \
  && apt install -y wget
WORKDIR /minecraft
ADD https://raw.githubusercontent.com/misterquestions/docker-papermc/main/entrypoint.sh .
RUN chmod +x entrypoint.sh
EXPOSE 25565/udp 25565/tcp
ENTRYPOINT [ "./entrypoint.sh" ]