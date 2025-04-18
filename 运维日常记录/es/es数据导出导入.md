

导出采用常规方式

npm Install elasticdump

cd cqmdss_diag
elasticdump --input=http://elastic:nF@172.16.23.15:9200/cqmdss_diag --output=mapping.json --type=mapping
elasticdump --input=http://elastic:nF@172.16.23.15:9200/cqmdss_diag --output=settings.json --type=settings
elasticdump --input=http://elastic:nF@172.16.23.15:9200/cqmdss_diag --output=data.json --type=data --limit=10000 --concurrency=4 --scrollTime=15m
cd ..

导入采用docker+脚本


```
#!/bin/bash

# 设置目标ES地址
# %40 用于替换@
TARGET_ES="10.89.136.31:9200"
ES_AUTH="elastic:elastic%40"

# 定义索引数组
indices=(
  "cqmdss_drug"
  "cqmdss_exam"
  "cqmdss_lab"
  "cqmdss_diag"
  "cqmdss_operation"
  "cqmdss_all_20241204"
)

# 遍历处理每个索引
for index in "${indices[@]}"
do
  echo "开始导入 $index ..."

  echo "导入 settings..."
  docker run --rm -ti -v ${PWD}/$index:/tmp elasticdump/elasticsearch-dump \
    --input=/tmp/settings.json \
    --output=http://$ES_AUTH@$TARGET_ES/$index \
    --type=settings

  echo "导入 mapping..."
  docker run --rm -ti -v ${PWD}/$index:/tmp elasticdump/elasticsearch-dump \
    --input=/tmp/mapping.json \
    --output=http://$ES_AUTH@$TARGET_ES/$index \
    --type=mapping

  echo "导入 data..."
  docker run --rm -ti -v ${PWD}/$index:/tmp elasticdump/elasticsearch-dump \
    --input=/tmp/data.json \
    --output=http://$ES_AUTH@$TARGET_ES/$index \
    --type=data \
    --limit=10000 \
    --concurrency=4

  echo "$index 导入完成"
  echo "-------------------"
done

echo "所有索引导入完成！"

```
