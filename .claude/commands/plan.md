# 계획 수립 실행 규칙 (Document-Driven + Domain-Driven Development)

```text
$ARGUMENTS
```

ultrathink. 위 요구사항에 대해 문서 주도 개발(Document-Driven) + 도메인 주도 개발(Domain-Driven) 원칙으로 계획을 수립하세요.

## 🚨 필수 실행 순서

### STEP 1: 초기화 및 프로젝트 Context 설정
```
MUST DO IN ORDER:
1. plan-output.md 존재 여부 확인:
   IF (plan-output.md 존재 AND TODO 목록이 비어있지 않음):
   → 메시지: "기존 plan-output.md의 TODO를 먼저 act 명령으로 완료하세요"
   → 계획 수립 중단
2. 프로젝트 Context 분석:
   - 비즈니스 도메인 식별
   - 핵심 문제 영역 파악
   - 이해관계자 요구사항 분석
   - 기술적 제약사항 확인
3. docs/ 폴더 구조 설계:
   - /product: 프로덕트 사양서, 기능 명세
   - /architecture: 시스템 설계, 클린 아키텍처
   - /domain: 도메인 모델, 비즈니스 규칙
   - /api: 인터페이스 명세서, 계약 정의
   - /testing: 테스트 전략, 시나리오
   - /implementation: 구현 가이드라인, 코딩 표준
4. 계획 수립 작업 시작:
   "프로젝트 Context 설정 및 문서 구조 생성 시작"
```

### STEP 2: 핵심 문서 작성 (단일책임 원칙 적용)
```
MUST CREATE DOCUMENTS IN ORDER:
1. 프로덕트 사양서 (docs/product/):
   - requirements.md: 비즈니스 요구사항
   - features.md: 기능 명세서
   - user-stories.md: 사용자 스토리
   - acceptance-criteria.md: 수락 기준
2. 아키텍처 설계 (docs/architecture/):
   - overview.md: 시스템 개요
   - clean-architecture.md: 레이어 구조
   - components.md: 컴포넌트 다이어그램
   - dependencies.md: 의존성 규칙
3. 도메인 모델 (docs/domain/):
   - entities.md: 엔티티 정의
   - value-objects.md: 값 객체
   - business-rules.md: 비즈니스 규칙
   - ubiquitous-language.md: 공통 언어
4. API 명세 (docs/api/):
   - contracts.md: 인터페이스 계약
   - endpoints.md: API 엔드포인트
   - error-handling.md: 에러 처리
   - examples.md: 사용 예시
5. 테스트 전략 (docs/testing/):
   - strategy.md: 테스트 전략
   - scenarios.md: 테스트 시나리오
   - unit-tests.md: 단위 테스트 계획
   - integration-tests.md: 통합 테스트 계획
6. 구현 가이드 (docs/implementation/):
   - technical-decisions.md: 기술 결정
   - coding-standards.md: 코딩 표준
   - deployment.md: 배포 가이드
```

### STEP 3: 작업 분해 및 TODO 생성
```
MUST FOLLOW Document-Driven TDD WORKFLOW:
1. 각 기능을 문서-테스트-구현-리팩토링 순으로 분해:
   - 문서 작성 작업 (우선순위: HIGHEST)
   - 테스트 작성 작업 (우선순위: HIGH)
   - 구현 작업 (우선순위: MEDIUM)
   - 리팩토링 작업 (우선순위: LOW)
2. plan-output.md에 Document-Driven TDD TODO 목록 생성:
   - [ ] docs-[도메인]-[주제]: [도메인] [주제] 문서 작성 (HIGH)
   - [ ] test-[도메인]-[기능]: [도메인] [기능] 테스트 작성 (HIGH)
   - [ ] impl-[도메인]-[기능]: [도메인] [기능] 구현 (MEDIUM)
   - [ ] refactor-[도메인]-[대상]: [도메인] [대상] 리팩토링 (LOW)
```

