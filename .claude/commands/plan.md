# 계획 수립 실행 규칙 (DDD)

```text
$ARGUMENTS
```

ultrathink: 위 요구사항에 대해 문서 주도 개발(DDD) 원칙으로 계획을 수립하세요.

## 🚨 필수 실행 순서

### STEP 1: 초기화 및 도메인 분석
```
MUST DO IN ORDER:
1. TodoRead 실행 → 현재 TODO 확인
2. 도메인 분석:
   - 핵심 도메인 식별
   - 도메인 모델 정의
   - 유비쿼터스 언어 설정
   - 경계 컨텍스트 구분
3. TodoWrite 실행 → 계획 수립 작업 생성
   {
     id: "plan-domain-analysis",
     content: "도메인 분석 및 문서 작성",
     status: "in_progress",
     priority: "high"
   }
```

### STEP 2: 문서 작성 및 테스트 계획
```
MUST CREATE DOCUMENTS:
1. 도메인 모델 문서:
   - 엔티티, 값 객체 정의
   - 도메인 규칙 명시
   - 인터페이스 계약 정의
2. 테스트 시나리오 문서:
   - 각 기능별 테스트 케이스
   - 엣지 케이스 정의
   - 예상 결과 명시
3. API/인터페이스 문서:
   - 입력/출력 명세
   - 에러 처리 방식
   - 사용 예시
```

### STEP 3: 작업 분해 및 TODO 생성
```
MUST FOLLOW TDD WORKFLOW:
1. 각 기능을 테스트-구현 쌍으로 분해:
   - 테스트 작성 작업 (우선순위: HIGH)
   - 구현 작업 (우선순위: MEDIUM)
   - 리팩토링 작업 (우선순위: LOW)
2. TodoWrite 실행 → TDD 순서로 작업 생성:
   [
     {id: "test-[기능]", content: "[기능] 테스트 작성", priority: "high"},
     {id: "impl-[기능]", content: "[기능] 구현", priority: "medium"},
     {id: "refactor-[기능]", content: "[기능] 리팩토링", priority: "low"}
   ]
```

### STEP 4: 프로젝트 계획서 작성
```
MUST CREATE plan-output.md WITH:

# [프로젝트명] 실행 계획

## 도메인 모델
### 핵심 개념
- [도메인 용어]: [설명]

### 엔티티
- [엔티티명]: [책임과 속성]

## 테스트 계획
### 단위 테스트
1. [테스트명]: [검증 내용]

### 통합 테스트
1. [시나리오]: [예상 결과]

## 구현 계획
### 작업 순서 (TDD)
1. [테스트] → [구현] → [검증]

### 기술 결정
- [선택 사항]: [이유]

## 문서화 계획
- README.md: [포함 내용]
- API 문서: [문서화 방식]
- 아키텍처 문서: [다이어그램 유형]
```

### STEP 5: 검증 및 완료
```
CHECKLIST:
□ 모든 요구사항이 문서화되었는가?
□ 각 기능에 테스트 계획이 있는가?
□ 도메인 모델이 명확한가?
□ TODO가 TDD 순서로 생성되었는가?

TodoWrite → 계획 작업 "completed"
메시지: "DDD 계획 수립 완료. 문서를 기반으로 TDD 방식으로 구현을 시작하세요."
```

## 📋 TODO 생성 규칙 (TDD)

### 작업 ID 체계:
```
테스트: test-[도메인]-[기능]
구현: impl-[도메인]-[기능]
문서: docs-[도메인]-[주제]
리팩토링: refactor-[도메인]-[대상]
```

### TDD 사이클 TODO:
```javascript
// 1. RED - 실패하는 테스트
{id: "test-user-login", content: "사용자 로그인 테스트 작성", priority: "high"}

// 2. GREEN - 테스트 통과
{id: "impl-user-login", content: "사용자 로그인 구현", priority: "medium"}

// 3. REFACTOR - 개선
{id: "refactor-user-login", content: "로그인 코드 리팩토링", priority: "low"}
```

## 🔴 문서 우선 원칙

**문서 작성 순서:**
1. 도메인 모델 정의
2. 인터페이스 명세
3. 테스트 시나리오
4. 구현 세부사항

**문서 업데이트 시점:**
- 요구사항 변경 시 즉시
- 구현 중 발견사항 반영
- 테스트 결과 반영

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

**핵심: 문서가 코드를 주도하고, 테스트가 구현을 주도합니다.**