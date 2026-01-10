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
| [api-service](./charts/api-service) | 1.0.1 | 1.0.0 | A Helm chart for deploying API services |
| [example-app](./charts/example-app) | 0.4.0 | 1.0.3 | An example Helm chart for Kubernetes applications |
| [frontend-service](./charts/frontend-service) | 0.3.0 | 1.0.0 | A Helm chart for deploying Frontend services |

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

### Release Please

This repository uses [Release Please](https://github.com/googleapis/release-please) to automate releases for each chart independently.

**How it works:**

1. When you push commits to `main` that affect a chart (e.g., `charts/api-service/`), Release Please creates a PR for that specific chart
2. The PR includes:
   - Automatic version bump in `Chart.yaml`
   - Generated CHANGELOG based on conventional commits
3. When you merge the PR, a GitHub Release is created with a tag like `api-service-v1.2.0`

**Configuration files:**

| File | Description |
|------|-------------|
| `release-please-config.json` | Defines packages and release settings for each chart |
| `.release-please-manifest.json` | Tracks current versions of each chart |

**Adding a new chart to Release Please:**

1. Add the chart to `release-please-config.json`:
   ```json
   "charts/my-new-chart": {
     "release-type": "helm",
     "component": "my-new-chart"
   }
   ```

2. Add the initial version to `.release-please-manifest.json`:
   ```json
   "charts/my-new-chart": "0.1.0"
   ```

### Testing locally

```bash
# Lint charts
ct lint --config ct.yaml

# Test chart installation (requires kind or minikube)
ct install --config ct.yaml
```

## License

See [LICENSE](./LICENSE) for details.
