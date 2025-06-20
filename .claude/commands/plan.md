ultrathink, 아래 지침에 따라 지금까지 논의된 사항을 분석하여 상세한 실행 계획을 수립하세요.

# ClaudeCode 스마트 계획 수립 명령어

**핵심 원칙**: 모든 계획 수립 시 프로젝트 루트의 `CLAUDE.md` 파일에 정의된 프로젝트별 지침을 최우선으로 고려하고 준수하세요.

## 1. 초기 설정 및 기존 계획 확인

### 필수 사전 확인사항
1. **프로젝트 CLAUDE.md 확인**: 프로젝트 루트의 `CLAUDE.md` 파일을 먼저 읽고 프로젝트별 지침을 파악하세요.
2. **plan-output.md 확인**: plan-output.md 존재 여부를 확인하고 다음 규칙을 따르세요:

| 상황 | 액션 |
|------|------|
| plan-output.md 있음 + 미완료 TODO 존재 | "기존 TODO를 먼저 act 명령으로 완료하세요" 응답 후 중단 |
| plan-output.md 있음 + 모든 TODO 완료 | 새 요구사항으로 전체 재작성 |
| plan-output.md 있음 + 추가 작업 필요 | 기존 계획에 통합하여 업데이트 |
| plan-output.md 없음 | 새로 생성 |

## 2. 영향 범위 심층 분석 (필수 단계)

### 🔍 의존성 분석 프로세스
작업을 시작하기 전에 반드시 다음 분석을 수행하세요:

#### 1단계: 직접 영향 파일 식별
```markdown
### 직접 변경 대상
- **파일**: [경로/파일명]
  - 변경 내용: [구체적인 변경사항]
  - 변경 이유: [왜 이 파일을 수정해야 하는지]
```

#### 2단계: 의존성 체인 추적
```markdown
### 의존성 분석
- **[변경 파일 A]**
  ├─ imports: [A가 import하는 모듈들]
  ├─ imported by: [A를 import하는 모듈들]
  ├─ interface changes: [변경되는 인터페이스/API]
  └─ data flow: [데이터 흐름에 영향받는 컴포넌트]
```

#### 3단계: 사이드 이펙트 매핑
```markdown
### 사이드 이펙트 매트릭스
| 변경사항 | 영향받는 컴포넌트 | 영향 유형 | 대응 방안 |
|---------|-----------------|-----------|-----------|
| UserService.create() 시그니처 변경 | UserController | 메서드 호출 | 파라미터 업데이트 |
| | UserRepository | 데이터 구조 | 스키마 마이그레이션 |
| | UserValidator | 검증 로직 | 새 필드 검증 추가 |
| | UserEventHandler | 이벤트 페이로드 | 이벤트 구조 업데이트 |
```

#### 4단계: 누락 위험 체크리스트
```markdown
### 누락 검증 체크리스트
- [ ] **타입/인터페이스**: 변경된 타입을 사용하는 모든 곳을 찾았는가?
- [ ] **데이터베이스**: 스키마 변경이 필요한 모든 테이블을 확인했는가?
- [ ] **API 클라이언트**: 외부 서비스나 프론트엔드에 영향이 있는가?
- [ ] **테스트 파일**: 관련된 모든 테스트 파일을 업데이트 대상에 포함했는가?
- [ ] **설정 파일**: 환경 변수나 설정 파일 변경이 필요한가?
- [ ] **문서**: API 문서나 README 업데이트가 필요한가?
- [ ] **마이그레이션**: 데이터 마이그레이션 스크립트가 필요한가?
```

### 🎯 영향 범위 분석 예시

