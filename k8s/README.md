# Deploy hello-world

Deploy hello-world to kubernetes with mongodb

---

## Requirements

* k8s >= 1.6.0

---

## Usage

### Creating the MongoDB Service

To start the service, run:

```sh
kubectl create -f mongo-service.yaml
```

### Creating the MongoDB Controller

To start the controller, run:

```sh
kubectl create -f mongo-controller.yaml
```

At this point, MongoDB is up and running.

Note: There is no password protection or auth running on the database by default. Please keep this in mind!

### Creating the Node.js Service

To start the service, run:

```sh
kubectl create -f web-service.yaml
```

If you are running on a platform that does not support LoadBalancer (i.e Bare Metal), you need to use a NodePort with your own load balancer.

You may also need to open appropriate Firewall ports to allow traffic.

### Creating the Node.js Controller

To start the Controller, run:

```sh
kubectl create -f web-controller.yaml
```

For minikube try http://[minikube ip]:[assigned port]

---
