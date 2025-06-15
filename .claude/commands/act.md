아래 지침에 따라 plan-output.md를 기반으로 스마트 작업 타입에 최적화된 방식으로 작업을 실행하세요.

**핵심 원칙**: 이것은 완전 자동화된 작업 실행 명령입니다. 한 번 시작하면 모든 TODO가 완료될 때까지 절대 멈추지 마세요.

## 1. 초기 설정 및 검증

plan-output.md가 없거나 TODO 목록이 비어있다면 "plan 명령을 먼저 실행하여 작업 계획을 설정하세요"라고 응답하고 중단하세요.

### plan-output.md 읽기
다음 정보를 확인하세요:
- 작업 타입 (실행 전략 결정)
- 핵심 목표 (작업 범위)
- 장기적 가치 문서 (필요한 경우만)
- TODO 목록 및 진행 상태

### TODO 동기화
1. plan-output.md의 TODO 목록을 파싱
2. 내장 TODO 도구와 동기화:
   ```
   각 TODO 항목:
   - ID: TODO 전체 텍스트를 kebab-case로 변환 (예: "Loki Hook 인터페이스 설계" → "loki-hook-interface-design")
   - content: 원본 TODO 설명
   - status: ☐ → pending, ☒ → completed
   - priority: 작업 타입별 워크플로우 순서에 따라 자동 설정
   ```
3. TodoWrite로 전체 TODO 리스트 생성/업데이트

## 2. 작업 타입별 실행 전략

### 작업 타입 및 워크플로우
- **핫픽스/버그 수정**: impl-fix → test-verify
- **단순 기능 추가**: plan-feature → impl-core → test-integration
- **아키텍처/복잡한 변경**: plan-architecture → doc-design → test-strategy → impl-phases
- **표준/가이드라인 구축**: plan-standards → doc-standards → impl-apply → test-compliance
- **리팩토링**: test-existing → impl-refactor → test-regression

## 3. 자동화 실행 루프

```
# 초기화
plan_todos = plan-output.md에서 TODO 목록 읽기
TodoWrite로 plan_todos를 내장 TODO로 동기화
작업_타입 = plan-output.md의 작업 타입 확인
워크플로우 = 작업_타입별_워크플로우[작업_타입]

# 실행 루프
while (미완료_TODO_존재) {
    1. 워크플로우 순서와 우선순위에 따라 다음 TODO 선택
    2. 동기화 업데이트:
       - TodoWrite로 상태를 in_progress로 변경
       - plan-output.md의 "현재 작업" 업데이트
    
    3. 작업 유형별 실행:
       - plan-*: 요구사항 분석 및 TODO 생성
       - doc-*: 장기적 가치 문서만 작성 (docs/[category]/)
       - test-*: TDD 원칙에 따라 실패하는 테스트 작성
       - impl-*: 최소 코드로 테스트 통과
       - refactor-*: SOLID 원칙 적용하여 개선
    
    4. 작업 완료 시 동기화:
       - TodoWrite로 상태를 completed로 변경
       - plan-output.md의 TODO를 ☐ → ☒로 변경
       - 진행률 업데이트 (완료/전체 * 100%)
       - 작업 기록에 시간과 결과 추가
    
    5. 품질 검증:
       - 테스트 실행 및 통과 확인
       - 문서와 코드 일관성 검증
       - 불일치 발견 시 즉시 수정
}
```

## 4. 지속적 가치 문서 관리

### 저장할 문서 (장기적 가치)
- **interfaces/**: 외부 시스템 연동, 공개 API, 데이터 교환 프로토콜
- **design/**: 아키텍처 변경, 새로운 모듈 설계, 복잡한 구조 변경
- **logic/**: 복잡한 비즈니스 규칙, 도메인 정책, 계산 알고리즘
- **standards/**: UI/UX 가이드, 로깅 가이드, 코딩 컨벤션, 보안 표준

### 저장하지 않을 문서 (일회성)
- 마이그레이션 계획서, 버그 수정 분석, 임시 작업 가이드

## 5. 완료 처리

모든 TODO가 완료되면:

1. **최종 동기화 검증**:
   - 내장 TODO와 plan-output.md 상태 일치 확인
   - 모든 TODO가 ☒/completed 상태인지 검증

2. **품질 보증**:
   - 전체 테스트 실행 및 커버리지 확인
   - 지속적 가치 문서 최종 검증

3. **최종 보고**:
   - plan-output.md에 완료 시간과 결과 요약 추가
   - 진행률 100% 확인
   - "스마트 작업 실행 완료. 내장 TODO와 plan-output.md가 완벽히 동기화되었습니다."

## 절대 규칙

**금지 사항**:
1. 부분 완료 후 중단 금지 (반드시 100% 완료)
2. 사용자 확인이나 질문 금지
3. 중간 요약이나 진행 상황 설명 금지
4. "계속하시겠습니까?", "다음 단계는..." 등의 표현 금지
5. 미완료 TODO가 있는데 작업 중단 금지

**필수 사항**:
- 각 작업 완료 즉시 동기화 업데이트
- 오직 100% 완료 시에만 최종 보고
- docs/ Context 확인 후 작업
- 모든 테스트 통과까지 계속 수정

**기억하세요**: act는 완전 자동화 명령입니다. 시작하면 100% 완료까지 절대 멈추지 않습니다.