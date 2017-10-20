# govcsim
Build and Dockerfile for https://github.com/vmware/govmomi/tree/master/vcsim

# Usage
- Clone or `go get` https://github.com/vmware/govmomi/tree/master/vcsim
- Place Dockerfile and build.sh in the vcsim subfolder
- Change `-t` Docker <TAGNAME> in `build.sh` to your needs
- Create Docker image with `sh build.sh`
- Run with `docker run --rm -it -p 8989:8989 <TAGNAME>`
- Test endpoint with `curl -k https://localhost:8989/about`
