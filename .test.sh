# test with a clean ubuntu docker

docker run -it --rm -v $(pwd):/app -w /app ubuntu:20.04 /bin/bash