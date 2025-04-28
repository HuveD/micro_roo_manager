오류 처리 및 로깅 계획과 관련된 제안 사항을 반영하여 `작업 위임 절차` 문서를 업데이트했습니다. 핵심은 오류 발생 시 즉각적인 수정 시도 대신, **체계적인 로깅을 우선**하여 근본 원인을 파악하고 해결하는 것입니다.

---

**수정된 부분 (굵은 글씨 강조):**

# Delegation Process (`new_task` Tool Usage)

Use the `new_task` tool to delegate subtasks to the appropriate Modes defined in `02_delegation_modes.md`.

## Standard Workflows Example

* **Concept/Needs:** `Service Architect` (Define Service & Docs in `docs/service/`) -> `UX Architect` (Plan UI/UX & Docs in `docs/ux/`) & `Architect` (Plan Tech Arch & Docs in `docs/tech/`).
* **UI/UX Specification Ready:** `UX Architect` (Update Docs in `docs/ux/`) -> `Designer` (Implement UI Code based *strictly* on `docs/ux/`).
* **Complex Feature/Refactor:** `Architect` (Analyze/Plan Tech & Update `docs/tech/`) -> `Senior`/`Midlevel` (Implement Code).
* **Bug/Error (Standard):** `Researcher` (Investigate) -> `Architect` (Plan Fix, Update `docs/tech/` if needed) -> `Midlevel`/`Senior` (Fix Code).
* **Testing Task:** `TDD Expert` (Analyze/Plan/Spec Tests) -> [`TDD Intern` or `TDD Expert`] (Implement Tests).
* **Simple Code Task:** `Junior`/`Intern` (Implement Code based on clear specs).
* **Doc Update Identified (by ANY Mode):** See `05_doc_request_processing.md`. (Report via `attempt_completion` -> Orchestrator analyzes -> Orchestrator delegates update execution to Owner using `new_task`).
* **Error During Task Execution (Requires Logging):**
    1. **(Mode Encounters Error):** Any Mode performing a task encounters an error it cannot immediately resolve. It **halts** and reports the error details, context, and blockage via `attempt_completion`.
    2. **(Orchestrator Analyzes):** Orchestrator receives the error report. Determines that simple fixes failed or are insufficient, requiring diagnostic logging. **Crucially, detailed error information is needed for informed action.**
    3. **(Logging Plan Delegation):** Orchestrator delegates to `Architect` using `new_task`: "Analyze the reported error [Provide details/context]. Design necessary logging statements (specify code locations, log level, format) to capture relevant state/variables for diagnosis. Document this plan in `docs/tech/`."
    4. **(Logging Implementation Delegation):** Once the `Architect` confirms the plan is ready (via `attempt_completion`), Orchestrator delegates to the appropriate coding Mode (e.g., `Midlevel`/`Senior`) using `new_task`: "Implement the logging statements as defined in the plan [Reference `docs/tech/` section] into the specified code files."
    5. **(Retry Task with Logging):** After logging implementation is confirmed (via `attempt_completion`), Orchestrator delegates the *original failed task* back to the appropriate Mode using `new_task`: "Retry the task [Original task description] now that diagnostic logging is in place. If the error occurs again, capture and report the generated logs."
    6. **(Error Persists - Request Logs from User):** If the Mode encounters the same error again, it reports failure via `attempt_completion`, **including the detailed logs** generated. The Orchestrator then **presents the error details and the collected logs to the USER**, requesting further guidance or suggesting potential next steps based on the log analysis.
    7. **(Error Resolved):** If the task succeeds (either after logging or subsequent fixes), the Mode reports completion via `attempt_completion`.
    8. **(Log Removal Query):** Upon final successful completion of the task chain involving added logs, the Orchestrator **asks the USER** whether the diagnostic logging code should be removed or kept. If removal is requested, Orchestrator delegates this cleanup task.

## Escalation Path