#### 예시 1: 사용자 모델에 새 필드 추가
```markdown
### 영향 범위 분석: User 모델에 'tags' 필드 추가

#### 직접 변경 대상
- **internal/model/user.go**: tags 필드 추가 ([]string → pq.StringArray)
- **internal/repository/user_repo.go**: 쿼리 및 스캔 로직 수정

#### 의존성 체인
- **internal/model/user.go**
  ├─ imported by: service/user_service.go
  ├─ imported by: controller/user_controller.go
  ├─ imported by: repository/user_repo.go
  └─ imported by: validator/user_validator.go

#### 연쇄 영향 (도미노 효과)
1. **데이터베이스 레이어**
   - migrations/xxx_add_user_tags.sql (새로 생성 필요)
   - repository/user_repo.go의 모든 CRUD 메서드
   
2. **비즈니스 로직 레이어**
   - service/user_service.go: Create, Update, Get 메서드
   - validator/user_validator.go: 태그 검증 로직 추가
   
3. **API 레이어**
   - controller/user_controller.go: 요청/응답 DTO 수정
   - dto/user_dto.go: CreateUserRequest, UserResponse 구조체
   
4. **테스트 레이어**
   - tests/model/user_test.go
   - tests/repository/user_repo_test.go
   - tests/service/user_service_test.go
   - tests/controller/user_controller_test.go
   - tests/integration/user_flow_test.go

5. **문서 및 기타**
   - docs/api/user.md: API 명세 업데이트
   - postman/user-api.json: API 테스트 컬렉션
```

## 3. 작업 타입 자동 감지

요구사항을 분석하여 작업 타입과 최적 워크플로우를 결정하세요:

### 🔥 핫픽스/버그 수정
**키워드**: 버그, 오류, 에러, 수정, fix, bug, error, hotfix, 긴급
**TDD 워크플로우**: `재현 테스트 작성(Red) → 수정(Green) → 리팩토링(Refactor)`
```markdown
- [ ] test-reproduce-[이슈명]: 버그를 재현하는 실패 테스트 작성 - 문제 상황 명확화 (RED)
- [ ] impl-fix-[이슈명]: 테스트 통과를 위한 최소한의 버그 수정 (GREEN)
- [ ] refactor-fix-[이슈명]: 코드 품질 개선 및 추가 엣지 케이스 처리 (REFACTOR)
- [ ] test-regression-[이슈명]: 회귀 테스트 추가 - 동일 버그 재발 방지
```

### ➕ 기능 추가
**키워드**: 기능 추가, 새로운, 추가, add, feature, implement, 구현
**TDD 워크플로우**: `인터페이스 설계 → 테스트 작성(Red) → 구현(Green) → 리팩토링(Refactor)`
```markdown
- [ ] design-interface-[기능명]: 기능 인터페이스 및 API 설계 - 사용자 관점 정의
- [ ] test-spec-[기능명]: 기능 스펙을 검증하는 실패 테스트 작성 (RED)
- [ ] impl-minimal-[기능명]: 테스트 통과를 위한 최소 구현 (GREEN)
- [ ] refactor-improve-[기능명]: 코드 구조 개선 및 성능 최적화 (REFACTOR)
- [ ] test-edge-cases-[기능명]: 엣지 케이스 및 예외 상황 테스트 추가
```

### 🏗️ 아키텍처 변경
**키워드**: 아키텍처, 설계, 구조 변경, 리팩토링, architecture, design, refactor
**TDD 워크플로우**: `현재 상태 테스트 → 설계 → 점진적 변경(Red-Green-Refactor 반복)`
```markdown
- [ ] test-current-state-[변경명]: 현재 아키텍처의 동작 검증 테스트 작성 - 안전망 구축
- [ ] design-architecture-[변경명]: 새 아키텍처 설계 및 마이그레이션 전략 수립
- [ ] doc-design-[변경명]: 설계 문서 작성 (장기 가치 있는 경우)
- [ ] test-new-contract-[변경명]: 새 아키텍처의 인터페이스 테스트 작성 (RED)
- [ ] impl-adapter-[변경명]: 기존/신규 아키텍처 연결 어댑터 구현 (GREEN)
- [ ] refactor-migrate-[변경명]: 단계별 마이그레이션 실행 (REFACTOR)
- [ ] test-verify-migration-[변경명]: 전체 시스템 통합 테스트 및 성능 검증
```

