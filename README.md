🚀 Project : Configuring and Using Service Mesh (Istio)
📌 Overview

This lab demonstrates how to deploy and configure a service mesh using Istio on a Kubernetes cluster.

You will learn how to manage microservices traffic, secure communication with mTLS, and monitor service behavior using modern cloud-native tools.

🎯 Objectives

By completing this lab, you will:

Deploy and configure Istio Service Mesh
Understand service mesh architecture
Configure traffic routing & load balancing
Implement mTLS (Mutual TLS)
Monitor services using observability tools
Apply traffic policies (retries, circuit breakers, fault injection)
🧠 Prerequisites

Before starting:

Basic understanding of Kubernetes (Pods, Services, Deployments)
Familiarity with kubectl
YAML configuration knowledge
Microservices architecture basics
Networking fundamentals (HTTP, TLS, Load Balancing)
🏗️ Lab Environment
Ubuntu 22.04 LTS
Pre-configured Kubernetes Cluster
Internet connectivity
Full permissions enabled
⚙️ Task 1: Deploy Istio
📥 Install Istio
curl -L https://istio.io/downloadIstio | sh -
cd istio-*
export PATH=$PWD/bin:$PATH
istioctl version
🚀 Install Istio on Cluster
istioctl install --set values.defaultRevision=default
kubectl get pods -n istio-system
🔄 Enable Sidecar Injection
kubectl label namespace default istio-injection=enabled
kubectl get namespace -L istio-injection
📦 Task 2: Deploy Sample Application
📚 Deploy Bookinfo App
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get pods
kubectl get services
🌐 Configure Gateway
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl get svc istio-ingressgateway -n istio-system
🔀 Task 3: Traffic Management
🎯 Destination Rule
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
⚖️ Traffic Splitting
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
kubectl apply -f reviews-virtual-service.yaml
🔐 Task 4: Enable mTLS Security
🛡️ Peer Authentication
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
spec:
  mtls:
    mode: STRICT
kubectl apply -f peer-authentication.yaml
✅ Verify mTLS
istioctl authn tls-check productpage.default.svc.cluster.local
📊 Task 5: Observability
📈 Install Monitoring Tools
kubectl apply -f samples/addons/kiali.yaml
kubectl apply -f samples/addons/prometheus.yaml
kubectl apply -f samples/addons/grafana.yaml
kubectl apply -f samples/addons/jaeger.yaml
🌐 Access Dashboards
🔍 Kiali
kubectl port-forward -n istio-system svc/kiali 20001:20001
📊 Grafana
kubectl port-forward -n istio-system svc/grafana 3000:3000
⚡ Task 6: Advanced Traffic Management
💥 Fault Injection
fault:
  delay:
    percentage:
      value: 50
    fixedDelay: 5s
  abort:
    percentage:
      value: 10
    httpStatus: 500
⏱️ Timeout & Retry
timeout: 3s
retries:
  attempts: 3
  perTryTimeout: 1s
🛠️ Troubleshooting
Issue	Solution
Pods not ready	Restart deployment
Gateway not working	Check external IP
mTLS failure	Verify PeerAuthentication
Monitoring not working	Check add-ons
🧪 Verification Commands
istioctl verify-install
istioctl proxy-status
istioctl analyze
🧹 Cleanup
kubectl delete -f samples/bookinfo/
kubectl delete -f samples/addons/
istioctl uninstall --purge
kubectl delete namespace istio-system
🎉 Conclusion

In this lab, you successfully:

Deployed Istio Service Mesh
Managed traffic routing and load balancing
Secured services with mTLS
Implemented observability and monitoring
Applied resilience patterns (retries, circuit breakers)
💡 Why This Matters

Service Mesh is critical for modern cloud-native applications:

🔐 Secure communication (mTLS)
🔄 Intelligent traffic routing
📊 Deep observability
⚡ Resilience and fault tolerance
👨‍💻 Author

Zohaib Ahmed
DevOps Engineer | Kubernetes | Cloud | AI/ML
