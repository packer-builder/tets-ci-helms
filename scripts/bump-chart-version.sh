#!/bin/bash
set -e

# Script to bump chart version based on conventional commits
# Usage: ./bump-chart-version.sh <chart-path> <bump-type>
# bump-type: major, minor, patch

CHART_PATH=$1
BUMP_TYPE=$2

if [[ -z "$CHART_PATH" || -z "$BUMP_TYPE" ]]; then
  echo "Usage: $0 <chart-path> <bump-type>"
  echo "bump-type: major, minor, patch"
  exit 1
fi

CHART_YAML="$CHART_PATH/Chart.yaml"

if [[ ! -f "$CHART_YAML" ]]; then
  echo "Error: Chart.yaml not found at $CHART_YAML"
  exit 1
fi

# Get current version
CURRENT_VERSION=$(grep '^version:' "$CHART_YAML" | awk '{print $2}')
echo "Current version: $CURRENT_VERSION" >&2

# Split version into parts
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Bump version based on type
case $BUMP_TYPE in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
  *)
    echo "Error: Invalid bump type '$BUMP_TYPE'. Use major, minor, or patch."
    exit 1
    ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
echo "New version: $NEW_VERSION" >&2

# Update Chart.yaml
sed -i.bak "s/^version: .*/version: $NEW_VERSION/" "$CHART_YAML"
rm -f "$CHART_YAML.bak"

echo "$NEW_VERSION"
