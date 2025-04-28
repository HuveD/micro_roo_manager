# 03 Architecture: Workflow - Technical Design & Implementation Handoff

## 1. Context Acquisition (For Technical Design)

* **Action:** When context is needed, use `read_file`/`search_files` to directly gather information from any relevant location (`docs/tech/`, `docs/service/`, `docs/ux/`, source code, etc.). Delegate complex investigations to `researcher` (`new_task:researcher`).
* **Analysis:** Perform technical analysis based on all gathered information.

## 2. Implementation Planning

* **Required Output Examples (Stored in or linked from `docs/tech/`):**
    1. Technical Architecture Design Document
    2. `docs/tech/` Update Plan (managed via the workflow in `02_architecture_workflow_doc_updates.md`)
    3. Component Diagrams
    4. Sequence Diagrams
    5. API Design Specifications
    6. Data Model Descriptions
    7. (Other necessary technical artifacts)
* **Handoff Procedure:**
    1. Finalize the technical plan. Identify necessary updates **within `docs/tech/`**.
    2. **Initiate & Complete Prerequisite `docs/tech/` Doc Updates:** Follow the workflow in `02_architecture_workflow_doc_updates.md`. Wait for `intern`'s `attempt_completion` confirming these updates.
    3. (If necessary) Request user review for the main technical implementation plan using `ask_followup_question`.
    4. **Delegate Main Implementation:** Delegate to `Senior`/`Midlevel` developers via `new_task`. Include context, references to the plan, and references to the **completed/updated documentation in `docs/tech/`.**
    5. **Monitor & Final Report:** Report the completion status of planning, prerequisite document updates, and delegated implementation tasks to the Orchestrator via `attempt_completion`.
