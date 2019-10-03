Promethueus
===

https://my.oschina.net/u/2306127/blog/1828656

# Install

https://github.com/helm/charts/tree/master/stable/prometheus-operator

helm install stable/prometheus-operator

# Get Pods

kubectl get po --selector='app=prometheus'

# Upgrade

```
helm upgrade prometheus stable/prometheus
  --namespace default \
  --values values-staging.yaml
```

Note: modified config is automatically reloaded by reloader

---

# Access Prometheus & Grafana
```
PROMETHEUS_POD_NAME=$(kc get po -n default --selector='app=prometheus,component=server' -o=jsonpath='{.items[0].metadata.name}')
kubectl --namespace default port-forward ${PROMETHEUS_POD_NAME} 9090

GRAFANA_POD_NAME=$(kc get po -n default --selector='app=grafana' -o=jsonpath='{.items[0].metadata.name}')
kubectl --namespace default port-forward ${GRAFANA_POD_NAME} 3000

ALERTMANAGER_POD_NAME=$(kc get po -n default --selector='app=prometheus,component=alertmanager' -o=jsonpath='{.items[0].metadata.name}')
kubectl --namespace default port-forward ${ALERT_MANAGER_POD_NAME} 9093
```

---

# Initialize a new Grafana

### Get Grafana password
```
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

Go to localhost:3000

### Add datasource

1. Add Prometheus: url=http://prometheus-server
2. Save & Test

### Create user

1. Configuration (Left sidebar) -> Server Admin -> Users
2. New user with password
3. (Optional) Open grafana admin for user
3. (Optional) Update Main.Org. role from Viewer to Admin

### Import dashboard

1. sidebar -> Create -> Import
2. Import ./dashboards/.json
3. (Optional) Import following dashboard with id
  1. kubernetes Cluster: 6417
  2. Kafka Exporter Overview: 7589
  3. Prometheus Redis: 763
  4. Kubernetes Deployment Statefulset Daemonset metrics: 8588
  5. Haproxy Metrics Servers: 367
4. Go to grafana lab to find more dashboards
  1. https://grafana.com/dashboards/6417
  2. https://grafana.com/dashboards/7589
  3. https://grafana.com/dashboards/8588
  4. https://grafana.com/dashboards/763
  5. https://grafana.com/dashboards/367

---

# Operator (Not using)
https://github.com/helm/charts/tree/master/stable/prometheus-operator

https://github.com/helm/charts/tree/master/stable/prometheus-operator

helm install stable/prometheus-operator

---

# Exporters

### kafka exporter

https://github.com/danielqsj/kafka_exporter

1. helm install prometheus
2. helm install kafka with jmx-kafka-exporter enabled
3. Go to prometheus and search metrics: kafka-
4. Import kafka-exporter dashboard

### redis exporter

https://github.com/oliver006/redis_exporter

1. helm install prometheus
2. helm install redis-exporter
3. Config prometheus and add a new job
4. helm upgrade prometheus. The prometheus config reloader will reload config withun minutes.
5. Go to grafana and check metrics: redis-
6. Import prometheus-redis dashboard: 763
