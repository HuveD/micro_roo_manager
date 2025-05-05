#!/bin/bash

# micro_roo_manager installation script
echo "🚀 Starting micro_roo_manager installation..."

# Set GitHub raw URL
REPO_URL="https://raw.githubusercontent.com/HuveD/micro_roo_manager/main"

# Check and install jq if not present
if ! command -v jq &> /dev/null; then
  echo "🔧 jq is not installed. Installing jq..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    brew install jq || { echo "❌ Failed to install jq. Please install it manually."; exit 1; }
  else
    # Linux (apt-based)
    sudo apt-get update && sudo apt-get install -y jq || { echo "❌ Failed to install jq. Please install it manually."; exit 1; }
  fi
fi

# Create required directory (.roo folder)
mkdir -p .roo

# Download .roomodes file
echo "⬇️ Downloading .roomodes file..."
curl -s "$REPO_URL/.roomodes" -o .roomodes

# Create rules folder structure in .roo directory
echo "⬇️ Creating rules folder structure in .roo directory..."
RULE_DIRS=(
  "rules"
  "rules-tdd"
  "rules-sparc"
  "rules-code"
  "rules-senior-coder"
  "rules-middle-coder"
  "rules-junior-coder"
  "rules-tutorial"
  "rules-supabase-admin"
  "rules-spec-pseudocode"
  "rules-security-review"
  "rules-refinement-optimization-mode"
  "rules-post-deployment-monitoring-mode" 
  "rules-mcp"
  "rules-integration"
  "rules-docs-writer"
  "rules-devops"
  "rules-debug"
  "rules-ask"
  "rules-architect"
)

# Create each rules directory
for dir in "${RULE_DIRS[@]}"; do
  mkdir -p ".roo/$dir"
done

# Download all files in each rules directory (GitHub API + jq)
GITHUB_API_URL="https://api.github.com/repos/HuveD/micro_roo_manager/contents/docs"
for dir in "${RULE_DIRS[@]}"; do
  echo "⬇️ Fetching file list for $dir..."
  files=$(curl -s "$GITHUB_API_URL/$dir" | jq -r '.[] | select(.type=="file") | .name')
  for file in $files; do
    echo "⬇️ Downloading $dir/$file..."
    curl -s "$REPO_URL/docs/$dir/$file" -o ".roo/$dir/$file" || echo "❌ Failed to download $dir/$file"
  done
done

# Download other essential files in docs directory to .roo root
echo "⬇️ Downloading other essential files..."
curl -s "$REPO_URL/docs/mcp.md" -o ".roo/mcp.md" || echo "❌ Failed to download mcp.md"
curl -s "$REPO_URL/docs/mcp.json" -o ".roo/mcp.json" || echo "❌ Failed to download mcp.json"
curl -s "$REPO_URL/docs/mcp-list.txt" -o ".roo/mcp-list.txt" || echo "❌ Failed to download mcp-list.txt"
curl -s "$REPO_URL/docs/README.md" -o ".roo/README.md" || echo "❌ Failed to download README.md"

echo "✅ Installation completed!"
echo "🔧 .roomodes file and .roo directory have been successfully installed."