#!/bin/bash
set -e

# Generates the root README.md with a table of all available charts
# Usage: ./generate-root-readme.sh

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
CHARTS_DIR="$REPO_ROOT/charts"
README_FILE="$REPO_ROOT/README.md"

# Get repository info from git remote
REPO_URL=$(git remote get-url origin 2>/dev/null | sed 's/\.git$//' | sed 's/git@github.com:/https:\/\/github.com\//' || echo "https://github.com/owner/repo")
REPO_OWNER=$(echo "$REPO_URL" | sed 's|https://github.com/||' | cut -d'/' -f1)
REPO_NAME=$(echo "$REPO_URL" | sed 's|https://github.com/||' | cut -d'/' -f2)

cat > "$README_FILE" << 'HEADER'
# Helm Charts Repository

This repository contains Helm charts for Kubernetes deployments.

## Usage

### Add the Helm repository

```bash
HEADER

echo "helm repo add ${REPO_NAME} https://${REPO_OWNER}.github.io/${REPO_NAME}" >> "$README_FILE"
echo "helm repo update" >> "$README_FILE"

cat >> "$README_FILE" << 'MIDDLE'
```

### Install a chart

```bash
helm install <release-name> <repo-name>/<chart-name>
```

## Available Charts

| Chart | Version | App Version | Description |
|-------|---------|-------------|-------------|
MIDDLE

# Iterate through all charts and extract info
for chart_dir in "$CHARTS_DIR"/*/; do
  if [[ -f "${chart_dir}Chart.yaml" ]]; then
    chart_name=$(basename "$chart_dir")
    version=$(grep '^version:' "${chart_dir}Chart.yaml" | awk '{print $2}')
    app_version=$(grep '^appVersion:' "${chart_dir}Chart.yaml" | awk '{print $2}' | tr -d '"')
    description=$(grep '^description:' "${chart_dir}Chart.yaml" | sed 's/^description: //')

    echo "| [${chart_name}](./charts/${chart_name}) | ${version} | ${app_version} | ${description} |" >> "$README_FILE"
  fi
done

cat >> "$README_FILE" << 'FOOTER'

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
FOOTER

echo "Generated: $README_FILE"