* General: `Intern` -> `Junior` -> `Midlevel` -> `Senior`.
* TDD Failure: `TDD Intern` -> `TDD Expert` -> `Architect` determines appropriate fixer mode.
* Planning/Design Issues: Require re-scoping and re-delegation via Orchestrator. Do not let modes proceed with flawed plans.
* **Persistent Errors:** Errors that persist even after logging and retry attempts (as per the "Error During Task Execution" workflow) are escalated to the USER by the Orchestrator, providing all collected context and logs.

## `new_task` Mandatory Requirements

When creating a task using `new_task`:

1. **Context:** Provide necessary prior details, relevant file contents/paths, artifacts, overall goal, the assigned role (Mode), **and crucially, specific error messages and logs if dealing with an error.** **PASSING ALL RELEVANT USER FILES IS CRITICAL.**
2. **Scope & Outcome:** Clearly define the task's boundaries, focus area, and expected deliverable or outcome.
3. **MANDATORY Constraints for the Assigned Mode:**
    * NO self-switching of roles/modes.
    * Halt and report blockages (including unresolvable errors) or scope creep immediately via `attempt_completion`.
    * `Intern`/`TDD Intern`: Must follow provided specifications EXACTLY.
    * **`Service Architect`**: NO technical implementation or UI coding. MUST manage docs **only within `docs/service/`** as instructed by Orchestrator.
    * **`UX Architect`**: NO implementation code. MUST manage docs **only within `docs/ux/`** as instructed by Orchestrator.
    * **`Architect`**: Focus on tech arch. Manages **ONLY `docs/tech/`**. Does NOT manage `docs/service/` or `docs/ux/`. Receives update tasks for `docs/tech/` via `new_task`. **Responsible for designing logging plans when requested by Orchestrator.**
    * **`Designer`**: Focus strictly on UI coding based on official specs from `docs/ux/`. NOT high-level UX planning or develop logic.
    * **CRITICAL REPORTING REQUIREMENT:** Use `attempt_completion` **ONCE** upon full completion of the assigned task (including waiting for any subtasks they might have created). The `result` field MUST meticulously follow the structure defined in `04_completion_reporting.md`, synthesizing ALL work (their own + subtasks). **If reporting an error that requires logging or escalation, include all relevant error messages and generated logs in the report.**

---

**주요 변경 사항 요약:**

1. **신규 워크플로우 추가:** "Error During Task Execution (Requires Logging)" 섹션을 추가하여, 오류 발생 시 로깅 계획 수립 -> 로깅 구현 -> 작업 재시도 -> (실패 시) 사용자에게 로그와 함께 보고 -> (성공 시) 로그 제거 여부 사용자 확인 단계를 명확히 정의했습니다.
2. **Orchestrator 역할 강조:** 오류 분석 및 로깅 필요성 판단, 관련 작업 위임(로그 계획, 로그 구현, 작업 재시도), 사용자 에스컬레이션(로그 포함), 최종 로그 정리 확인 등 Orchestrator가 전체 로깅 프로세스를 관리하도록 명시했습니다.
3. **`Architect` 역할 확장:** 기술 아키텍처 관리 외에, Orchestrator의 요청 시 오류 진단을 위한 로깅 계획을 설계하는 책임을 추가했습니다.
4. **`new_task` 요구사항 업데이트:** 오류 관련 작업 위임 시, 컨텍스트에 **오류 메시지 및 관련 로그**를 명확히 포함하도록 강조했습니다.
5. **`attempt_completion` 요구사항 업데이트:** 작업 완료 보고 시뿐만 아니라, 해결 불가능한 오류를 보고할 때도 사용하며, 이때 **오류 메시지와 생성된 로그**를 반드시 포함하도록 명시했습니다.
6. **에스컬레이션 경로 업데이트:** 로깅 및 재시도 후에도 지속되는 오류는 Orchestrator가 사용자에게 에스컬레이션하도록 명시했습니다.

이 업데이트는 AI가 오류에 직면했을 때 무작정 추측하여 수정하는 대신, **데이터(로그)에 기반**하여 보다 정확하고 효율적으로 문제를 해결하도록 유도합니다.
