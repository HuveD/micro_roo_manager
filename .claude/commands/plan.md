$ARGUMENTS. ultrathink.
위 요구사항을 분석하여 Universal Document-Driven Development 원칙으로 작업 계획을 수립하세요.

먼저 plan-output.md가 존재하는지 확인하세요:

**기존 plan-output.md가 있고 미완료 TODO가 있는 경우**:
- "기존 plan-output.md의 TODO를 먼저 act 명령으로 완료하세요"라고 응답하고 중단

**기존 plan-output.md가 있고 모든 TODO가 완료된 경우**:
- 기존 내용을 읽어서 새로운 요구사항으로 덮어쓰기

**plan-output.md가 없는 경우**:
- 새로 생성

## 범용 분석 프로세스

요구사항을 다음 관점에서 분석하세요:

### 1. 기능 분해 (프로젝트 타입 무관)
- 핵심 기능과 해결하려는 문제 파악
- 기능 간 의존성과 우선순위 식별
- 사용자 인터랙션 포인트 확인

### 2. 도메인 추상화
- 비즈니스 로직과 기술 구현 분리
- 핵심 개념과 규칙 식별
- 데이터 흐름과 상태 변화 파악

### 3. 인터페이스 식별
- 내부/외부 경계 구분
- 입력/출력 명세 정의
- 통신 방식과 데이터 형식 결정

## 범용 문서 카테고리

요구사항에 따라 필요한 문서만 선택하세요:

### requirements/ (필수)
- 기능 요구사항과 제약사항
- 사용자 시나리오와 비즈니스 규칙
- 성능, 보안, 가용성 요구사항

### design/ (복잡한 시스템의 경우)
- 전체 구조 설계
- 모듈/컴포넌트 구조
- 데이터 모델과 상태 관리
- UI/UX 설계 (필요시)

### interfaces/ (외부 연동이 있는 경우)
- API 명세 (REST/GraphQL/CLI 등)
- 이벤트 인터페이스
- 데이터 스키마
- 외부 시스템 연동 규격

### logic/ (비즈니스 로직이 복잡한 경우)
- 도메인 규칙과 정책
- 비즈니스 워크플로우
- 계산 로직과 알고리즘
- 상태 기계와 생명주기

### testing/ (품질 기준이 높은 경우)
- 테스트 전략과 방법론
- 테스트 시나리오와 케이스
- 성능/보안 테스트 계획
- 자동화 전략

### implementation/ (기술 결정이 필요한 경우)
- 기술 스택과 아키텍처 선택
- 개발 환경과 도구 설정
- 배포와 운영 가이드
- 코딩 컨벤션과 품질 기준

## 범용 TODO 구조

각 기능을 Universal Document-Driven TDD 순서로 분해하세요:

### 계획 단계
- plan-[기능]: 요구사항 분석 및 설계 계획 (HIGH)

### 문서화 단계  
- doc-[영역]-[주제]: 필요한 명세서 작성 (HIGH)

### 테스트 단계
- test-[기능]-[시나리오]: 테스트 케이스 작성 (HIGH)

### 구현 단계
- impl-[기능]-[컴포넌트]: 최소 구현 (MEDIUM)
- refactor-[기능]-[대상]: 코드 품질 개선 (LOW)

## plan-output.md 형식

