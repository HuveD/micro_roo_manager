ultrathink: $ARGUMENTS
위 요구사항을 분석하여 Document-Driven + Domain-Driven Development 원칙으로 작업 계획을 수립하세요.

먼저 plan-output.md가 존재하는지 확인하세요:

**기존 plan-output.md가 있고 미완료 TODO가 있는 경우**:
- "기존 plan-output.md의 TODO를 먼저 act 명령으로 완료하세요"라고 응답하고 중단

**기존 plan-output.md가 있고 모든 TODO가 완료된 경우**:
- 기존 내용을 읽어서 새로운 요구사항과 비교
- 추가/변경된 요구사항에 대한 새로운 TODO만 추가
- 기존 완료된 작업은 유지

**plan-output.md가 없는 경우**:
- 새로 생성

요구사항을 분석하세요:
- 핵심 기능과 비즈니스 도메인 파악
- 필요한 문서 카테고리 식별 (product, architecture, domain, api, testing, implementation 중 필요한 것만)
- 기술적 제약사항과 아키텍처 고려사항 확인

다음 순서로 계획을 수립하세요:

요구사항에 필요한 문서만 식별하여 TODO 목록을 생성하세요:

**필요 시에만 추가**:
- docs/product/: 프로덕트 사양이 명확하지 않은 경우
- docs/architecture/: 시스템 설계나 기술 스택 결정이 필요한 경우  
- docs/domain/: 비즈니스 로직이나 도메인 모델이 복잡한 경우
- docs/api/: 외부 인터페이스나 API 설계가 필요한 경우
- docs/testing/: 테스트 전략이나 복잡한 시나리오가 있는 경우
- docs/implementation/: 기술적 결정사항이나 특별한 구현 가이드가 필요한 경우

요구사항에서 식별된 각 기능을 Document-Driven TDD 순서로 분해하세요:
- docs-[도메인]-[주제]: 필요한 문서 작성 (HIGH)
- test-[도메인]-[기능]: 테스트 작성 (HIGH)  
- impl-[도메인]-[기능]: 구현 (MEDIUM)
- refactor-[도메인]-[대상]: 리팩토링 (LOW)

plan-output.md를 다음 형식으로 작성하거나 업데이트하세요:

```markdown
# [프로젝트명] 실행 계획

## 요구사항 분석
### 핵심 기능
- [기능1]: [기능 설명]
- [기능2]: [기능 설명]

### 비즈니스 도메인
- [도메인1]: [설명]
- [도메인2]: [설명]

## 필요 문서 (요구사항 기반)
[필요한 카테고리만 포함]

### 프로덕트 사양 (필요시)
- [요구사항]: [상세 설명]
- 링크: docs/product/[필요한 파일들]

### 아키텍처 설계 (필요시)
- [설계 고려사항]: [설명]
- 링크: docs/architecture/[필요한 파일들]

### 도메인 모델 (필요시)
- [도메인 개념]: [설명]
- 링크: docs/domain/[필요한 파일들]

### API 설계 (필요시)
- [인터페이스]: [설명]
- 링크: docs/api/[필요한 파일들]

### 테스트 전략 (필요시)
- [테스트 접근법]: [설명]
- 링크: docs/testing/[필요한 파일들]

### 구현 가이드 (필요시)
- [기술 결정]: [설명]
- 링크: docs/implementation/[필요한 파일들]

## TODO 목록
### 문서화 작업
[요구사항에 필요한 문서만]
- [ ] docs-[도메인]-[주제]: [문서 작성 내용] (HIGH)

### 개발 작업 (Document-Driven TDD)
[요구사항에서 식별된 기능들]
- [ ] test-[도메인]-[기능]: [기능] 테스트 작성 (HIGH)
- [ ] impl-[도메인]-[기능]: [기능] 구현 (MEDIUM)
- [ ] refactor-[도메인]-[기능]: [기능] 리팩토링 (LOW)

### 진행 상태
- 총 작업 수: [N]개
- 완료된 작업: 0개
- 진행률: 0%
- 현재 작업: [첫 번째 TODO] (대기중)
- 다음 작업: [두 번째 TODO]

## 작업 기록
[act 명령어가 업데이트]
```

요구사항 분석이 완료되고, 필요한 문서 계획이 수립되었으며, 각 기능의 작업 계획이 명확하고, TODO가 Document-Driven TDD 순서로 생성되었는지 확인하세요.

plan-output.md가 요구사항을 완전히 반영하고 실행 가능한 TODO 목록을 포함하는지 검증하세요.

"Document-Driven + Domain-Driven Development 계획 수립 완료. plan-output.md가 생성/업데이트되었습니다. act 명령으로 Document-Driven TDD를 시작하세요."라고 응답하세요.