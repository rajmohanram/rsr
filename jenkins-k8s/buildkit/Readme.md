buildctl \
    --addr tcp://10.96.108.62:1234 \
    build \
    --frontend dockerfile.v0 \
    --local context=. \
    --local dockerfile=. \
    --output type=image,name=rajmor/alpine:latest,push=true

buildctl build \
    --frontend dockerfile.v0 \
    --opt target=foo \
    --opt build-arg:foo=bar \
    --local context=. \
    --local dockerfile=. \
    --output type=image,name=docker.io/username/image,push=true