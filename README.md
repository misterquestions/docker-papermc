# docker-paper
This is a docker image to setup a server with papermc or waterfall (bungecoord fork)

## Environment variables
`MINECRAFT_SERVER_BUILD`: This specifies an specific version to use for the server jar, if not set it will use `latest` instead.
`MINECRAFT_SERVER_TYPE`: This option defines which jar to use either `paper` or `waterfall`.
`MINECRAFT_VERSION`: This variable defines which server version to use, depending if using waterfall you must specify only the minor version (for example 1.16), but if you're using paper please include the patch (for example 1.16.4).
`MINECRAFT_MAX_RAM`: This allows to control how much RAM should the server be able to use.

## How to run it?

Its pretty easy, you can just use the docker run command with the required options.

```
docker run \
  --name auroners \
  -e 
  -it \
  misterquestions/papermc:latest
```