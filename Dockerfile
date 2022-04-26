FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl

# Installing strix-21.0.0-1
COPY ./bin/strix /usr/bin
RUN chmod +x /usr/bin/strix

# Installing nuXmv 2.0.0
COPY ./bin/nuXmv /usr/bin
RUN chmod +x /usr/bin/nuXmv

CMD ["bash"]
