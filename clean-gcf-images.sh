#!/bin/sh
# thanks https://zenn.dev/imaginelab/scraps/a9257aac32d0be

PROJECT="${PROJECT:-$1}"
[ -z "$PROJECT" ] && echo "usage: ./clean-gcf-images.sh <project-id>" && exit 1

CONTAINER_REGISTRY="asia.gcr.io/$PROJECT/gcf/asia-northeast1"
IMAGE_LIST=`gcloud container images list --repository=$CONTAINER_REGISTRY | awk 'NR!=1'`
for line in $IMAGE_LIST; do
  gcloud container images --project $PROJECT delete "$line/worker" --quiet & gcloud container images --project $PROJECT delete "$line/cache" --quiet &
done
wait