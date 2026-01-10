# Helm Charts Repository

This repository hosts Helm charts for Kubernetes deployments.

## Usage

### Add the repository

```bash
helm repo add tets-ci-helms https://packer-builder.github.io/tets-ci-helms
helm repo update
```

### Search available charts

```bash
helm search repo tets-ci-helms
```

### Install a chart

```bash
helm install my-release tets-ci-helms/<chart-name>
```

## Available Charts

### api-service

A Helm chart for deploying API services

**Latest version:** `1.2.0`

**Available versions:** `1.2.0`, `1.1.0`, `1.0.1`, `1.0.0`, `0.2.1`, `0.2.0`

```bash
helm install my-api-service tets-ci-helms/api-service
```

### example-app

An example Helm chart for Kubernetes applications

**Latest version:** `0.7.0`

**Available versions:** `0.7.0`, `0.6.0`, `0.5.0`, `0.4.0`, `0.3.0`, `0.2.0`, `0.1.0`

```bash
helm install my-example-app tets-ci-helms/example-app
```

### frontend-service

A Helm chart for deploying Frontend services

**Latest version:** `0.5.0`

**Available versions:** `0.5.0`, `0.4.0`, `0.3.0`, `0.2.0`, `0.1.0`

```bash
helm install my-frontend-service tets-ci-helms/frontend-service
```

## Links

- [Source Repository](https://github.com/packer-builder/tets-ci-helms)
- [Helm Documentation](https://helm.sh/docs/)
