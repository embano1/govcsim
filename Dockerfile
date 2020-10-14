# build stage
FROM golang:1.15 AS build-env
ARG RELEASE
ENV GO111MODULE=on
RUN go get -u github.com/vmware/govmomi/vcsim@v${RELEASE}
RUN go get -u github.com/vmware/govmomi/govc@v${RELEASE}

# final stage
# ubuntu:bionic-20200921 linux/amd64
FROM ubuntu@sha256:45c6f8f1b2fe15adaa72305616d69a6cd641169bc8b16886756919e7c01fa48b
ARG RELEASE
LABEL vcsim=${RELEASE} \
      maintainer="mgasch@vmware.com"

RUN groupadd -g 61000 vcsim
RUN useradd -g 61000 -l -m -s /bin/false -u 61000 vcsim

WORKDIR /home/vcsim
RUN chown -R vcsim:vcsim ./

COPY --from=build-env /go/bin/vcsim /usr/local/bin
COPY --from=build-env /go/bin/govc /usr/local/bin

USER vcsim
EXPOSE 8989
CMD ["/usr/local/bin/vcsim", "-l", ":8989", "-username", "administrator", "-password", "REPLACEME"]