### STEP 4: 프로젝트 계획서 작성 (plan-output.md)
```
MUST CREATE plan-output.md WITH:

# [프로젝트명] 실행 계획

## 프로덕트 사양
### 비즈니스 요구사항
- [요구사항]: [상세 설명]
- 링크: docs/product/requirements.md

### 기능 명세
- [기능명]: [기능 설명]
- 링크: docs/product/features.md

### 사용자 스토리
- [스토리]: [수락 기준]
- 링크: docs/product/user-stories.md

## 아키텍처 설계
### 클린 아키텍처 레이어
- Presentation Layer: [담당 역할]
- Application Layer: [유스케이스]
- Domain Layer: [비즈니스 로직]
- Infrastructure Layer: [외부 시스템]
- 링크: docs/architecture/clean-architecture.md

### 컴포넌트 구조
- [컴포넌트명]: [책임과 역할]
- 링크: docs/architecture/components.md

## 도메인 모델
### 핵심 개념
- [도메인 용어]: [설명]
- 링크: docs/domain/ubiquitous-language.md

### 엔티티 및 값 객체
- [엔티티명]: [책임과 속성]
- 링크: docs/domain/entities.md, docs/domain/value-objects.md

### 비즈니스 규칙
- [규칙명]: [조건과 결과]
- 링크: docs/domain/business-rules.md

## 테스트 계획
### 테스트 전략
- [전략]: [접근 방법]
- 링크: docs/testing/strategy.md

### 단위 테스트
1. [테스트명]: [검증 내용]
- 링크: docs/testing/unit-tests.md

### 통합 테스트
1. [시나리오]: [예상 결과]
- 링크: docs/testing/integration-tests.md

## 구현 계획
### 작업 순서 (TDD)
1. [문서] → [테스트] → [구현] → [검증] → [리팩토링]

### 기술 결정
- [선택 사항]: [이유]
- 링크: docs/implementation/technical-decisions.md

## TODO 목록
### 문서화 작업 (Context 설정)
- [ ] docs-product-requirements: 프로덕트 요구사항 작성 (HIGH)
- [ ] docs-architecture-overview: 아키텍처 개요 작성 (HIGH)
- [ ] docs-domain-entities: 도메인 엔티티 정의 (HIGH)
- [ ] docs-api-contracts: API 계약 명세서 작성 (HIGH)
- [ ] docs-testing-strategy: 테스트 전략 수립 (HIGH)

### 개발 작업 (Document-Driven TDD 순서)
- [ ] test-[도메인]-[기능]: [기능] 테스트 작성 (HIGH)
- [ ] impl-[도메인]-[기능]: [기능] 구현 (MEDIUM)
- [ ] refactor-[도메인]-[기능]: [기능] 리팩토링 (LOW)

### 진행 상태
- 현재 작업: docs-product-requirements (진행중)
- 완료된 작업: 0/[총 작업 수]
- 다음 작업: test-[도메인]-[기능]

## 문서 링크 맵
- 📋 Product: docs/product/
- 🏗️ Architecture: docs/architecture/
- 🎯 Domain: docs/domain/
- 🔌 API: docs/api/
- 🧪 Testing: docs/testing/
- 💻 Implementation: docs/implementation/
```

### STEP 5: 검증 및 완료
```
CHECKLIST:
□ 모든 요구사항이 문서화되었는가?
□ 각 기능에 테스트 계획이 있는가?
□ 도메인 모델이 명확한가?
□ TODO가 TDD 순서로 생성되었는가?

계획 수립 완료:
메시지: "Document-Driven + Domain-Driven Development 계획 수립 완료. plan-output.md가 생성되었습니다. act 명령으로 Document-Driven TDD를 시작하세요."
```

## 📋 TODO 생성 규칙 (TDD)

### 작업 ID 체계:
```
테스트: test-[도메인]-[기능]
구현: impl-[도메인]-[기능]
문서: docs-[도메인]-[주제]
리팩토링: refactor-[도메인]-[대상]
```

