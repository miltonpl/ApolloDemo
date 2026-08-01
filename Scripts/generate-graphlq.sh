#!/usr/bin/env bash

set -euo pipefail

CLI="./apollo-ios-cli"

if [[ ! -x "$CLI" ]]; then
  echo "❌ Apollo iOS CLI not found at $CLI"
  exit 1
fi

echo "📥 Fetching schema..."
"$CLI" fetch-schema

echo "⚙️ Generating code..."
"$CLI" generate

echo "✅ Done!"