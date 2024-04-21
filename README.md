# node-sentinel

## helm install redis

```console
helm upgrade -i redis-sentinel bitnami/redis -n redis --create-namespace -f redis-values.yml
```

## deploy

```console
./deploy
```

## configure hosts file to access redis nodes

```console
sudo vim  /etc/hosts

192.168.124.11 redis-sentinel-node-0.redis
192.168.124.12 redis-sentinel-node-1.redis
192.168.124.10 redis-sentinel-node-2.redis
```
