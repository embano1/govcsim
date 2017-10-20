# build stage
FROM golang:1.9.1 AS build-env
WORKDIR /go/src/vcsim
COPY main.go .
RUN go get -d -v
RUN CGO_ENABLED=0 go build -a -tags netgo -o vcsim .

# final stage
FROM scratch
WORKDIR /tmp
COPY --from=build-env /go/src/vcsim/vcsim .
ARG GIT_COMMIT=unkown
LABEL git-commit=$GIT_COMMIT
EXPOSE 8989
ENTRYPOINT ["./vcsim"] 
CMD ["-httptest.serve", "0.0.0.0:8989"]