### 📋 표준/가이드라인
**키워드**: 가이드, 표준, 컨벤션, 스타일, guide, standard, convention, 정책
**TDD 워크플로우**: `표준 정의 → 검증 도구 작성 → 적용 → 자동화`
```markdown
- [ ] define-standards-[표준명]: 표준 정의 및 적용 범위 설정
- [ ] test-linter-rules-[표준명]: 표준 검증을 위한 린터 규칙/테스트 작성 (RED)
- [ ] doc-standards-[표준명]: 표준 문서 및 예제 코드 작성
- [ ] impl-apply-[표준명]: 코드베이스에 표준 적용 - 린터 통과 (GREEN)
- [ ] refactor-automate-[표준명]: CI/CD 파이프라인에 자동 검증 통합 (REFACTOR)
```

### ♻️ 리팩토링
**키워드**: 최적화, 개선, 리팩토링, refactor, optimize, improve, 성능
**TDD 워크플로우**: `기존 동작 테스트 확보 → 점진적 개선(Red-Green-Refactor 반복)`
```markdown
- [ ] test-characterization-[대상명]: 현재 동작을 정확히 포착하는 특성화 테스트 작성
- [ ] test-performance-baseline-[대상명]: 성능 기준선 측정 (리팩토링 목표가 성능인 경우)
- [ ] refactor-extract-[대상명]: 중복 제거 및 추상화 - 테스트는 계속 GREEN 유지
- [ ] refactor-simplify-[대상명]: 복잡도 감소 및 가독성 개선 - 테스트는 계속 GREEN 유지
- [ ] test-verify-behavior-[대상명]: 동작 불변성 검증 및 성능 개선 확인
```

## 4. TODO 작성 규칙

**중요**: 모든 TODO는 프로젝트 루트의 `CLAUDE.md`에 정의된 코딩 규칙, 아키텍처 패턴, 명명 규칙 등을 준수해야 합니다.

### 📌 TDD 단계별 네이밍 컨벤션
| Prefix | 단계 | 설명 | 예시 |
|--------|------|------|------|
| `test-` | RED | 실패하는 테스트 작성 | `test-spec-payment`, `test-reproduce-bug` |
| `impl-` | GREEN | 테스트 통과를 위한 구현 | `impl-minimal-payment`, `impl-fix-bug` |
| `refactor-` | REFACTOR | 코드 개선 (테스트는 GREEN 유지) | `refactor-extract-service`, `refactor-simplify` |
| `design-` | 설계 | TDD 이전 인터페이스 설계 | `design-interface-api`, `design-architecture` |
| `doc-` | 문서화 | 장기 가치 문서 작성 | `doc-api-spec`, `doc-design-pattern` |

