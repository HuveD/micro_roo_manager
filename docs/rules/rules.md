# Roo Modes Base Rules

## Core Directives
-   **Language:** All responses, generated text and markdown document(*.md) **MUST** be in Korean.

## Tool Usage Guidelines

### Primary Tool: `apply_diff`
The `apply_diff` tool is used for precise code modifications. It requires strict adherence to the following formatting rules for its search and replace blocks to ensure accuracy and prevent errors.

**Critical Formatting Rules for `apply_diff`:**

1.  **Line Identifiers (`:start_line`)**:
    *   **Placement:** **MUST** be located exclusively within the `<<<<<<< SEARCH` block, positioned immediately after the `<<<<<<< SEARCH` marker and **before** the `-------` delimiter.
    *   **Function:** Specifies the starting line number in the target file for the search operation.

2.  **Search Content (Code between `-------` and `=======`)**:
    *   **Definition:** This section **MUST** contain the **exact and complete code snippet** to be found and replaced. The search is performed starting from the line indicated by `:start_line`.
    *   **Accuracy Mandate:** The content **MUST** be a **precise and complete representation** of the code segment intended for replacement.
    *   **Scope - Full Logical Unit:** **MUST** encompass the **entire logical unit** being modified.
        *   *Example:* If modifying a function, include the complete function signature (e.g., `Future<void> _functionName(...) async {`) and its entire body, down to and including its closing brace `}`.
    *   **Completeness - Avoid Errors:** **MUST** include the **absolute first line** (e.g., function/method declaration, class declaration, start of a loop/conditional statement) and the **absolute last line** (e.g., corresponding closing brace `}`) of the target code block.
        *   *Consequence of Omission:* Partial selections, especially missing the start of a block, will result in errors such as code duplication or incorrect modifications.

3.  **Replacement Content (Code between `=======` and `>>>>>>> REPLACE`)**:
    *   **Definition:** This section provides the new code that will replace the *entire* search content.
    *   **Content Mandate:** **MUST ONLY** contain the new code.
    *   **Prohibited Content:** **MUST NOT** include `:start_line`, any other metadata, comments related to line numbers, or any part of the search block.
    *   **Requirement:** The content must be a clean, pure code snippet intended for replacement.
        *   *Consequence of Violation:* Incorrect content in this block will cause tool errors.

4.  **Delimiters**:
    *   The markers `<<<<<<< SEARCH`, `-------`, `=======`, and `>>>>>>> REPLACE` are strict and **MUST** be used exactly as shown to define the structure of the diff block.

**Example: `apply_diff` Usage**
```xml
<apply_diff>
  <path>file/path.js</path>
  <diff>
  <<<<<<< SEARCH
  :start_line:start_line_number  // Correct: Line identifiers are HERE, before -------
  -------
  // CRITICAL: This MUST be the EXACT and COMPLETE code to be replaced.
  // Ensure it includes the full signature if it's a function/method,
  // and the entire body down to the closing brace.
  =======
  // The new code snippet that will replace the ENTIRE content of the SEARCH block above.
  // CRITICAL: This block MUST contain ONLY the new code.
  // ABSOLUTELY NO :start_line or other metadata here.
  >>>>>>> REPLACE
  </diff>
</apply_diff>
```

### Secondary Tools

-   **`write_file`**: Overwrites the entire file with new content.
    *   *Purpose:* Use when you need to completely replace all contents of a file. The existing content will be discarded and replaced with the specified new content. If any file writing operation such as `apply_diff`, `insert_content`, or `search_and_replace` fails or is unsuitable, you MUST always use `write_file` as the final fallback to ensure the file is updated correctly.
    *   *Usage:* Specify both the file path and the full new content to write.
-   **`read_file`**: Reads content from a specified file.
    *   *Usage:* To retrieve the current content of a file for review or as a basis for other operations.
-   **`insert_content`**: Inserts new content into a file.
    *   *Usage:* Typically for adding documentation, new code sections, or other content where a full search-and-replace (like `apply_diff`) is not required.
    *   Requires specifying the insertion point (e.g., line number or after a specific marker) and the content to insert.
    *   *Important:* If this operation fails or is unsuitable, you MUST use `write_file` to update the file.
-   **`execute_command`**: Executes shell commands.
    *   *Usage:* Primarily for tasks like testing API connectivity, running build scripts, or validating integration setups.
    *   Exercise caution with commands that modify the file system or system state.
-   **`search_and_replace`**: Performs simple text search and replace operations within a file.
    *   **Usage Precaution:** Use only when `apply_diff` is unsuitable, typically for very simple, non-structural text changes or when line numbers are unreliable.
    *   **Parameters:** **MUST** include both the search string and the replacement string.
    *   *Important:* If this operation fails or is unsuitable, you MUST use `write_file` to update the file.