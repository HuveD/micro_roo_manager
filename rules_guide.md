# micro_roo_manager 문서 관리

## 문서 구조

```
docs/
├── common/           # 공통 문서 원본 관리 폴더
├── rules/            # 기본 규칙 문서 (수정하지 않음)
├── rules-architect/  # Architect 모드 규칙 문서 
├── rules-tdd-cycle/  # TDD Cycle 모드 규칙 문서
├── rules-optimizer/  # Optimizer 모드 규칙 문서
├── rules-designer/   # Designer 모드 규칙 문서
├── rules-code/       # Code 모드 규칙 문서
├── rules-spec-manager/ # Spec Manager 모드 규칙 문서
├── rules-quill/      # Quill 모드 규칙 문서
└── rules-debug/      # Debug 모드 규칙 문서
```

## 공통 문서 관리 방법

여러 모드에서 공통으로 사용되는 문서들은 `docs/common/` 폴더에서 원본을 관리합니다. 공통 문서를 수정할 때는 항상 common 폴더의 파일을 수정한 후 동기화 스크립트를 실행해 각 모드 폴더로 복사해야 합니다.

### 현재 공통 문서 목록 및 배포 대상 폴더

1. **code_quality_rules.md**
   - rules-optimizer
   - rules-code
   - rules-designer
   - rules-tdd-cycle

2. **document_optimizer_rule.md**
   - rules-quill
   - rules-spec-manager
   - rules-architect

3. **mermaid_quick_usage_guide.md**
   - rules-quill
   - rules-spec-manager
   - rules-architect

## 문서 동기화 스크립트 사용법

공통 문서를 수정한 후 해당 모드 폴더로 동기화하려면 다음 명령어를 실행합니다:

```bash
./scripts/sync_common_docs.sh
```

이 스크립트는:
1. docs/common/ 폴더의 공통 문서를 각 역할별 폴더로 복사합니다.
2. common 폴더에 파일이 없을 경우 기존 역할 폴더에서 원본을 찾아 common 폴더로 복사합니다.

## install.sh와 통합

`install.sh` 스크립트는 GitHub 저장소에서 최신 파일을 다운로드하고 설치할 때 공통 문서 동기화도 자동으로 수행합니다:

1. GitHub에서 최신 코드 다운로드
2. .roo 및 .roomodes 파일 설치
3. 공통 문서 동기화 수행 (sync_common_docs.sh 실행)
4. 동기화된 문서를 .roo 디렉토리에도 복사

## 새로운 공통 문서 추가하기

새로운 공통 문서를 추가하려면:

1. `docs/common/` 폴더에 새 문서 파일을 생성합니다.
2. `scripts/sync_common_docs.sh` 스크립트를 수정하여 새 파일과 해당 대상 폴더를 추가합니다:
   - 초기 파일 설정 부분에 새 파일 추가
   - 파일 복사 로직 부분에 새 파일과 대상 폴더 목록 추가
3. 동기화 스크립트를 실행하여 지정된 모드 폴더에 파일을 복사합니다. 