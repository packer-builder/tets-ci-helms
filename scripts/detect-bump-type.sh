#!/bin/bash
set -e

# Analyzes conventional commits for a chart and determines bump type
# Usage: ./detect-bump-type.sh <chart-name>
# Returns: major, minor, or patch

CHART_NAME=$1

if [[ -z "$CHART_NAME" ]]; then
  echo "patch"
  exit 0
fi

# Get commits since last tag for this chart (or all commits if no tag exists)
LAST_TAG=$(git tag -l "${CHART_NAME}-*" --sort=-v:refname | head -n1)

if [[ -n "$LAST_TAG" ]]; then
  COMMITS=$(git log "$LAST_TAG"..HEAD --oneline -- "charts/$CHART_NAME")
else
  COMMITS=$(git log --oneline -- "charts/$CHART_NAME")
fi

if [[ -z "$COMMITS" ]]; then
  echo "patch"
  exit 0
fi

# Check for breaking changes (major bump)
if echo "$COMMITS" | grep -qE '(BREAKING CHANGE|!:)'; then
  echo "major"
  exit 0
fi

# Check for features (minor bump)
if echo "$COMMITS" | grep -qE '^[a-f0-9]+ feat(\(.+\))?:'; then
  echo "minor"
  exit 0
fi

# Default to patch for fixes, chores, etc.
echo "patch"
