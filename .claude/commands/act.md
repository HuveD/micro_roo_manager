ultrathink: plan-output.md를 기반으로 Universal Document-Driven TDD 방식으로 작업을 실행하세요.

**중요**: 모든 TODO가 완료될 때까지 중단 없이 자동으로 진행하세요. 작업 중간에 사용자에게 확인을 요청하거나 질문하지 마세요. 계획된 작업은 자동으로 연속 실행됩니다.

먼저 plan-output.md를 읽어서 다음을 확인하세요:
- 요구사항 명세 (필수 Context)
- 설계 문서 (구조 Context)
- 인터페이스 명세 (통신 Context)
- 비즈니스 로직 (도메인 Context)
- 테스트 전략 (품질 Context)
- 구현 가이드 (기술 Context)
- TODO 목록 및 진행 상태 (작업 Context)

docs/ 폴더 구조의 링크들이 유효한지 확인하세요: requirements, design, interfaces, logic, testing, implementation.

plan-output.md가 없거나 TODO 목록이 비어있다면 "plan 명령을 먼저 실행하여 Context를 설정하세요"라고 응답하고 중단하세요.

**자동 진행 원칙**:
- 모든 미완료 TODO를 순차적으로 자동 실행
- 작업 중간에 "계속하시겠습니까?", "진행하시겠습니까?" 등의 확인 금지

**자동 실행 플로우**: 미완료 TODO가 있는 동안 → 작업 선택 → 실행 → 업데이트 → 다음 작업 (반복)

plan-output.md에 미완료 TODO가 있는 동안 다음을 반복하세요:

**작업 선택**: plan-* → doc-* → test-* → impl-* → refactor-* 순서로 다음 미완료 TODO를 선택하세요.

**진행 상태 업데이트**: plan-output.md를 Edit로 수정하여:
- 선택된 TODO를 "진행중" 상태로 표시
- "현재 작업" 항목을 선택된 TODO로 업데이트
- 작업 시작 시간을 "작업 기록" 섹션에 추가

**관련 문서 읽기**: docs/[해당카테고리]/[관련문서].md를 읽어서 요구사항과 제약사항을 확인하세요.

**작업 유형별 실행**:

**계획 작업 (plan-*)인 경우**:
요구사항을 상세 분석하고 기능 분해를 수행하세요. 하위 작업을 식별하고 우선순위를 결정하세요. 필요한 경우 plan-output.md에 추가 TODO를 생성하세요.

**문서 작업 (doc-*)인 경우**:
plan-output.md의 링크를 참조해서 해당 카테고리의 상세 문서를 작성하세요. 요구사항, 설계, 인터페이스, 비즈니스 로직을 문서화하세요. docs/[category]/[document].md 파일을 작성하세요. 

**작업 완료 시 plan-output.md 실시간 업데이트**:
- 해당 TODO를 ✅ 체크 완료로 표시
- "완료된 작업" 수 증가
- "진행률" 계산하여 업데이트 (완료된 작업/총 작업 수 * 100%)
- "현재 작업"을 다음 미완료 TODO로 업데이트
- "작업 기록"에 완료 시간과 결과 추가
- 업데이트 완료 후 즉시 다음 TODO로 진행 (확인 요청 없이)

**테스트 작업 (test-*)인 경우**:
docs/testing/에서 테스트 전략을 확인하세요. docs/logic/에서 비즈니스 규칙을 확인하세요. Given-When-Then 패턴으로 실패하는 테스트를 작성하세요. Bash로 테스트를 실행해서 실패를 확인하세요. 테스트 결과를 간단히 보고하고 즉시 다음 작업으로 진행하세요.

**작업 완료 시 plan-output.md 실시간 업데이트** (위와 동일)

