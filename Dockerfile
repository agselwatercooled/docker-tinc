FROM alpine:latest

RUN apk add --no-cache tinc

# Its necessary to create a /dev/net/tun device. The creation via
# "RUN mkdir ..." was not persist after startup. Therefore the 
# shell is used at ENTRYPOINT to create the device
ENTRYPOINT ["/bin/sh", "-c", "mkdir -p /dev/net && mknod /dev/net/tun c 10 200 && tincd -n"]
