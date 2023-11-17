# Ubuntu latest
FROM ubuntu:latest
# Update packages
RUN apt-get update && apt-get upgrade -y
# use the mounted ordinals directory from the host
WORKDIR /ordinals
# Install latest ord release from github 
RUN wget -O - https://raw.githubusercontent.com/ordinals/ord/master/install.sh | bash
# Set entrypoint
RUN echo $DATA_DIR
RUN echo $RPC_HOST
RUN echo $RPC_PORT
RUN echo $COOKIE_FILE
RUN echo $HTTP_PORT
ENTRYPOINT /ordinals/ord --data-dir $DATA_DIR --rpc-url $RPC_HOST:$RPC_PORT --cookie-file $COOKIE_FILE server --http --http-port $HTTP_PORT