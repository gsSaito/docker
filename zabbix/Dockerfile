#Dockerfile

# FROM コマンドでDocker公式のMySQLイメージを使える(コロン以降がバージョン)
FROM mysql:5.7

# RUN コマンドでDocker側で実行するシェルのコマンドを書ける
# MySQLの設定をこんな感じで追加しておく
RUN { \
    echo '[mysqld]'; \
    echo 'character-set-server = utf8'; \
} > /etc/mysql/conf.d/charset.cnf

# COPY コマンドで自分のマシンからDockerの/docker-entrypoint-initdb.d/下にprepare.sqlをコピーする
# /docker-entrypoint-initdb.d/ 下にあるSQLは全部勝手に実行してくれる！！！
COPY prepare.sql /docker-entrypoint-initdb.d/prepare.sql