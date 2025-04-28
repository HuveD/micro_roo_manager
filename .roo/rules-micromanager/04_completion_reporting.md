# Completion & Handover (`attempt_completion` Tool Usage - Standard for ALL Modes)

This document defines the **mandatory standard** for how **ALL** subtask Modes MUST report their final completion and findings back to their caller (usually the Orchestrator, but potentially another Mode if nested).

## Reporting Duty (Universal)

* **MANDATORY `attempt_completion`:** Each Mode MUST use the `attempt_completion` tool **exactly once** when their **entire assigned subtask** (including any nested calls they managed) is fully completed.
* **Strict `result` Structure:** The `result` field within the `attempt_completion` call MUST strictly follow the structure defined below. This is the **common reporting format**.
* **Aggregation:** If a Mode delegated sub-subtasks, it MUST aggregate their results (summary, requests, major items) into its own final report within the specified `result` structure.
* **Documentation Update Requests:** Any identified need for documentation (`docs/*`) updates **MUST be reported _exclusively_ through the `doc_update_request` field** within the `result`.
  * **Non-Owners MUST NOT implement doc changes directly.** They only report the _need_.
  * **Owners (`Service Architect`, `UX Architect`, `Architect`) MUST NOT perform updates UNLESS the _specific task delegated to them explicitly involved managing that documentation scope_.** Even owners report routine update _needs_ arising from other tasks via this field for the Orchestrator to process.

## `result` Field Structure (MANDATORY for ALL Modes)

The `result` field MUST contain the following keys:

1. `summary`: (String) A single, comprehensive, cumulative summary paragraph of the work performed and outcomes achieved by this Mode and its sub-chain.
2. `doc_update_request`: (String) An aggregated report of ALL documentation update needs identified by the Mode itself AND any of its subtasks. **The format MUST be EXACTLY ONE of the following two options:**

    * **If updates ARE needed:**

        ```markdown
        Docs Update Needed: YES
        ---
        [SECTION: <Existing Doc Filename OR 'New Doc - Brief Purpose'>]
        [DETAILS: <Specific change/addition/deletion required, context, and reason>]
        [REQUESTED_BY: <Self Role OR Role of Subtask that identified the need>]
        ---
        [Repeat the --- separated block for each distinct update request...]
        ```

        * _Note on `SECTION`_: For 'New Doc', provide a brief purpose. The owning Architect (`Service`, `UX`, `Architect`) determines the final filename/path during the execution of the dedicated update task assigned by the Orchestrator.

    * **If absolutely NO updates are needed:**

        ```
        Docs Update Needed: NO
        ```

    * **Failure:** Failure to use this format, report needed updates, or attempting unauthorized updates constitutes a workflow violation.

3. `major_report_items`: (String, Optional) Key findings, significant issues, or critical decisions. Omit or state "None" if not applicable.