```markdown
# [프로젝트명] 실행 계획

## 요구사항 분석

### 핵심 기능
- [기능1]: [기능 설명과 해결하는 문제]
- [기능2]: [기능 설명과 해결하는 문제]

### 도메인 개념
- [개념1]: [정의와 비즈니스 규칙]
- [개념2]: [정의와 비즈니스 규칙]

### 인터페이스 요구사항
- [내부 인터페이스]: [모듈 간 통신]
- [외부 인터페이스]: [사용자/시스템 간 통신]

## 필요 문서 계획

[요구사항에 따라 필요한 카테고리만 포함]

### 요구사항 명세 (필수)
- [요구사항 항목]: [상세 설명]
- 링크: docs/requirements/[파일명]

### 설계 문서 (필요시)
- [설계 고려사항]: [설명]
- 링크: docs/design/[파일명]

### 인터페이스 명세 (필요시)
- [인터페이스 종류]: [설명]
- 링크: docs/interfaces/[파일명]

### 비즈니스 로직 (필요시)
- [도메인 규칙]: [설명]
- 링크: docs/logic/[파일명]

### 테스트 전략 (필요시)
- [테스트 접근법]: [설명]
- 링크: docs/testing/[파일명]

### 구현 가이드 (필요시)
- [기술 결정]: [설명]
- 링크: docs/implementation/[파일명]

## TODO 목록
- [ ] plan-[프로젝트]: 전체 프로젝트 계획 수립 (HIGH)
  - [ ] plan-[핵심기능1]: [기능명] 상세 계획
  - [ ] plan-[핵심기능2]: [기능명] 상세 계획
  - [ ] plan-dependencies: 기능 간 의존성 분석
- [ ] doc-requirements-[주제]: [요구사항] 명세 작성 (HIGH)
  - [ ] doc-requirements-functional: 기능 요구사항 명세
  - [ ] doc-requirements-non-functional: 비기능 요구사항 명세
- [ ] doc-design-[주제]: [설계] 문서 작성 (HIGH)
  - [ ] doc-design-architecture: 전체 구조 설계
  - [ ] doc-design-components: 컴포넌트 설계
- [ ] doc-interfaces-[주제]: [인터페이스] 명세 작성 (HIGH)
  - [ ] doc-interfaces-api: API 명세
  - [ ] doc-interfaces-data: 데이터 모델 명세
- [ ] test-[기능1]-[시나리오]: [기능] 테스트 작성 (HIGH)
  - [ ] test-[기능1]-unit: 단위 테스트 설계
  - [ ] test-[기능1]-integration: 통합 테스트 설계
- [ ] test-[기능2]-[시나리오]: [기능] 테스트 작성 (HIGH)
  - [ ] test-[기능2]-unit: 단위 테스트 설계
  - [ ] test-[기능2]-integration: 통합 테스트 설계
- [ ] impl-[기능1]-[컴포넌트]: [기능] 구현 (MEDIUM)
  - [ ] impl-[기능1]-core: 핵심 로직 구현
  - [ ] impl-[기능1]-interface: 인터페이스 구현
- [ ] impl-[기능2]-[컴포넌트]: [기능] 구현 (MEDIUM)
  - [ ] impl-[기능2]-core: 핵심 로직 구현
  - [ ] impl-[기능2]-interface: 인터페이스 구현
- [ ] quality-requirements: 요구사항 추적 가능성 확보 (HIGH)
- [ ] quality-test-coverage: 핵심 로직 테스트 커버리지 100% (HIGH)
- [ ] quality-documentation: 문서화 완성도 검증 (MEDIUM)
- [ ] quality-code-standards: 코드 품질 기준 준수 (MEDIUM)
- [ ] quality-performance: 성능 요구사항 충족 (LOW)
- [ ] refactor-[기능1]: [기능] 리팩토링 (LOW)
  - [ ] refactor-[기능1]-structure: 코드 구조 개선
  - [ ] refactor-[기능1]-performance: 성능 최적화
- [ ] refactor-[기능2]: [기능] 리팩토링 (LOW)
  - [ ] refactor-[기능2]-structure: 코드 구조 개선
  - [ ] refactor-[기능2]-performance: 성능 최적화

### 진행 상태
- 총 작업 수: [N]개
- 완료된 작업: 0개
- 진행률: 0%
- 현재 작업: [첫 번째 TODO] (대기중)
- 다음 작업: [두 번째 TODO]

## 작업 기록
[act 명령어가 업데이트]
```

## 검증 기준

계획 수립이 완료되면 다음을 확인하세요:

### 완성도 체크
- [ ] 요구사항이 기능 중심으로 분해되었는가?
- [ ] 프로젝트 타입에 관계없이 적용 가능한가?
- [ ] Document-Driven TDD 순서가 명확한가?
- [ ] TODO가 실행 가능하고 구체적인가?

### 범용성 체크
- [ ] Frontend 프로젝트에 적용 가능한가?
- [ ] Backend 프로젝트에 적용 가능한가?
- [ ] Mobile App 프로젝트에 적용 가능한가?
- [ ] CLI 도구 프로젝트에 적용 가능한가?

"Universal Document-Driven Development 계획 수립 완료. plan-output.md가 생성/업데이트되었습니다. act 명령으로 Universal Document-Driven TDD를 시작하세요."라고 응답하세요.