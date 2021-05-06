docker-compose build base
docker push pmallozzi/ltltools:latest
docker-compose build web
docker push pmallozzi/ltltools:web
