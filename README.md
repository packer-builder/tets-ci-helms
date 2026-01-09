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

| Chart | Description |
|-------|-------------|
| [api-service](https://github.com/packer-builder/tets-ci-helms/tree/main/charts/api-service) | A Helm chart for deploying API services |
| [example-app](https://github.com/packer-builder/tets-ci-helms/tree/main/charts/example-app) | An example Helm chart for Kubernetes applications |

## Links

- [Source Repository](https://github.com/packer-builder/tets-ci-helms)
- [Helm Documentation](https://helm.sh/docs/)
