#!/bin/bash

# micro_roo_manager 공통 문서 동기화 스크립트
# docs/common/ 폴더에서 관리되는 문서를 각 역할별 폴더로 복사합니다

# 기본 경로 설정
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCS_DIR="${BASE_DIR}/docs"
COMMON_DIR="${DOCS_DIR}/specific"

# common 디렉토리가 없으면 생성
mkdir -p "${COMMON_DIR}"

# 초기 파일 설정
if [ ! -f "${COMMON_DIR}/code_quality_rules.md" ] && [ -f "${DOCS_DIR}/rules-optimizer/code_quality_rules.md" ]; then
  echo "Copying code_quality_rules.md from rules-optimizer to common directory..."
  cp "${DOCS_DIR}/rules-optimizer/code_quality_rules.md" "${COMMON_DIR}/code_quality_rules.md"
fi

if [ ! -f "${COMMON_DIR}/document_optimizer_rule.md" ] && [ -f "${DOCS_DIR}/rules-architect/document_optimizer_rule.md" ]; then
  echo "Copying document_optimizer_rule.md from rules-architect to common directory..."
  cp "${DOCS_DIR}/rules-architect/document_optimizer_rule.md" "${COMMON_DIR}/document_optimizer_rule.md"
fi

if [ ! -f "${COMMON_DIR}/mermaid_quick_usage_guide.md" ] && [ -f "${DOCS_DIR}/rules-architect/mermaid_quick_usage_guide.md" ]; then
  echo "Copying mermaid_quick_usage_guide.md from rules-architect to common directory..."
  cp "${DOCS_DIR}/rules-architect/mermaid_quick_usage_guide.md" "${COMMON_DIR}/mermaid_quick_usage_guide.md"
fi

# 공통 파일을 각 역할별 폴더로 복사
echo "💫 동기화: 공통 문서를 각 모드 폴더로 복사하는 중..."

# code_quality_rules.md 복사
if [ -f "${COMMON_DIR}/code_quality_rules.md" ]; then
  for dest_dir in "rules-optimizer" "rules-code" "rules-designer" "rules-tdd-cycle"; do
    target_dir="${DOCS_DIR}/${dest_dir}"
    mkdir -p "${target_dir}"
    echo "  ✓ code_quality_rules.md → ${dest_dir}"
    cp "${COMMON_DIR}/code_quality_rules.md" "${target_dir}/code_quality_rules.md"
  done
else
  echo "⚠️ 경고: common 디렉토리에서 code_quality_rules.md 파일을 찾을 수 없습니다."
fi

# document_optimizer_rule.md 복사
if [ -f "${COMMON_DIR}/document_optimizer_rule.md" ]; then
  for dest_dir in "rules-quill" "rules-spec-manager" "rules-architect"; do
    target_dir="${DOCS_DIR}/${dest_dir}"
    mkdir -p "${target_dir}"
    echo "  ✓ document_optimizer_rule.md → ${dest_dir}"
    cp "${COMMON_DIR}/document_optimizer_rule.md" "${target_dir}/document_optimizer_rule.md"
  done
else
  echo "⚠️ 경고: common 디렉토리에서 document_optimizer_rule.md 파일을 찾을 수 없습니다."
fi

# mermaid_quick_usage_guide.md 복사
if [ -f "${COMMON_DIR}/mermaid_quick_usage_guide.md" ]; then
  for dest_dir in "rules-quill" "rules-spec-manager" "rules-architect"; do
    target_dir="${DOCS_DIR}/${dest_dir}"
    mkdir -p "${target_dir}"
    echo "  ✓ mermaid_quick_usage_guide.md → ${dest_dir}"
    cp "${COMMON_DIR}/mermaid_quick_usage_guide.md" "${target_dir}/mermaid_quick_usage_guide.md"
  done
else
  echo "⚠️ 경고: common 디렉토리에서 mermaid_quick_usage_guide.md 파일을 찾을 수 없습니다."
fi

echo "✅ 공통 문서 동기화 완료!"
