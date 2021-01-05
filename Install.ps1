# Create MQTT namespace
kubectl apply -f Namespace.yaml

# Wait for the MQTT namespace to be created
$crd = & kubectl get ns 2>&1

while (
    ($null -eq $($crd | Where-Object { $_ -match 'mqtt' }))
    ) {
    Write-Output "Waiting for `"MQTT`" namespace to be provisioned..."

    Start-Sleep -s 1

    $crd = & kubectl get ns 2>&1
}

# Install RabbitMQ
kubectl apply -f .

# Install the monitoring stack, wait for the monitoring.coreos.com stack if still provisioning
$crd = & kubectl get crd 2>&1

while (
    ($null -eq $($crd | Where-Object { $_ -match 'alertmanagers.monitoring.coreos.com' })) -and
    ($null -eq $($crd | Where-Object { $_ -match 'prometheuses.monitoring.coreos.com' })) -and
    ($null -eq $($crd | Where-Object { $_ -match 'servicemonitors.monitoring.coreos.com' }))
    ) {
    Write-Output "Waiting for custom resources to be provisioned..."

    Start-Sleep -s 1

    $crd = & kubectl get crd 2>&1
}

kubectl apply -f Monitoring/ 