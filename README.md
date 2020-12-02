# go-blog-microservice-sauron-database

## Build
```shell script
docker build . -t go-sauron-db
```

## Run
```shell script
docker run -d -p 8080:8080 -p 28015:28015 -p 29015:29015 go-sauron-db
```