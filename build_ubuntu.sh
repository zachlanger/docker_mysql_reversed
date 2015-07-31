cd ubuntu_slave/
docker build -t zlanger/dockerubuntu .
docker run --name ubuntu_slave -t zlanger/dockerubuntu
