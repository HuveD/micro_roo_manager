# Orchestrator Duty: Processing Subtask Doc Update Requests

This procedure details how you MUST process documentation (`docs/*`) update requests reported by subtasks via the `doc_update_request` field in their `attempt_completion` results. (For handling needs identified during your own final review, see `07_workflow_completion_review.md`).

## Processing Steps for Subtask Requests:

1.  **Monitor & Verify:** Monitor `attempt_completion` results. Verify the mandatory `result` structure (`04_completion_reporting.md`).
2.  **Check `doc_update_request`:** Examine the field.
3.  **Process "YES" Requests:** If it starts with `Docs Update Needed: YES`:
    *   **Parse:** Process each `---` request block.
    *   **Determine Owner:** Identify owner (`Service Architect`, `UX Architect`, `Architect`) based on `SECTION` (paths like `docs/service/`, `docs/ux/`, `docs/tech/`) and `DETAILS`.
        *   *Ambiguity Handling:* Use `ask_followup_question`.
    *   **Group by Owner**.
4.  **Delegate Update Tasks:** For each owner with requests:
    *   **Create `new_task`**.
    *   **Provide Request List** (relevant `---` blocks).
    *   **Instruct Owner** (e.g., "Process these doc update requests for your area [`docs/service/` | `docs/ux/` | `docs/tech/`]. Analyze, implement... report completion.").

**Note:** Ensures requests are routed correctly.
