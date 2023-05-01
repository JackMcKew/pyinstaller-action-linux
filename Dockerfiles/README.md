# Docker Files

To push new images up to Docker hub

1. `docker login`
2. `docker build -f Dockerfile-python3.10 . --platform=linux/amd64 -t jackmckew/pyinstaller-linux:3.10 -t jackmckew/pyinstaller-linux:latest`
3. `docker push pyinstaller-linux:3.10`