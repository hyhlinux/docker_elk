#ip 
GET /db_apkpure_log/event_download/_search
{
  "query": {
    "match": {
      "ip": "42.1.48.0"
    }
  }
}

#package_name
GET /db_apkpure_log/event_download/_search
{
  "query": {
    "match": {
      "package_name": "com.peacechurch.user.sahayamathachurch"
    }
  }
}


#sort
GET /db_apkpure_log/event_download/_search
{
  "query": {
    "match_all": {
    }
  },
  "sort":{
    "apk_type":{
      "order":"asc"
    }
  }
}




PUT /gb/tweet/5?pretty=1
{
   "date" : "2014-09-15",
   "name" : "Mary Jones",
   "tweet" : "However did I manage before Elasticsearch?",
   "user_id" : 2
}
GET /gb/_mapping


#part5 search
#5.1 empty search
GET _search
#total": 2708 all doc

#timeout 
GET /_search?timeout=1ms

#page
GET /db_apkpure_log/_search?size=10
GET /db_apkpure_log/_search?size=5&from=5
GET /db_apkpure_log/_search?size=5&from=2700
DELETE db_apkpure_log/event_download/AV4HlnnELpLewZ6gEUUu


#all query
GET /_search?q=mary


#!package_name:com.*
GET db_apkpure_log/event_download/_search?q=package_name:com*
#"total": 2001,
GET db_apkpure_log/event_download/_search?q=!package_name:com*
#"total": 702,

##P6 data type
#string type
GET db_apkpure_log/_search?q=package_name:com.*
#fail:date type
GET db_apkpure_log/_search?q=add_date:2017-06-1*
#ok
GET db_apkpure_log/_search?q=add_date:2017-06-16


#查看分词效果
GET /_analyze?analyzer=standard&text="2017-06"
#{
#  "tokens": [
#    {
#      "token": "2017",
#      "start_offset": 1,
#      "end_offset": 5,
#      "type": "<NUM>",
#      "position": 0
#    },
#    {
#      "token": "06",
#      "start_offset": 6,
#      "end_offset": 8,
#      "type": "<NUM>",
#      "position": 1
#    }
#  ]
#}

#--------------
#index manage
DELETE /my_index2
DELETE /my_index
DELETE db_apkpure_log
DELETE db_apkpure_log201*
DELETE db_apkpure_log2017-08-22

#GET mapping
GET /db_apkpure_log2015*/_mapping
#date: iso
#mapping: get key type
GET /db_apkpure_log/_mapping
GET /my_index2/my_type2/_mapping
GET /my_index/my_type/_mapping
# https://www.elastic.co/guide/en/elasticsearch/reference/master/date.html
PUT my_index/my_type/1
{ "date": "2015-01-01" }

# https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-date-format.html#
# iso time
PUT my_index/my_type/2
{ "date": "2015-01-01T12:10:30Z" }

PUT my_index/my_type/3
{ "date": 1420070400001 }

GET my_index/_search
{
  "sort": { "date": "asc"} 
}



#craet my type
PUT /my_index/my_type/1
{
  "create_date": "2015/09/02"
}

#"type": "date"
#1.add_date ===> date
PUT /my_index2/my_type2/1
{
  "create_date": "2017-07-05 07:48:50"
}



#C
PUT /db_apkpure_log
GET db_apkpure_log/_mapping

# 自定义字段是否分词
PUT /gb/_mapping/tweet
{
  "properties" : {
    "tag" : {
      "type" :    "string",
      "index":    "not_analyzed"
    }
  }
}
GET /gb/_mapping
GET /gb/_analyze?field=tag&text=Black-cats
#{
#  "tokens": [
#    {
#      "token": "Black-cats",
#      "start_offset": 0,
#      "end_offset": 10,
#      "type": "word",
#      "position": 0
#    }
#  ]
#}


# P7 dsl
#1
GET /_search
{
}
GET db_apkpure_log/_search
{
}
# 查询2017-06-01的下载数据
GET db_apkpure_log2017-06-01/event_download/_search
{
}

#2 match 包含关键字
GET /_search
{
    "query": {
        "match": {
            "tweet": "elasticsearch"
        }
    }
}


GET /_search
{
    "query": {
        "match": {
            "package_name": "com.puzzletime.jigsaw"
        }
    }
}

#3 must
GET gb/_search
{
    "query": {
       "bool": {
        "must":     { "match": { "tweet": "elasticsearch" }},
        "must_not": { "match": { "name":  "huo" }},
        "should":   { "match": { "tweet": "full text" }}
      }
    }
}


GET /db_apkpure_log/_search
{
    "query": {
      "bool": {
        "must":     { "match": { "package_name": "com.puzzletime.jigsaw" }},
        "must_not": { "match": { "country":  "ua" }},
        "should":   { "match": { "language": "*" }}
      }
    }
}

##insert 2017-06-15
# 总数:103588
GET db_apkpure_log*/event_download/_search
{
  "size":0
}

# 查询2017-06-01的下载数据
GET db_apkpure_log2017*/event_download/_search
{
  "size":0
}
GET db_apkpure_log2017-08-22/event_download/_search
{
  "size":0
}
# 模拟用户下载
POST db_apkpure_log2017-08-22/event_download
{
    "category": "VIDEO_PLAYERS",
    "country": "us",
    "plat_type": "plat_type",
    "package_name": "com.quickteam.videoplayer.pro",
    "language": "*",
    "add_date": "2017-08-22T10:40:23",
    "apk_type": 1,
    "device_type": "device_type",
    "ip": "42.83.80.0",
    "fid": "image/Y29tLnF1aWNrdGVhbS52aWRlb3BsYXllci5wcm9faWNvbl8wXzgzODY4ZDZj",
    "ua": "us"
}
# 查询2017年的总下载量
GET db_apkpure_log2017*/_search
{
    "query": {
        "bool": {
            "must": 
                {
                    "range": {
                        "add_date": {
                            "gte": 1483200000000,
                            "lte": 1514735999999,
                            "format": "epoch_millis"
                        }
                    }
                }
        }
    },
    "size": 0,
    "_source": {
        "excludes": []
    },
    "version": true
}
# 2015-01-01 00:00:00==>1420041600000
GET db_apkpure_log2015*/_search
{
    "query": {
        "bool": {
            "must": 
                {
                    "range": {
                        "add_date": {
                            "gte": 1420041600000,
                            "lte": 1514735999999,
                            "format": "epoch_millis"
                        }
                    }
                }
        }
    },
    "size": 0
}


# 查询2017-06月的总下载量
GET db_apkpure_log2017-06*/_search
{
    "query": {
        "bool": {
            "must": 
                {
                    "range": {
                        "add_date": {
                            "gte": 1496246400,
                            "lte": 1514735999999,
                            "format": "epoch_millis"
                        }
                    }
                }
        }
    },
    "size": 0,
    "_source": {
        "excludes": []
    },
    "version": true
}

#2017-08-22 18:00:00.000   ==>  1503331200000
#2017-08-22 18:00:00.000   ==>  1503396000000
#2017-08-22 19:00:00.00   ==>  1503399600000
#13位长度时间戳                1514735999999
GET db_apkpure_log2017-08-22/_search
{
    "query": {
        "bool": {
            "must": 
                {
                    "range": {
                        "add_date": {
                            "gte": 1503396000000,
                            "lte": 1503399600000,
                            "format": "epoch_millis"
                        }
                    }
                }
        }
    },
    "size": 0,
    "version": true
}

