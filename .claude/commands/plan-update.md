'{{ARGUMENTS}}' 지금까지 논의된 내용을 바탕으로 추가 계획을 세웁니다. `plan-output.md`를 업데이트하세요. ultrathink.
- use thinkdeep with `o3`. 분석, 설계 등에 `sub-tasks`를 적극적으로 활용하여 정확한 분석 및 구체적인 계획을 세우도록 합니다.
- 외부 정보, 자료 등이 필요한 경우 `firecrawl`, `perplexity`, `context7` 등 적합한 MCP를 적극적으로 활용하여 정보의 품질을 높입니다.
- 모든 분석 및 논의가 끝나면 `Plan mode`로 진입합니다.
- 이제 아래 지침에 따라 계획을 수립하고 자동으로 실행하세요.

# plan-update 명령어

## 목적
`plan-update`는 기존 `plan-output.md`에 기록된 계획을 **수정‧보강**하거나, **완료 후 미흡한 부분을 개선**하기 위해 사용합니다.  
새로운 계획을 처음부터 작성하지 않고, 기존 문서를 기반으로 **추가 업데이트** 하는 것이 핵심입니다.

## 실행 절차
1. **현황 파악**
   - `plan-output.md`를 **Read** 하여 최신 상태를 확인합니다.
   - 변경‧추가가 필요한 영역을 식별합니다.
2. **업데이트 계획 작성**
   - 수정 또는 추가할 Task 를 구체적으로 정의합니다.
   - 영향 범위가 있을 경우 간단히 기술합니다.
3. **Todo 등록**
   - 모든 변경 Task 를 `TodoWrite` 로 등록합니다.
   - 각 Task 뒤에 **'plan-output.md 업데이트'** Task 를 반드시 추가합니다.
4. **자동 실행**
   - 각 Task 를 **in_progress → completed** 로 상태 변경하며 처리합니다.
   - 핵심 Task 가 완료될 때마다 `plan-output.md`를 **Read → Write** 순서로 업데이트합니다.
5. **문서 동기화**
   - 업데이트된 `plan-output.md` 가 새 팀원이 보기에 충분한지 확인합니다.
   - 불필요한 정보(임시 작업, 코드로 충분히 설명되는 내용)는 포함하지 않습니다.

## 작성 원칙
- **간결성**: 변경 사항만 기록하고 중복 설명은 피합니다.
- **연속성**: 기존 계획의 맥락을 해치지 않도록 주석이나 섹션을 재사용합니다.
- **추적 가능성**: 변경 이유와 결과를 짧게 남깁니다.
- **UTF-8** 인코딩 및 프로젝트 루트 위치 유지.

## 예시 Workflow
```
TodoWrite:
  - [plan-update] API 응답 필드 누락 보완 (plan-output.md 업데이트)
  - [plan-update] plan-output.md 업데이트

자동 실행:
  1. Task 상태 in_progress
  2. 구현/문서 변경
  3. Task 상태 completed
  4. plan-output.md Read → Write
```

---

> 핵심은 **기존 계획의 지속적인 개선**입니다.