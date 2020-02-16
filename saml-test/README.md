# HelixCore

https://www.perforce.com/

# インストール

docker-composeでインストールします  
※dockerのインストール方法については省略

ビルドコマンド

```
docker-compose -f docker-compose.yml build
```
```
docker-compose -f docker-compose.yml build --no-cache
```

起動

```
docker-compose -f docker-compose.yml up -d
```

停止

```
docker-compose -p helixcore stop
```

停止+削除

```
docker-compose -p helixcore down
```

dockerのログを確認する

```
docker-compose -p helixcore logs -f
```

コンテナに入る

```
docker exec -it helixcore_p4dmaster_1 bash
```
