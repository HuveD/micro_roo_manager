# Optimized Subtask (Built-in `new_task` Tool) Request Guideline

**Objective:** To guide the AI (Task Requester) in clearly defining and requesting new Subtasks, ensuring the receiving AI has all necessary information to perform the task and report back according to specified formats defined in a separate protocol.

---

**I. Core Principles for Requesting**

1.  **Clarity and Specificity:** Ensure the goal, context, and constraints of the requested task are specific and unambiguous, allowing clear understanding by the AI performing the task.
2.  **Scope Definition:** Clearly define what tasks are permitted within the `Constraints` section. This helps the performing AI identify scope deviations early.
3.  **Reporting Instruction Clarity:** Explicitly state the required reporting formats and the conditions under which each should be used by the performing AI. Crucially, reference the dedicated execution and reporting guidelines document (`.roo/rules/attempt_completion_protocol.md`) for the detailed formats and rules.

---

**II. Subtask Request Format (When using the built-in `new_task` tool)**

*   **Purpose:** To clearly define a new Subtask and provide all necessary information for execution and reporting.
*   **Instruction:** Use the following format precisely when requesting a Subtask using the built-in `new_task` tool (invoked with `<new_task>...</new_task>` tags). **Remember to replace `[TASK_TITLE]` with the specific title of the task being requested.**

```markdown
# [TASK_TITLE] Task Request
*Example: # Analyze User Feedback Task Request*

**[IMPORTANT] Describe the specific goal and the tasks to be performed for this Subtask clearly and in detail here.**
*Provide a comprehensive description of the subtask's objective and the specific actions the receiving AI needs to take. Be explicit about the expected outcome and any key requirements.*

*Example 1 (Coding Task):*
*Goal: Implement unit tests for the `FillBlankAlphabetQuizCard` widget.*
*Tasks:*
*   *Verify that selecting a correct answer option triggers the `onAnswerSelected` callback with the correct letter.*
*   *Verify that selecting an incorrect answer option triggers the `onAnswerSelected` callback with the incorrect letter.*
*   *Ensure that the widget's state updates correctly after an answer is selected (e.g., visual feedback).*
*   *Cover edge cases, such as empty input or null callbacks.*

*Example 2 (Analysis Task):*
*Goal: Analyze user feedback logs to identify the most common issues reported in the last 7 days.*
*Tasks:*
*   *Parse log files located in `/logs/user_feedback/` from the past week.*
*   *Categorize feedback entries based on keywords (e.g., "bug", "feature request", "UI issue").*
*   *Count the occurrences of each category.*
*   *Summarize the top 3 most frequent issue categories and provide representative examples for each.*
## CONTEXT
*Detailed description of all background information, user input, and reference materials required for performing the task (file paths, document links/paths, descriptions of relevant images, log file paths, summary of previous step results, etc.), as well as precautions.*
- e.g., User Query: "..."
- e.g., Relevant Document Path: `docs/relevant_info.md`
- e.g., API Endpoint: `https://api.example.com/data`
- e.g., Precaution: Must use a specific library version (v1.2.3)
- e.g., Description of Relevant Image: `screenshot_error.png` (Refer to attached image, showing a specific UI element error)
- e.g., Relevant Log File: `/logs/app_error.log` (Need to check logs at the time of error occurrence)
- e.g., Result from Previous Step: Refer to Specification document (`docs/spec_v1.md`)

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