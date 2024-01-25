# `mongosqld`

## Quick reference

- Maintained by:
  [Lumiplus DBA]()
- Where to get help:
  [documentation]()

## Spported tags and respective `Dockerfile` links

### Simple Tags


## What is `mongosqld`?

`mongosqld` is a tool that accept incoming requests from a SQL client and proxies those requests to a MongoDB server instance. `mongosqld` is a part of the MongoDB Connector for BI package.

## How to use this image

### Start a `mongosqld` instance

```bash
docker run --name some-mongosqld -d hub.lumigame.com/ldb/mongosqld:tag
```
...where `some-mongosqld` is the name of your `mongosqld` container.

### Connect to MongoSQLd from another Docker container

The MongoSQLd server in the image listens on port `3307`, so connecting via Docker networks will be the same as connecting to a remote `mongosqld`.

### Container shell access and viewing MongoSQLd logs

The `docker exec` command allows you ti run commands inside a Docker container. The following command line will give you a bash shell inside your `mongosqld` container:
```bash
docker exec -it some-mongosqld bash
```

The MongoSQLd server log is available through Docker's container log, unless configured otherwise:
```bash
docker logs some-mongosqld
```

## Configuration

See the [`mongosqld` manual](https://www.mongodb.com/docs/bi-connector/current/reference/mongosqld) for information on using and configuring MongoSQLd.

## Authentication

## Image Variants

The `mongosqld` binaries come in many flavors, each based on different operation systems. But for this Docker image, we only support releases of Debian.
