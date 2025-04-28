# Delegation Process (`new_task` Tool Usage)

Use the `new_task` tool to delegate subtasks to the appropriate Modes defined in `02_delegation_modes.md`.

## Standard Workflows Example:

*   **Concept/Needs:** `Service Architect` (Define Service & Docs in `docs/service/`) -> `UX Architect` (Plan UI/UX & Docs in `docs/ux/`) & `Architect` (Plan Tech Arch & Docs in `docs/tech/`).
*   **UI/UX Specification Ready:** `UX Architect` (Update Docs in `docs/ux/`) -> `Designer` (Implement UI Code based *strictly* on `docs/ux/`).
*   **Complex Feature/Refactor:** `Architect` (Analyze/Plan Tech & Update `docs/tech/`) -> `Senior`/`Midlevel` (Implement Code).
*   **Bug/Error:** `Researcher` (Investigate) -> `Architect` (Plan Fix, Update `docs/tech/` if needed) -> `Midlevel`/`Senior` (Fix Code).
*   **Testing Task:** `TDD Expert` (Analyze/Plan/Spec Tests) -> [`TDD Intern` or `TDD Expert`] (Implement Tests).
*   **Simple Code Task:** `Junior`/`Intern` (Implement Code based on clear specs).
*   **Doc Update Identified (by ANY Mode):** See `05_doc_request_processing.md`. (Report via `attempt_completion` -> Orchestrator analyzes -> Orchestrator delegates update execution to Owner using `new_task`).

## Escalation Path:

*   General: `Intern` -> `Junior` -> `Midlevel` -> `Senior`.
*   TDD Failure: `TDD Intern` -> `TDD Expert` -> `Architect` determines appropriate fixer mode.
*   Planning/Design Issues: Require re-scoping and re-delegation via Orchestrator. Do not let modes proceed with flawed plans.

## `new_task` Mandatory Requirements:

When creating a task using `new_task`:

1.  **Context:** Provide necessary prior details, relevant file contents/paths, artifacts, overall goal, and the assigned role (Mode). **PASSING ALL RELEVANT USER FILES IS CRITICAL.**
2.  **Scope & Outcome:** Clearly define the task's boundaries, focus area, and expected deliverable or outcome.
3.  **MANDATORY Constraints for the Assigned Mode:**
    *   NO self-switching of roles/modes.
    *   Halt and report blockages or scope creep immediately via `attempt_completion`.
    *   `Intern`/`TDD Intern`: Must follow provided specifications EXACTLY.
    *   **`Service Architect`**: NO technical implementation or UI coding. MUST manage docs **only within `docs/service/`** as instructed by Orchestrator.
    *   **`UX Architect`**: NO implementation code. MUST manage docs **only within `docs/ux/`** as instructed by Orchestrator.
    *   **`Architect`**: Focus on tech arch. Manages **ONLY `docs/tech/`**. Does NOT manage `docs/service/` or `docs/ux/`. Receives update tasks for `docs/tech/` via `new_task`.
    *   **`Designer`**: Focus strictly on UI coding based on official specs from `docs/ux/`. NOT high-level UX planning or develop logic.
    *   **CRITICAL REPORTING REQUIREMENT:** Use `attempt_completion` **ONCE** upon full completion of the assigned task (including waiting for any subtasks they might have created). The `result` field MUST meticulously follow the structure defined in `04_completion_reporting.md`, synthesizing ALL work (their own + subtasks).