**구현 작업 (impl-*)인 경우**:
docs/design/에서 설계 제약사항을 확인하세요. docs/interfaces/에서 인터페이스 계약을 확인하세요. 설계 원칙을 준수하면서 최소한의 코드로 테스트를 통과시키세요. Bash로 테스트를 실행해서 성공을 확인하세요. 구현 완료 후 즉시 다음 작업으로 진행하세요.

**작업 완료 시 plan-output.md 실시간 업데이트** (위와 동일)

**리팩토링 작업 (refactor-*)인 경우**:
SOLID 원칙을 적용해서 코드를 개선하세요. 테스트가 계속 통과하도록 유지하세요. Bash로 테스트를 재실행해서 성공을 확인하세요.

**작업 완료 시 plan-output.md 실시간 업데이트** (위와 동일)

**문서 동기화**: 인터페이스나 비즈니스 로직, 설계가 변경될 때마다 즉시 해당 docs/ 문서를 업데이트하세요.

**각 작업 후 일관성 검증**:
- docs/requirements/ ↔ 구현된 기능 검증
- docs/design/ ↔ 코드 구조 검증
- docs/logic/ ↔ 비즈니스 로직 검증
- docs/interfaces/ ↔ 인터페이스 검증
- docs/testing/ ↔ 테스트 결과 검증

불일치를 발견하면:
1. 즉시 해당 docs/[category]/[file].md를 업데이트
2. plan-output.md의 링크 정보를 실시간 업데이트  
3. 필요시 동기화 TODO를 plan-output.md에 추가
4. "작업 기록"에 동기화 작업 내용을 기록

품질 메트릭을 docs/testing/에 테스트 커버리지로, docs/implementation/에 성능 메트릭으로, docs/design/에 설계 결정 사유로 기록하세요.

**모든 TODO가 완료되면**:

전체 테스트를 실행하세요. 모든 테스트가 통과하고 테스트 커버리지를 확인하세요.

각 Context 문서를 최종 검증하세요:
- docs/requirements/: 모든 요구사항 구현 확인
- docs/design/: 설계 원칙 준수 확인
- docs/logic/: 비즈니스 규칙 반영 확인
- docs/interfaces/: 인터페이스 계약 이행 확인
- docs/testing/: 테스트 전략 완료 확인
- docs/implementation/: 구현 가이드라인 준수 확인

plan-output.md를 최종 업데이트하세요:
- 모든 TODO가 ✅ 완료 상태인지 확인
- 진행률이 100%인지 확인
- "현재 작업"을 "모든 작업 완료"로 표시
- "다음 작업"을 "없음"으로 표시
- 완료 보고서를 "작업 기록" 섹션에 추가
- 전체 소요 시간과 결과 요약 추가

"Universal Document-Driven TDD 완료. 모든 Context가 코드와 동기화되었습니다. plan-output.md가 최종 상태로 업데이트되었습니다."라고 응답하세요.

**중요**: 각 작업 완료 시마다 반드시 plan-output.md를 즉시 업데이트하여 진행 상황을 실시간으로 추적하세요.

**주의사항**:
- "계속하시겠습니까?", "진행하시겠습니까?" 등의 확인 금지
- 테스트 결과나 구현 상태를 보고만 하고 자동으로 다음 진행
- 모든 TODO가 완료될 때까지 중단 없이 자동 실행
- docs/ Context 확인 없이 구현을 시작하지 마세요
- plan-output.md 링크 문서를 무시하지 마세요
- 각 작업 완료 시마다 plan-output.md를 반드시 즉시 업데이트하세요
- 진행 상태가 실시간으로 반영되지 않으면 안 됩니다
- 테스트 없이 구현하지 마세요 (docs/testing/ 전략 위반)
- docs/interfaces/ 계약을 위반하는 인터페이스 변경을 하지 마세요
- docs/design/ 설계 원칙을 위반하지 마세요
- docs/logic/ 비즈니스 규칙을 무시하지 마세요
- 문서 업데이트 없이 Context를 변경하지 마세요
- 전체 테스트 없이 완료를 선언하지 마세요