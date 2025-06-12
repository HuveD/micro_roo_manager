ultrathink, 지금까지 논의된 사항을 분석하여 작업 타입에 최적화된 스마트 계획을 수립하세요.

먼저 plan-output.md가 존재하는지 확인하세요:

**기존 plan-output.md가 있고 기존 계획에 추가 작업이 필요한 경우**:
- 업데이트된 계획에 맞게 TODO 추가 및 우선 순위 재조정

**기존 plan-output.md가 있고 미완료 TODO가 있는 경우**:
- "기존 plan-output.md의 TODO를 먼저 act 명령으로 완료하세요"라고 응답하고 중단

**기존 plan-output.md가 있고 모든 TODO가 완료된 경우**:
- 기존 내용을 읽어서 새로운 요구사항으로 덮어쓰기

**plan-output.md가 없는 경우**:
- 새로 생성

## 스마트 작업 타입 감지

요구사항에서 다음 키워드를 찾아 작업 타입을 판단하세요:

### 핫픽스/버그 수정
키워드: "버그", "오류", "에러", "수정", "fix", "bug", "error", "hotfix"
→ **워크플로우**: impl-fix → test-verify

### 단순 기능 추가  
키워드: "기능 추가", "새로운", "추가", "add", "feature", "implement"
→ **워크플로우**: plan-feature → impl-core → test-integration

### 아키텍처/복잡한 변경
키워드: "아키텍처", "설계", "구조 변경", "리팩토링", "architecture", "design", "refactor"
→ **워크플로우**: plan-architecture → doc-design → test-strategy → impl-phases

### 표준/가이드라인 구축
키워드: "가이드", "표준", "컨벤션", "스타일", "guide", "standard", "convention"  
→ **워크플로우**: plan-standards → doc-standards → impl-apply → test-compliance

### 리팩토링
키워드: "최적화", "개선", "리팩토링", "refactor", "optimize", "improve"  
→ **워크플로우**: test-existing → impl-refactor → test-regression

## 지속적 가치 기반 문서 선택

작업 완료 후에도 프로젝트에 장기적 가치를 제공하는 문서만 생성하세요:

### 저장할 문서 (장기적 가치)
**interfaces/** - API 명세, 데이터 스키마 (외부 연동 존재시)
**design/** - 아키텍처 설계, 핵심 구조 (복잡한 시스템)  
**logic/** - 도메인 규칙, 비즈니스 정책 (복잡한 비즈니스 로직)
**standards/** - 개발 표준, 가이드라인 (팀 협업 필요시)

### 저장하지 않을 문서 (일회성 작업)
- 마이그레이션 계획서
- 버그 수정 분석 노트  
- 임시 작업 가이드
- 특정 버전 대응 문서
- 단순 기능 추가 요구사항

### 문서 생성 조건
1. **interfaces/**: 외부 시스템 연동, 공개 API, 데이터 교환 프로토콜
2. **design/**: 아키텍처 변경, 새로운 모듈 설계, 복잡한 구조 변경
3. **logic/**: 복잡한 비즈니스 규칙, 도메인 정책, 계산 알고리즘
4. **standards/**: UI/UX 가이드, 로깅 가이드, 코딩 컨벤션, 보안 표준

## 작업 타입별 스마트 TODO 생성

감지된 작업 타입에 따라 최적화된 TODO를 생성하세요:

### 핫픽스/버그 수정
- [ ] impl-fix-[버그명]: 버그 수정 구현 (HIGH)
- [ ] test-verify-[버그명]: 수정 사항 검증 (HIGH)

### 단순 기능 추가
- [ ] plan-feature-[기능명]: 기능 설계 (HIGH)  
- [ ] impl-core-[기능명]: 핵심 로직 구현 (HIGH)
- [ ] test-integration-[기능명]: 통합 테스트 (MEDIUM)

### 아키텍처/복잡한 변경
- [ ] plan-architecture-[변경명]: 아키텍처 설계 (HIGH)
- [ ] doc-design-[구조명]: 설계 문서 작성 (HIGH) *지속적 가치 있는 경우만
- [ ] test-strategy-[변경명]: 테스트 전략 수립 (HIGH)
- [ ] impl-phases-[단계명]: 단계별 구현 (MEDIUM)

### 표준/가이드라인 구축
- [ ] plan-standards-[표준명]: 표준 설계 (HIGH)
- [ ] doc-standards-[가이드명]: 표준 문서 작성 (HIGH)
- [ ] impl-apply-[표준명]: 표준 적용 (MEDIUM)
- [ ] test-compliance-[표준명]: 준수 검증 (MEDIUM)

### 리팩토링  
- [ ] test-existing-[대상명]: 기존 동작 테스트 확보 (HIGH)
- [ ] impl-refactor-[대상명]: 리팩토링 실행 (MEDIUM)
- [ ] test-regression-[대상명]: 회귀 테스트 (HIGH)

## plan-output.md 형식

```markdown
# [작업명] 실행 계획

## 작업 타입: [감지된 타입]

## 핵심 목표
- [해결하려는 문제나 구현할 기능 요약]

## 장기적 가치 문서 (해당시만)
### [interfaces/design/logic/standards 중 필요한 것만]
- [문서명]: [목적과 범위]
- 경로: docs/[카테고리]/[파일명]

## TODO 목록
[작업 타입에 맞는 스마트 TODO]

### 진행 상태  
- 총 작업: [N]개
- 완료: 0개
- 현재: [첫 번째 TODO] (대기중)

## 작업 기록
[act 명령어가 업데이트]
```

## 검증 기준

계획 수립 완료 시 확인사항:
- [ ] 작업 타입이 올바르게 감지되었는가?
- [ ] 불필요한 일회성 문서 생성이 포함되지 않았는가?
- [ ] TODO가 작업 타입에 최적화되었는가?

"스마트 작업 계획 수립 완료. plan-output.md가 생성/업데이트되었습니다. act 명령으로 최적화된 워크플로우를 시작하세요."라고 응답하세요.