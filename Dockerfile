FROM golang:1.11-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD /go-ethereum /go-ethereum
RUN cd /go-ethereum && make geth
# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go-ethereum/build/bin/geth /usr/local/bin/

COPY geth /usr/local/bin
RUN chmod +x usr/local/bin/geth-create.sh
RUN chmod +x usr/local/bin/geth-master.sh
RUN /bin/sh usr/local/bin/geth-create.sh

ENTRYPOINT ["usr/local/bin/geth-master.sh"]