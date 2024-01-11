# test with a clean ubuntu docker

docker run -it --rm --network=host -v $(pwd):/app -w /app ubuntu:20.04 /bin/bash
