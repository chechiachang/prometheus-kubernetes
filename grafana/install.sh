#!/bin/bash

helm upgrade --install grafana stable/grafana \
  --namespace default \
  --values values-staging.yaml
