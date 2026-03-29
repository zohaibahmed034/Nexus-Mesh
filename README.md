🚀 Istio Service Mesh & Traffic Orchestration (K8s)
Istio Service Mesh ka istemal karte hue microservices ki networking, security, aur observability ko manage karne ka ek mukammal project. Is project mein Bookinfo application ko deploy kiya gaya hai taake modern DevOps practices ko demonstrate kiya ja sake.

📌 Project Objectives
Is project ka maqsad Kubernetes cluster par ek robust Service Mesh layer deploy karna hai jo niche diye gaye kaam sar-anjaam deta hai:

Traffic Management: Canary deployments aur A/B testing ke liye traffic splitting.

Security (mTLS): Services के darmiyan encrypted communication (Zero-Trust Architecture).

Resilience: Fault injection, timeouts, aur circuit breaking ka implementation.

Observability: Kiali, Prometheus, aur Grafana ke zariye live traffic monitoring.

🛠 Tech Stack
Orchestration: Kubernetes (Single-node cluster)

Service Mesh: Istio v1.29.1

Monitoring: Prometheus & Grafana

Visualization: Kiali (Service Graph)

Tracing: Jaeger

Language/App: Polyglot Microservices (Bookinfo App)

🏗 Architecture Overview
Istio Control Plane (Istiod) aur Data Plane (Envoy Proxies) ka istemal karta hai. Har application pod ke saath ek Sidecar proxy attach hoti hai jo saara traffic handle karti hai.

🚦 Key Features Implemented
1. Traffic Routing & Splitting
VirtualService aur DestinationRule ka istemal karte hue traffic ko different versions (v1, v2, v3) mein divide kiya gaya.

Weighted Routing: 50/50 split v1 aur v3 ke darmiyan.

Header-based Routing: Sirf makhsoos users (e.g., "jason") ke liye v2 version active karna.

2. Zero-Trust Security (mTLS)
PeerAuthentication policy ke zariye STRICT mTLS enable kiya gaya taake sirf authorized services hi aapas mein baat kar sakein.

Authorization Policies: Role-based access control (RBAC) apply kiya gaya taake productpage service ko restrict kiya ja sake.

3. Reliability Patterns
Circuit Breaking: LEAST_CONN load balancing aur connection pooling limits set kiye gaye taake system overload na ho.

Fault Injection: Jan-boojh kar delays aur 500 errors inject kiye gaye taake system ki resiliency check ki ja sake.

📊 Monitoring & Dashboards
Service mesh ki health check karne ke liye niche diye gaye tools configure kiye gaye:

Kiali: Service topology aur traffic flow dekhne ke liye.

Grafana: Request rate, latency, aur error rates ke liye custom Istio dashboards.

🚀 How to Run
Istio Install Karein:

Bash
istioctl install --set profile=demo -y
Sidecar Injection Enable Karein:

Bash
kubectl label namespace default istio-injection=enabled
Application Deploy Karein:

Bash
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
Traffic Policies Apply Karein:

Bash
kubectl apply -f destination-rule.yaml
kubectl apply -f reviews-virtual-service.yaml
📝 Conclusion
Yeh project sabit karta hai ke kaise Istio ka istemal kar ke microservices ko baghair code change kiye secure aur scalable banaya ja sakta hai. Yeh cloud-native applications ke liye ek zaroori maharat hai.
