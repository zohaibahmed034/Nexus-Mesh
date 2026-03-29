# 🚀 Configuring and Using Service Mesh (Istio)

## 🔧 Overview
This project demonstrates how to deploy and configure Istio service mesh on a Kubernetes cluster.  
You will learn microservices traffic management, secure communication using mTLS, and observability using modern DevOps tools.

## 🎯 Objectives
- Deploy and configure Istio Service Mesh  
- Understand service mesh architecture  
- Configure traffic routing and load balancing  
- Implement Mutual TLS (mTLS)  
- Apply retries, circuit breakers, and fault injection  
- Monitor services using Grafana and Kiali  

## 🧠 Prerequisites
- Basic understanding of Kubernetes (Pods, Services, Deployments)  
- Familiarity with kubectl command-line tool  
- Knowledge of YAML configuration files  
- Understanding of microservices architecture  
- Basic networking concepts (HTTP, TLS, Load Balancing)  

## 🏗️ Architecture
User → Istio Gateway → VirtualService → Services (v1, v2, v3)  
DestinationRule → Pods with Sidecar Proxy  

## ⚙️ Setup Instructions

### 1️⃣ Install Istio
```bash

curl -L https://istio.io/downloadIstio | sh -
cd istio-*
export PATH=$PWD/bin:$PATH
istioctl version

2️⃣ Install Istio on Cluster

istioctl install --set values.defaultRevision=default
kubectl get pods -n istio-system

3️⃣ Enable Sidecar Injection

kubectl label namespace default istio-injection=enabled
4️⃣ Deploy Sample Application

kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get pods
kubectl get services

🔀 Traffic Management

Destination Rule
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: reviews
spec:
  host: reviews
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
  - name: v3
    labels:
      version: v3
kubectl apply -f destination-rule.yaml
Traffic Splitting
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  http:
  - route:
    - destination:
        host: reviews
        subset: v1
      weight: 50
    - destination:
        host: reviews
        subset: v3

      weight: 50

🔐 Security (mTLS)

Enable mTLS
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
spec:
  mtls:
    mode: STRICT
kubectl apply -f peer-authentication.yaml

📊 Observability

Install Tools
kubectl apply -f samples/addons/kiali.yaml
kubectl apply -f samples/addons/prometheus.yaml
kubectl apply -f samples/addons/grafana.yaml
Access Dashboards
Kiali: kubectl port-forward svc/kiali -n istio-system 20001:20001
Grafana: kubectl port-forward svc/grafana -n istio-system 3000:3000

⚡ Advanced Features

Fault Injection (simulate delays and errors)
Timeout and Retry (improve resilience)

🛠️ Troubleshooting

Pods not ready → Restart deployment
Gateway not working → Check external IP
mTLS issue → Verify PeerAuthentication
Monitoring issue → Check add-ons

🧪 Verification

istioctl verify-install
istioctl proxy-status
istioctl analyze

🧹 Cleanup

kubectl delete -f samples/bookinfo/
kubectl delete -f samples/addons/
istioctl uninstall --purge
kubectl delete namespace istio-system

🎉 Key Learnings

Service Mesh Architecture
Secure communication with mTLS
Traffic routing and load balancing
Observability and monitoring
Resilience engineering
👨‍💻 Author

Zohaib Ahmed
DevOps Engineer | Kubernetes | Cloud | AI/ML
