# Orchestrator Duty: Workflow Completion & Final Review

Once all top-level subtasks delegated for the initial user request have reported completion via `attempt_completion`, you MUST perform the following final steps before concluding the workflow:

## Final Workflow Steps:

1.  **Aggregate Final Results:** Consolidate the `summary` and `major_report_items` from the final `attempt_completion` reports of your direct subtasks. This forms the basis of the overall outcome.
2.  **Process Subtask Doc Requests:** Execute the procedure defined in `05_doc_request_processing.md` for any pending update requests reported by subtasks.
3.  **Perform Orchestrator's Final Review:**
    *   **Analyze Aggregated Content:** Carefully review the aggregated `summary` and `major_report_items` from step 1.
    *   **Identify Implicit Needs:** Ask yourself: "Based on the overall accomplishments, decisions made, or significant changes implemented during this workflow, is there a need to create *new* or update *existing* documentation (`docs/*`) that *wasn't* explicitly requested by any subtask?" Consider:
        *   Major architectural decisions finalized.
        *   Significant new features or functionalities implemented whose core concepts/designs aren't yet captured.
        *   Key learnings or patterns established that should be codified in technical docs.
        *   Changes impacting service definition (`docs/service/`) or user experience flows (`docs/ux/`).
4.  **Generate & Delegate Orchestrator-Identified Updates:**
    *   **If additional needs ARE identified during your review (Step 3):**
        *   **Format the Request:** For each identified need, create a structured request block similar to the subtask format:
            ```markdown
            ---
            [SECTION: <Target Doc Filename OR 'New Doc - Brief Purpose'>]
            [DETAILS: <Specific change/addition required based on your analysis of the workflow results>]
            [REQUESTED_BY: Orchestrator Final Review]
            ---
            ```
        *   **Determine Owner:** Identify the appropriate owner (`Service Architect`, `UX Architect`, `Architect`) based on the `SECTION` and `DETAILS`.
        *   **Delegate via `new_task`:** Group requests by owner and delegate them using the **same `new_task` procedure** described in step 4 of `05_doc_request_processing.md`. Instruct the owner to process these update tasks identified during the final review.
5.  **Synthesize Final User Report:** Once all processing (including any delegations from step 4) is complete or initiated, prepare the final comprehensive report for the user, adhering to the guidelines in `06_general_conduct.md`. This report should summarize the overall outcome based on the aggregated results (step 1).

**Rationale:** This final review ensures that documentation remains consistent and up-to-date with the actual state of the project, capturing important context or decisions that might not have been flagged during individual subtask execution.
