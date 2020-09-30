# build stage
FROM golang:1.15 AS build-env
ARG RELEASE
ENV GO111MODULE=on
RUN go get -u github.com/vmware/govmomi/vcsim@v${RELEASE}

# final stage
FROM gcr.io/distroless/base
ARG RELEASE
LABEL vcsim=${RELEASE} \
      maintainer="mgasch@vmware.com"

COPY --from=build-env /go/bin/vcsim /
USER nobody
EXPOSE 8989
CMD ["/vcsim", "-l", ":8989", "-username", "administrator", "-password", "REPLACEME"]
