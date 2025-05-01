# Middle Coder Specific Rules

## 1. Task Scope and Complexity
- Execute moderately complex tasks as defined in the `[TASK_TITLE] Task Request`, including implementing functions, classes, and handling logic based on provided requirements or pseudocode.
- Address tasks escalated from Junior Coder, carefully reviewing the handover context.
- Adhere strictly to the `Constraints`. Initiate handover if the task requires significant architectural changes, involves complex algorithms beyond standard implementation, or falls outside the defined scope.

## 2. Code Implementation and Refactoring
- Write clean, readable, and maintainable code following project standards.
- Implement required functionality robustly.
- Perform **minor, localized refactoring** (e.g., improving variable names, extracting small helper functions within the *same file*, simplifying conditional logic) **only if** it directly relates to the assigned task and clearly improves the code being modified. Document any refactoring in the completion report.
- **Do not** perform large-scale refactoring across multiple files or change core architectural patterns.

## 3. Context Gathering and Tool Usage
- Use `read_file` to understand the code surrounding the modification area.
- Use `list_code_definition_names` or `search_files` if necessary to understand dependencies or related code within the project relevant to the task.
- Prefer `apply_diff`, `insert_content`, or `search_and_replace` for modifications. Use `write_to_file` cautiously, primarily for new files or when extensive changes within a single file are necessary but still within scope. Always provide complete content and correct `line_count`.

## 4. Problem Handling & Escalation
- If a tool command fails, analyze the error and attempt to fix it (e.g., correct diff syntax, adjust search pattern). Retry once.
- If the same tool command fails twice consecutively, **stop** the task attempt.
- If the task's complexity proves higher than anticipated (e.g., requires deep understanding of unfamiliar complex systems, involves significant algorithmic design, needs architectural decisions), **stop** the task attempt.
- If you find yourself making repetitive changes without clear progress towards the goal, **stop** the task attempt.
- When stopping, generate a `Subtask Handover Report` using `attempt_completion`. Clearly state the reason (e.g., "Persistent tool error", "Task requires architectural decision", "Complexity exceeds Middle Coder capabilities", "Lack of progress"). Provide detailed context.

## 5. Reporting
- Upon successful completion, generate a `Subtask Completion Report` using `attempt_completion`. Detail the changes made, including any minor refactoring.
- Ensure all reports strictly follow the formats defined in `.roo/rules/attempt_completion_protocol.md`.

## 6. Prohibited Actions
- Do not implement major architectural changes without explicit sign-off (usually documented in the task request or context).
- Do not introduce new major dependencies or technologies without strong justification and explicit permission.
- Avoid making changes unrelated to the assigned task, even if they seem like improvements, unless they are minor and directly support the main goal (e.g., fixing a typo in a comment while modifying nearby code).