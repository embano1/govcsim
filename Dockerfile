# build stage
FROM golang:1.13 AS build-env
ARG RELEASE
ENV GO111MODULE=on
RUN go get -u github.com/vmware/govmomi/vcsim@v${RELEASE}

# final stage
FROM debian:stable-slim
ARG RELEASE
LABEL vcsim=${RELEASE} \
      maintainer="mgasch@vmware.com"

RUN apt-get update && apt-get install -y \
    ca-certificates=20190110 \
    procps=2:3.3.15-2 \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 61000 vcsim
RUN useradd -g 61000 -l -m -s /bin/false -u 61000 vcsim
WORKDIR /home/vcsim
COPY --from=build-env /go/bin/vcsim .
RUN chown -R vcsim:vcsim ./

USER vcsim
EXPOSE 8989
CMD ["./vcsim", "-l", ":8989"]
