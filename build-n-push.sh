
docker buildx use m1_builder
docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile \
  -t zouloux/docker-debian-ci:php8.3-composer2.7-node22.2-npm10.7-docker26.1-bun1.1 \
  -t zouloux/docker-debian-ci:latest \
  --push .
