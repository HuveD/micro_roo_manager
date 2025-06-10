# 작업 실행 규칙 (TDD)

ultrathink. 문서 기반으로 TDD 방식으로 작업을 실행하세요.

## 🚨 필수 실행 순서

### STEP 0: 문서 확인
```
MUST DO FIRST:
1. TodoRead 실행 → 현재 TODO 확인
2. plan-output.md 읽기 → 도메인 모델, 테스트 계획 확인
3. IF (TODO가 비어있음):
   → 오류: "plan 명령을 먼저 실행하세요"
```

### STEP 1: TDD 사이클 실행
```
WHILE (pending 상태 TODO 존재):
    1. 테스트 작업 선택 (test-* 우선)
    2. TodoWrite → status를 "in_progress"로 변경
    
    === RED PHASE ===
    3. IF (작업이 test-*):
       - 실패하는 테스트 작성
       - Bash로 테스트 실행 → 실패 확인
       - TodoWrite → "completed"
    
    === GREEN PHASE ===
    4. IF (작업이 impl-*):
       - 최소한의 코드로 테스트 통과
       - Bash로 테스트 실행 → 성공 확인
       - TodoWrite → "completed"
    
    === REFACTOR PHASE ===
    5. IF (작업이 refactor-*):
       - 코드 개선 (테스트는 계속 통과)
       - Bash로 테스트 재실행 → 성공 확인
       - TodoWrite → "completed"
    
    6. 문서 실시간 업데이트:
       - API 변경 시 → 문서 즉시 수정
       - 새로운 발견 → 문서에 반영
```

### STEP 2: 문서-코드 동기화
```
AFTER EACH TASK:
1. 구현된 내용과 문서 비교
2. IF (불일치 발견):
   - Edit으로 문서 업데이트
   - TodoWrite → 동기화 작업 추가
3. 테스트 결과 문서화:
   - 테스트 커버리지
   - 성능 메트릭
   - 발견된 이슈
```

### STEP 3: 검증 및 완료
```
ALL TASKS COMPLETED:
1. 전체 테스트 실행:
   - Bash: npm test 또는 pytest
   - 모든 테스트 통과 확인
2. 문서 최종 검증:
   - README.md 최신화
   - API 문서 완성도
   - 아키텍처 다이어그램
3. 완료 보고서 작성
```

## 🔴 TDD 실행 규칙

### 테스트 작성 원칙:
```
1. 한 번에 하나의 테스트만
2. 가장 간단한 케이스부터
3. 실패를 먼저 확인
4. 중복 제거는 나중에
```

### 구현 원칙:
```
1. 테스트를 통과하는 최소 코드
2. 하드코딩도 괜찮음 (처음엔)
3. 점진적 일반화
4. 리팩토링은 별도 단계
```

## 📋 문서 업데이트 타이밍

### 즉시 업데이트:
- API 시그니처 변경
- 도메인 모델 수정
- 새로운 제약사항 발견
- 에러 처리 방식 변경

### 작업 완료 후 업데이트:
- 성능 최적화 결과
- 구현 세부사항
- 배운 교훈

## ⚡ 도구 사용 규칙

### 테스트 실행:
```
IF (JavaScript/TypeScript):
    → Bash: npm test
    → Bash: npm run test:watch
ELSE IF (Python):
    → Bash: pytest
    → Bash: pytest -v
ELSE IF (Go):
    → Bash: go test ./...
```

### 코드 품질 검사:
```
AFTER impl-* 완료:
    → Bash: 린터 실행 (eslint, pylint 등)
    → Bash: 타입 체크 (tsc, mypy 등)
    → 문제 발견 시 즉시 수정
```

## 🛑 금지 사항

**절대 하지 말 것:**
- 테스트 없이 구현
- 실패 확인 없이 성공 코드 작성
- 문서 업데이트 없이 API 변경
- 전체 테스트 없이 완료 선언

## 💡 TDD 실행 예시

### 좋은 실행 순서:
```
1. test-user-validation 작성 → 실행 → 실패 확인
2. impl-user-validation 구현 → 실행 → 성공 확인
3. test-user-creation 작성 → 실행 → 실패 확인
4. impl-user-creation 구현 → 실행 → 성공 확인
5. refactor-user-validation 개선 → 테스트 여전히 통과
```

### 문서 업데이트 예시:
```markdown
## API 문서 (실시간 업데이트)

### POST /users
- 입력: {name: string, email: string} ← 구현 중 발견
- 출력: {id: string, ...} ← 테스트에서 정의
- 에러: 400 (validation), 409 (duplicate) ← 테스트 케이스 추가
```

---

**핵심: 테스트가 구현을 주도하고, 문서가 항상 최신 상태를 유지합니다.**