### Document-Driven TDD 사이클 TODO:
```markdown
# plan-output.md TODO 목록 예시

## TODO 목록
### 문서화 작업 (Context 설정)
- [ ] docs-user-domain: 사용자 도메인 모델 정의 (HIGH)

### 개발 작업 (Document-Driven TDD 순서)
- [ ] test-user-login: 사용자 로그인 테스트 작성 (HIGH)
- [ ] impl-user-login: 사용자 로그인 구현 (MEDIUM)
- [ ] refactor-user-login: 로그인 코드 리팩토링 (LOW)

### 진행 상태
- 현재 작업: docs-user-domain (진행중)
- 완료된 작업: 0/4
- 다음 작업: test-user-login
```

## 🔴 Document-Driven Development 원칙

**문서 작성 순서 (Context 우선):**
1. 프로덕트 사양 정의 (Product Specification)
2. 아키텍처 설계 (Clean Architecture)
3. 도메인 모델 정의 (Domain Model)
4. API 인터페이스 명세 (Interface Contracts)
5. 테스트 전략 및 시나리오 (Test Strategy)
6. 구현 가이드라인 (Implementation Guide)

**문서 구조화 원칙:**
- 단일책임: 각 문서는 하나의 관심사만 다룸
- 의존성 역전: 상위 레벨 문서가 하위 레벨을 참조
- 개방-폐쇄: 새로운 요구사항에 확장 가능한 구조
- 인터페이스 분리: 각 이해관계자별 문서 분리

**문서 업데이트 시점:**
- 요구사항 변경 시 즉시 (Product → Architecture → Domain 순)
- 구현 중 발견사항 반영 (Architecture → Domain → Implementation 순)
- 테스트 결과 반영 (Testing → Domain → Implementation 순)

## 💡 DDD/TDD 팁

### 좋은 도메인 모델:
```
❌ UserManager, DataHelper (기술 중심)
✅ Customer, Order, Payment (도메인 중심)
```

### 좋은 테스트 이름:
```
❌ test1, testFunction
✅ should_return_error_when_password_is_invalid
✅ given_valid_user_when_login_then_return_token
```

---

## 📊 문서 Context Map

```
docs/
├── product/           # 프로덕트 사양 (비즈니스 Context)
│   ├── requirements.md    # 비즈니스 요구사항
│   ├── features.md        # 기능 명세서
│   ├── user-stories.md    # 사용자 스토리
│   └── acceptance-criteria.md # 수락 기준
├── architecture/      # 시스템 설계 (기술 Context)
│   ├── overview.md        # 시스템 개요
│   ├── clean-architecture.md # 클린 아키텍처
│   ├── components.md      # 컴포넌트 구조
│   └── dependencies.md    # 의존성 규칙
├── domain/           # 도메인 모델 (비즈니스 로직 Context)
│   ├── ubiquitous-language.md # 공통 언어
│   ├── entities.md        # 엔티티
│   ├── value-objects.md   # 값 객체
│   └── business-rules.md  # 비즈니스 규칙
├── api/              # 인터페이스 (계약 Context)
│   ├── contracts.md       # 인터페이스 계약
│   ├── endpoints.md       # API 엔드포인트
│   ├── error-handling.md  # 에러 처리
│   └── examples.md        # 사용 예시
├── testing/          # 테스트 (품질 Context)
│   ├── strategy.md        # 테스트 전략
│   ├── scenarios.md       # 테스트 시나리오
│   ├── unit-tests.md      # 단위 테스트
│   └── integration-tests.md # 통합 테스트
└── implementation/   # 구현 (개발 Context)
    ├── technical-decisions.md # 기술 결정
    ├── coding-standards.md    # 코딩 표준
    └── deployment.md          # 배포 가이드
```

**핵심: 문서가 코드를 주도하고, Context가 설계를 주도하며, 테스트가 구현을 주도합니다.**