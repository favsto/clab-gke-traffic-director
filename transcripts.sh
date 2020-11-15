# create the cluster
# ...

# firewall rules
gcloud compute --project=fausto-labs firewall-rules create fw-allow-health-checks --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp --source-ranges=35.191.0.0/16,130.211.0.0/22

# the importance of setting NEG into YAMLs

# create app
kubectl create -f traffic-director-app.yaml

kubectl get svc
kubectl get pods

# recording the NEG name
# https://cloud.google.com/traffic-director/docs/set-up-gke-pods?hl=en_US#recording_the_neg_name

NEG_NAME=<neg-name-from-console>
# NEG_NAME=k8s1-3dd59e00-default-service-test-80-XYZ

# Creating the health check
gcloud beta compute health-checks create http td-gke-health-check --project=fausto-labs --port=80 --request-path=/ --proxy-header=NONE --no-enable-logging --check-interval=5 --timeout=5 --unhealthy-threshold=2 --healthy-threshold=2

# Creating the backend service
# ...