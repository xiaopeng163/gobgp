# build stage
FROM golang:alpine AS build-env

ENV GOBGP_VERSION v2.14.0

RUN apk add --no-cache gcc linux-headers musl-dev git 

RUN git clone https://github.com/osrg/gobgp && cd gobgp && git checkout tags/${GOBGP_VERSION} -b ${GOBGP_VERSION} && go mod download && go install ./cmd/gobgpd ./cmd/gobgp

# final stage
FROM alpine

LABEL maintainer="Peng Xiao <peng.xiao@ing.com>"

COPY --from=build-env /go/bin/* /usr/bin/

CMD []
