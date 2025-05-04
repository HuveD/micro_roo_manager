#!/bin/bash

# micro_roo_manager 설치 스크립트
echo "🚀 Starting micro_roo_manager installation..."

# GitHub raw URL 설정
REPO_URL="https://raw.githubusercontent.com/HuveD/micro_roo_manager/main"

# 필요한 디렉토리 생성 (.roo 폴더)
mkdir -p .roo

# .roomodes 파일 다운로드
echo "⬇️ Downloading .roomodes file..."
curl -s "$REPO_URL/.roomodes" -o .roomodes

# .roo 내에 rules 관련 디렉토리 생성
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

# 각 rules 디렉토리 생성
for dir in "${RULE_DIRS[@]}"; do
  mkdir -p ".roo/$dir"
done

# 각 디렉토리의 rules.md 파일 다운로드
echo "⬇️ Downloading rules files..."
for dir in "${RULE_DIRS[@]}"; do
  echo "⬇️ Downloading $dir/rules.md..."
  curl -s "$REPO_URL/docs/$dir/rules.md" -o ".roo/$dir/rules.md" || echo "❌ Failed to download $dir/rules.md"
  
  # 추가 파일 - 특정 디렉토리에서 알려진 중요 파일들 (필요한 만큼 추가)
  if [ "$dir" = "rules" ]; then
    echo "⬇️ Downloading $dir/attempt_completion_protocol.md..."
    curl -s "$REPO_URL/docs/$dir/attempt_completion_protocol.md" -o ".roo/$dir/attempt_completion_protocol.md" || echo "❌ Failed to download $dir/attempt_completion_protocol.md"
    
    echo "⬇️ Downloading $dir/subtask_protocol.md..."
    curl -s "$REPO_URL/docs/$dir/subtask_protocol.md" -o ".roo/$dir/subtask_protocol.md" || echo "❌ Failed to download $dir/subtask_protocol.md"
  fi
done

# docs 디렉토리 내 기타 필요한 파일들을 .roo 루트에 다운로드
echo "⬇️ Downloading other essential files..."
curl -s "$REPO_URL/docs/mcp.md" -o ".roo/mcp.md" || echo "❌ Failed to download mcp.md"
curl -s "$REPO_URL/docs/mcp.json" -o ".roo/mcp.json" || echo "❌ Failed to download mcp.json"
curl -s "$REPO_URL/docs/mcp-list.txt" -o ".roo/mcp-list.txt" || echo "❌ Failed to download mcp-list.txt"
curl -s "$REPO_URL/docs/README.md" -o ".roo/README.md" || echo "❌ Failed to download README.md"

echo "✅ Installation completed!"
echo "🔧 .roomodes file and .roo directory have been successfully installed."