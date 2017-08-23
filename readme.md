### docker_elk
```bash
使用docker-compose 管理elk
```

### 组成
```bash
1.es
  -v config
  -v data
2.es-head
3.kibana
```
### 测试
```bash
➜  docker_elk git:(base) docker-compose up -d
Creating dockerelk_elasticsearch_1 ...
Creating dockerelk_elasticsearch_1 ... done
Creating dockerelk_kibana_1 ...
Creating dockerelk_elasticsearch-plug-head_1 ...
Creating dockerelk_elasticsearch-plug-head_1
Creating dockerelk_elasticsearch-plug-head_1 ... done
➜  docker_elk git:(base) docker-compose ps
               Name                              Command               State                       Ports
-----------------------------------------------------------------------------
dockerelk_elasticsearch-plug-head_1   /bin/sh -c node_modules/ht ...   Up      0.0.0.0:9100->9100/tcp
dockerelk_elasticsearch_1             /docker-entrypoint.sh elas ...   Up      0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp
dockerelk_kibana_1                    /docker-entrypoint.sh kibana     Up      0.0.0.0:5601->5601/tcp
➜  docker_elk git:(base)
```