### ✅ 영향 범위를 명시한 TODO 작성 예시
```markdown
- [ ] test-spec-pq-stringarray: UserService tags 필드의 PostgreSQL 배열 타입 지원 테스트 작성 (RED) (HIGH)
  - 대상 파일: tests/service/user_service_test.go
  - 테스트 내용: pq.StringArray 타입으로 tags 저장/조회 검증
  - 예상 실패: 현재 []string 타입 사용으로 타입 불일치
  - **연관 파일**: 
    - internal/model/user.go (타입 정의)
    - internal/repository/user_repo.go (DB 쿼리)
    - internal/dto/user_dto.go (API 응답)

- [ ] impl-minimal-pq-stringarray: UserService의 tags 필드를 pq.StringArray로 변경 - 테스트 통과 목표 (GREEN) (HIGH)
  - 대상 파일: 
    - internal/service/user.go (비즈니스 로직)
    - internal/model/user.go (모델 정의)
    - internal/repository/user_repo.go (쿼리 수정)
  - 변경 이유: PostgreSQL 배열 타입 직접 지원으로 JSON 변환 오버헤드 제거
  - 예상 영향: 약 30% 쿼리 성능 향상 예상
  - **파급 효과**: 
    - controller/user_controller.go의 응답 변환 로직
    - validator/user_validator.go의 태그 검증 로직
    - 모든 user 관련 통합 테스트

- [ ] refactor-optimize-pq-stringarray: 배열 작업 헬퍼 메서드 추가 및 에러 처리 개선 (REFACTOR) (MEDIUM)
  - 대상 파일: internal/service/user.go
  - 개선 내용: Add/Remove/Contains 메서드 추가, nil 체크 강화
  - 목표: 코드 가독성 및 안정성 향상
  - **영향 최소화**: 
    - 내부 구현만 변경, 외부 인터페이스 유지
    - 기존 테스트 모두 통과 확인
```

### TODO Context 필수 요소
1. **What**: 구체적으로 무엇을 변경/추가하는가
2. **Where**: 어느 파일/모듈/패키지에 영향을 주는가
3. **Why**: 왜 이 작업이 필요한가
4. **How**: 어떤 방식으로 구현할 것인가 (필요시)
5. **Impact**: 예상되는 영향이나 결과
6. **Dependencies**: 연관된 파일/컴포넌트 명시 (누락 방지)

## 5. 문서 생성 전략

