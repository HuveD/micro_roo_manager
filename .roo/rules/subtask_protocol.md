# Optimized Subtask (`new_task`) Request Guideline

**Objective:** To guide the AI (Task Requester) in clearly defining and requesting new Subtasks, ensuring the receiving AI has all necessary information to perform the task and report back according to specified formats defined in a separate protocol.

---

**I. Core Principles for Requesting**

1.  **Clarity and Specificity:** Ensure the goal, context, and constraints of the requested task are specific and unambiguous, allowing clear understanding by the AI performing the task.
2.  **Scope Definition:** Clearly define what tasks are permitted within the `Constraints` section. This helps the performing AI identify scope deviations early.
3.  **Reporting Instruction Clarity:** Explicitly state the required reporting formats and the conditions under which each should be used by the performing AI. Crucially, reference the dedicated execution and reporting guidelines document (`.roo/rules/attempt_completion_protocol.md`) for the detailed formats and rules.

---

**II. Subtask Request Format (When creating a `new_task`)**

*   **Purpose:** To clearly define a new Subtask and provide all necessary information for execution and reporting.
*   **Instruction:** Use the following format precisely when requesting a Subtask. **Remember to replace `[TASK_TITLE]` with the specific title of the task being requested.**

```markdown
# [TASK_TITLE] Task Request
*Example: # Analyze User Feedback Task Request*

*Clearly and detailedly describe the goal and the tasks to be performed for this Subtask.*

## CONTEXT
*List all necessary background information, user inputs, reference materials (including links/paths), and precautions required for task execution.*
- e.g., User query: "..."
- e.g., Related document path: `/docs/relevant_info.md`
- e.g., API endpoint: `https://api.example.com/data`
- e.g., Precaution: Must use specific library version (v1.2.3)

## Constraints
*Explicitly list the **strictly permitted tasks** for this Subtask. Define the boundaries clearly.*
- e.g., Analyze and summarize the provided data only.
- e.g., Call the specified API (`https://api.example.com/data`) and return the raw result.
- e.g., Review code file `src/module.py` for adherence to PEP 8 style guidelines.
- **Activities outside the specified scope are strictly prohibited. The performing AI is instructed to immediately stop work and report using the 'Subtask Handover Report' format as defined in `.roo/rules/attempt_completion_protocol.md`.**

## Reporting Instructions
*These are the reporting rules the performing AI must follow upon completion or interruption of this Subtask. The detailed formats and execution rules are specified in `.roo/rules/attempt_completion_protocol.md`.*
- **On Task Completion:** The performing AI must report using the `Subtask Completion Report` format.
- **On Scope Deviation:** If an issue arises that falls outside the scope defined in `Constraints`, the performing AI must report immediately using the `Subtask Handover Report` format.

### Execution & Reporting Protocol Reference
*The detailed structures for `Subtask Completion Report` and `Subtask Handover Report`, along with execution rules, are defined in:*
*`.roo/rules/attempt_completion_protocol.md`*
```

**Final Reminder:** Ensure all Subtask requests strictly follow the format above.