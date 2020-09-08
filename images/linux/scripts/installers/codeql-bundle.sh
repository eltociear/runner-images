#!/bin/bash
################################################################################
##  File:  codeql-bundle.sh
##  Desc:  Install the CodeQL CLI Bundle to the toolcache.
################################################################################

# Retrieve the name of the CodeQL bundle preferred by the Action (in the format codeql-bundle-YYYYMMDD).
codeql_bundle_name="$(curl -sSL https://raw.githubusercontent.com/github/codeql-action/main/src/defaults.json | jq -r .bundleVersion)"
# Convert the bundle name to a version number (0.0.0-YYYYMMDD).
codeql_bundle_version="0.0.0-${codeql_bundle_name##*-}"

extraction_directory="$AGENT_TOOLSDIRECTORY/CodeQL/$codeql_bundle_version/x64"
mkdir -p "$extraction_directory"

>&2 echo "Downloading CodeQL bundle $codeql_bundle_version..."
curl -sSL "https://github.com/github/codeql-action/releases/download/$codeql_bundle_name/codeql-bundle.tar.gz" | tar -xzC "$extraction_directory"

# Test that the tool has been extracted successfully.
"$AGENT_TOOLSDIRECTORY/CodeQL/$codeql_bundle_version/x64/codeql/codeql" version
