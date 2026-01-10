# Helm Charts Repository

This repository contains Helm charts for Kubernetes deployments.

## Usage

### Add the Helm repository

```bash
helm repo add tets-ci-helms https://packer-builder.github.io/tets-ci-helms
helm repo update
```

### Install a chart

```bash
helm install <release-name> <repo-name>/<chart-name>
```

## Available Charts

| Chart | Version | App Version | Description |
|-------|---------|-------------|-------------|
| [api-service](./charts/api-service) | 1.2.0 | 1.0.0 | A Helm chart for deploying API services |
| [example-app](./charts/example-app) | 0.7.0 | 1.0.3 | An example Helm chart for Kubernetes applications |
| [frontend-service](./charts/frontend-service) | 0.5.0 | 1.0.0 | A Helm chart for deploying Frontend services |

## Development

### Prerequisites

- [Helm](https://helm.sh/docs/intro/install/) v3.x
- [helm-docs](https://github.com/norwoodj/helm-docs) for documentation generation
- [chart-testing](https://github.com/helm/chart-testing) for linting and testing

### Adding a new chart

1. Create a new directory under `charts/`
2. Add your chart files (`Chart.yaml`, `values.yaml`, `templates/`)
3. Copy the `README.md.gotmpl` template from an existing chart
4. Run `helm-docs` to generate documentation

### Commit conventions

This repository uses [Conventional Commits](https://www.conventionalcommits.org/) for automatic versioning:

- `feat(chart-name): description` - Minor version bump
- `fix(chart-name): description` - Patch version bump
- `feat(chart-name)!: description` - Major version bump (breaking change)

### Testing locally

```bash
# Lint charts
ct lint --config ct.yaml

# Test chart installation (requires kind or minikube)
ct install --config ct.yaml
```

## License

See [LICENSE](./LICENSE) for details.
