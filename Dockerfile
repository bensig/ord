// Ubuntu latest
FROM ubuntu:latest
// Update packages
RUN apt-get update && apt-get upgrade -y
// Install latest ord release from github 
RUN wget -O - https://raw.githubusercontent.com/ordinals/ord/master/install.sh | bash
// use the mounted ordinals directory from the host
WORKDIR /ordinals
// Set entrypoint
ENTRYPOINT ["/ordinals/ord", "--data-dir", "$DATA_DIR", "--rpc-url", "$RPC_HOST:$RPC_PORT", "--cookie-file", "$COOKIE_FILE", "server", "--http", "--http-port", "$HTTP_PORT"]