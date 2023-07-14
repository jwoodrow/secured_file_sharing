#!/bin/bash

echo "set minio host"
mc alias set minio $SERVER_URL $ACCESS_KEY $ACCESS_SECRET
echo "cleanup bucket"
mc rm -r --force minio/$BUCKET_NAME
echo "create bucket"
mc mb minio/$BUCKET_NAME --region=$BUCKET_REGION
echo "done"

exec "$@"