### 장기적 가치 문서 (생성 O)
| 카테고리 | 생성 조건 | 예시 |
|----------|-----------|------|
| **interfaces/** | 외부 시스템 연동, 공개 API | REST API 명세, GraphQL 스키마 |
| **design/** | 핵심 아키텍처, 복잡한 구조 | 마이크로서비스 설계, 이벤트 플로우 |
| **logic/** | 복잡한 비즈니스 규칙 | 가격 계산 로직, 권한 정책 |
| **standards/** | 팀 개발 표준 | 코딩 컨벤션, 보안 가이드 |

### 일회성 문서 (생성 X)
- 단순 버그 수정 분석
- 일회성 마이그레이션 계획
- 특정 버전 대응 문서
- 단순 기능 추가 설명

## 6. plan-output.md 템플릿

```markdown
# [작업명] 실행 계획

## 프로젝트 지침 확인
- **CLAUDE.md 준수 사항**: [프로젝트별 특별 지침 요약]

## 개요
- **작업 타입**: [자동 감지된 타입]
- **예상 소요 시간**: [추정치]
- **영향 범위**: [영향받는 모듈/서비스]

## 핵심 목표
[한 문장으로 해결하려는 문제나 달성하려는 목표 설명]

## 상세 배경
[이 작업이 필요한 이유, 현재 문제점, 기대 효과를 2-3문장으로 설명]

## 영향 범위 심층 분석

### 직접 변경 대상
[변경이 필요한 핵심 파일 목록과 변경 내용]

### 의존성 체인
[변경 파일들의 import/export 관계도]

### 사이드 이펙트 매트릭스
| 변경사항 | 영향받는 컴포넌트 | 영향 유형 | 대응 방안 |
|---------|-----------------|-----------|-----------|
| [변경 내용] | [컴포넌트] | [영향 타입] | [해결 방법] |

### 누락 위험 체크
- [ ] 모든 import하는 파일을 확인했는가?
- [ ] 테스트 파일들을 모두 포함했는가?
- [ ] API 문서 업데이트가 필요한가?
- [ ] 데이터베이스 마이그레이션이 필요한가?
- [ ] 설정 파일 변경이 필요한가?

## 기술적 접근 방법
[어떤 기술/패턴/도구를 사용하여 해결할 것인지 간략히 설명]

## 장기 가치 문서 계획
[필요한 경우만 작성]
### [interfaces/design/logic/standards]
- **문서명**: [파일명]
- **목적**: [왜 이 문서가 장기적으로 필요한지]
- **주요 내용**: [포함될 핵심 정보]

## 실행 계획 (TODO)
[작업 타입에 맞는 상세 TODO 목록 - 영향 범위 분석 결과 반영]

### 진행 현황
- **총 작업**: [N]개
- **완료**: 0개  
- **진행률**: 0%
- **현재 작업**: [첫 번째 TODO] - 대기중

## 위험 요소 및 대응 방안
[예상되는 위험이나 주의사항이 있다면 작성]

## 작업 기록
[act 명령어 실행시 자동 업데이트]
```

## 7. 검증 체크리스트

계획 수립 완료 후 다음 사항을 확인하세요:

### 기본 검증 항목
- [ ] 프로젝트 루트의 CLAUDE.md 지침을 확인하고 반영했는가?
- [ ] 모든 TODO가 What/Where/Why를 명확히 포함하는가?
- [ ] 작업 타입이 정확히 감지되었는가?
- [ ] 불필요한 일회성 문서가 포함되지 않았는가?
- [ ] 예상 영향과 기술적 접근이 명시되었는가?
- [ ] 다른 개발자가 읽고 바로 작업할 수 있을 정도로 상세한가?

### 🎯 영향 범위 검증 항목
- [ ] **의존성 분석 완료**: 변경 파일의 모든 import/export 관계를 추적했는가?
- [ ] **연쇄 반응 확인**: A→B→C와 같은 간접 영향도 모두 파악했는가?
- [ ] **테스트 커버리지**: 영향받는 모든 컴포넌트의 테스트를 확인했는가?
- [ ] **데이터 흐름**: 데이터 구조 변경이 전체 파이프라인에 미치는 영향을 확인했는가?
- [ ] **외부 인터페이스**: API, 데이터베이스, 외부 서비스 연동 부분을 확인했는가?

### 🔍 누락 방지 체크리스트
- [ ] **타입/인터페이스 변경**: 해당 타입을 사용하는 모든 파일을 찾았는가?
- [ ] **함수 시그니처 변경**: 해당 함수를 호출하는 모든 곳을 확인했는가?
- [ ] **데이터 모델 변경**: DTO, Entity, Repository 레이어를 모두 확인했는가?
- [ ] **설정/환경 변수**: 새로운 설정이 모든 환경에 반영되는가?
- [ ] **문서화**: API 문서, README, 코드 주석이 일관성 있게 업데이트되는가?

### 🎯 TDD 검증 항목
- [ ] **RED-GREEN-REFACTOR 순서**: 각 기능/버그 수정이 테스트 작성(RED)부터 시작하는가?
- [ ] **테스트 우선**: 구현(impl-) 작업 전에 반드시 테스트(test-) 작업이 있는가?
- [ ] **최소 구현**: GREEN 단계에서 "테스트 통과를 위한 최소 구현"임을 명시했는가?
- [ ] **리팩토링 포함**: 필요한 경우 REFACTOR 단계가 계획에 포함되었는가?
- [ ] **테스트 타입 명확성**: 단위/통합/E2E 등 테스트 수준이 명확한가?

### ⚠️ TDD 예외 상황 체크
- [ ] UI/UX 작업처럼 TDD가 적합하지 않은 경우, 대체 검증 방법을 명시했는가?
- [ ] 레거시 코드 수정 시, 특성화 테스트(characterization test)를 먼저 작성하는가?
- [ ] 탐색적 작업의 경우, 프로토타입 후 TDD 적용 계획이 있는가?

---

**응답**: "스마트 작업 계획 수립 완료. plan-output.md가 [생성/업데이트]되었습니다. 총 [N]개의 상세 TODO가 준비되었습니다. 영향 범위 분석을 통해 [M]개의 연관 파일을 추가로 식별했습니다. act 명령으로 실행을 시작하세요."