#!/bin/bash

# micro_roo_manager 공통 문서 동기화 스크립트
# docs/specific/ 폴더에서 관리되는 문서를 각 역할별 폴더로 복사합니다

# 인수로 기본 경로를 받을 수 있게 함
if [ "$#" -ge 1 ]; then
  BASE_DIR="$1"
else
  # 기본 경로 설정 (인수가 없을 경우)
  BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

DOCS_DIR="${BASE_DIR}/docs"
SPECIFIC_DIR="${DOCS_DIR}/specific"

echo "🔍 문서 동기화 실행 경로: ${BASE_DIR}"
echo "📁 대상 문서 경로: ${DOCS_DIR}"

# specific 디렉토리가 없는 경우 오류 메시지 출력
if [ ! -d "${SPECIFIC_DIR}" ]; then
  echo "⚠️ 오류: specific 디렉토리(${SPECIFIC_DIR})가 존재하지 않습니다."
  exit 1
fi

# 공통 파일을 각 역할별 폴더로 복사 (지정된 BASE_DIR 내에서만 작업)
echo "💫 동기화: 공통 문서를 각 모드 폴더로 복사하는 중..."

# code_quality_rules.md 복사
if [ -f "${SPECIFIC_DIR}/code_quality_rules.md" ]; then
  for dest_dir in "rules-optimizer" "rules-code" "rules-micro-coder" "rules-designer" "rules-tdd-cycle"; do
    target_dir="${DOCS_DIR}/${dest_dir}"
    mkdir -p "${target_dir}"
    echo "  ✓ code_quality_rules.md → ${dest_dir}"
    cp "${SPECIFIC_DIR}/code_quality_rules.md" "${target_dir}/code_quality_rules.md"
  done
else
  echo "⚠️ 경고: specific 디렉토리에서 code_quality_rules.md 파일을 찾을 수 없습니다."
fi

# document_optimizer_rule.md 복사
if [ -f "${SPECIFIC_DIR}/document_optimizer_rule.md" ]; then
  for dest_dir in "rules-quill" "rules-spec-manager" "rules-architect"; do
    target_dir="${DOCS_DIR}/${dest_dir}"
    mkdir -p "${target_dir}"
    echo "  ✓ document_optimizer_rule.md → ${dest_dir}"
    cp "${SPECIFIC_DIR}/document_optimizer_rule.md" "${target_dir}/document_optimizer_rule.md"
  done
else
  echo "⚠️ 경고: specific 디렉토리에서 document_optimizer_rule.md 파일을 찾을 수 없습니다."
fi

# mermaid_quick_usage_guide.md 복사
if [ -f "${SPECIFIC_DIR}/mermaid_quick_usage_guide.md" ]; then
  for dest_dir in "rules-quill" "rules-spec-manager" "rules-architect"; do
    target_dir="${DOCS_DIR}/${dest_dir}"
    mkdir -p "${target_dir}"
    echo "  ✓ mermaid_quick_usage_guide.md → ${dest_dir}"
    cp "${SPECIFIC_DIR}/mermaid_quick_usage_guide.md" "${target_dir}/mermaid_quick_usage_guide.md"
  done
else
  echo "⚠️ 경고: specific 디렉토리에서 mermaid_quick_usage_guide.md 파일을 찾을 수 없습니다."
fi

echo "✅ 공통 문서 동기화 완료!"
