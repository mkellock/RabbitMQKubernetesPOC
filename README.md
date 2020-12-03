# RabbitMQKubernetesPOC

This is a simple helm chart to demonstrate the following:

- Spinning up a scalable RabbitMQ cluster under Kubernetes
- Putting the cluster behind a load-balanced service
- Enabling MQTT out of the box for any instances
- Specifying soft and hard limits on RabbitMQ and pod resources

To run it, just execute the helm chart by running:

```bash
kubectl apply -f .
```

## Note

- To get a copy of kubectl, follow this guide: <https://kubernetes.io/docs/tasks/tools/install-kubectl>
- Lens is a great GUI tool in seeing how Kubernetes instances are running: <https://k8slens.dev>
- I recommend using Kind to spin up your Kubernetes clusters locally, Kind will create a disposable Kubernetes cluster in Docker which is nicer than a long lived one: <https://kind.sigs.k8s.io>
- Kind users on Windows users may want to follow this guide: <https://blog.nillsf.com/index.php/2020/08/28/running-kind-in-windows>
- I followed the tutorial by Marcel Dempers which helped immesurably: <https://youtu.be/_lpDfMkxccc>
