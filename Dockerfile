# Ubuntu latest
FROM ubuntu:latest
# Update packages
RUN apt-get update && apt-get upgrade -y
RUN apt install curl -y
WORKDIR ~/bin
# Install latest ord release from github
RUN curl -Ls -o install.sh https://raw.githubusercontent.com/ordinals/ord/master/install.sh
# Make executable
RUN chmod +x install.sh
RUN ./install.sh

ENTRYPOINT if [ "$USE_SIGNET" = "true" ]; then \
             echo "USE_SIGNET is set to $USE_SIGNET"; \
             echo "Running ord in signet mode"; \
             exec ~/bin/ord -s --index-runes-pre-alpha-i-agree-to-get-rekt --index-sats --data-dir $DATA_DIR --rpc-url $RPC_HOST:$RPC_PORT --cookie-file $COOKIE_FILE server --http --http-port $HTTP_PORT --csp-origin * --enable-json-api; \
           else \
             echo "USE_SIGNET is set to $USE_SIGNET"; \
             echo "Running ord in mainnet mode"; \
             exec ~/bin/ord --index-runes-pre-alpha-i-agree-to-get-rekt --index-sats --data-dir $DATA_DIR --rpc-url $RPC_HOST:$RPC_PORT --cookie-file $COOKIE_FILE server --http --http-port $HTTP_PORT --csp-origin * --enable-json-api;\
           fi
