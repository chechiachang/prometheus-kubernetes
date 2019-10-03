#!/bin/bash

helm upgrade --install prometheus stable/prometheus \
  --namespace default \
  --values values-staging.yaml
