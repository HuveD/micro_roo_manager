#!/bin/bash

# micro_roo_manager 설치 스크립트
echo "🚀 micro_roo_manager 설치를 시작합니다..."

# GitHub raw URL 설정
REPO_URL="https://raw.githubusercontent.com/HuveD/micro_roo_manager/main"

# 필요한 디렉토리 생성 (.roo 폴더)
mkdir -p .roo

# .roomodes 파일 다운로드
echo "⬇️ .roomodes 파일을 다운로드하는 중..."
curl -s "$REPO_URL/.roomodes" -o .roomodes

# .roo 내에 rules 관련 디렉토리 생성
echo "⬇️ .roo 디렉토리에 rules 폴더 구조 생성 중..."
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
echo "⬇️ rules 파일들을 다운로드하는 중..."
for dir in "${RULE_DIRS[@]}"; do
  echo "⬇️ $dir/rules.md 다운로드 중..."
  curl -s "$REPO_URL/docs/$dir/rules.md" -o ".roo/$dir/rules.md" || echo "❌ $dir/rules.md 다운로드 실패"
  
  # 추가 파일 - 특정 디렉토리에서 알려진 중요 파일들 (필요한 만큼 추가)
  if [ "$dir" = "rules" ]; then
    echo "⬇️ $dir/attempt_completion_protocol.md 다운로드 중..."
    curl -s "$REPO_URL/docs/$dir/attempt_completion_protocol.md" -o ".roo/$dir/attempt_completion_protocol.md" || echo "❌ $dir/attempt_completion_protocol.md 다운로드 실패"
    
    echo "⬇️ $dir/subtask_protocol.md 다운로드 중..."
    curl -s "$REPO_URL/docs/$dir/subtask_protocol.md" -o ".roo/$dir/subtask_protocol.md" || echo "❌ $dir/subtask_protocol.md 다운로드 실패"
  fi
done

# docs 디렉토리 내 기타 필요한 파일들을 .roo 루트에 다운로드
echo "⬇️ 기타 필수 파일 다운로드 중..."
curl -s "$REPO_URL/docs/mcp.md" -o ".roo/mcp.md" || echo "❌ mcp.md 다운로드 실패"
curl -s "$REPO_URL/docs/mcp.json" -o ".roo/mcp.json" || echo "❌ mcp.json 다운로드 실패"
curl -s "$REPO_URL/docs/mcp-list.txt" -o ".roo/mcp-list.txt" || echo "❌ mcp-list.txt 다운로드 실패"
curl -s "$REPO_URL/docs/README.md" -o ".roo/README.md" || echo "❌ README.md 다운로드 실패"

echo "✅ 설치가 완료되었습니다!"
echo "🔧 .roomodes 파일과 .roo 디렉토리가 성공적으로 설치되었습니다."

# 스크립트 자체 삭제
echo "🧹 설치 스크립트를 삭제합니다..."
rm -- "$0" 