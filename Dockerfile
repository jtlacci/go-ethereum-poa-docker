FROM golang:1.11-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers curl

ENV VERSION=1.8

RUN mkdir -p src && curl -L https://github.com/ethereum/go-ethereum/archive/release/${VERSION}.tar.gz | tar -zxf - -C src && \
    mv src/go-ethereum-release-${VERSION} src/go-ethereum && \
    cd src/go-ethereum && \
    make geth

# Pull Geth into a second stage deploy alpine container
FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder go/src/go-ethereum/build/bin/geth /usr/local/bin/

COPY geth /usr/local/bin
RUN chmod +x usr/local/bin/geth-create.sh
RUN chmod +x usr/local/bin/geth-master.sh
RUN /bin/sh usr/local/bin/geth-create.sh

ENTRYPOINT ["usr/local/bin/geth-master.sh"]

EXPOSE 8545 8546 30303 30303/udp