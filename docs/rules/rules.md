# Roo Modes Base Rules

## Core Directives
- **Language:** All responses, generated text, and markdown documents (*.md) **MUST** be in Korean.

## Tool Usage Guidelines

### File Modification Strategy: Order of Operations and Failure Protocol

1.  **Primary Attempt - Precise Modification (`apply_diff`):**
    *   Always attempt file modifications **first** using `apply_diff` for precise, diff-based changes, especially for code where formatting is critical.

2.  **Secondary Attempts - Alternative Granular Tools (If `apply_diff` Fails):**
    *   If `apply_diff` is unsuccessful (e.g., due to complex changes not suitable for diffs, or if it errors), you may then attempt the modification using `insert_content` or `search_and_replace`. Choose the tool most appropriate for the specific modification task.

3.  **Ultimate Fallback - Mandatory `write_file` Usage (If ANY Modification Tool Fails):**
    *   If **ANY** file modification attempt with `apply_diff`, `insert_content`, or `search_and_replace` fails, you **MUST IMMEDIATELY AND EXCLUSIVELY** use `write_file` to update the entire file with the intended content.
    *   **CRITICAL:** This is the **FINAL** and **GUARANTEED** step to ensure the file modification is completed.
    *   **DO NOT** re-attempt a previously failed tool (e.g., `apply_diff` again after it failed).
    *   **DO NOT** try another granular tool (e.g., `insert_content` after `apply_diff` failed) if the initial attempt with that category of tool has already failed. Proceed directly to `write_file`. This is crucial to prevent operational loops.

---

### Tool: `apply_diff`
For precise code modifications with strict formatting requirements.

**Critical Formatting Rules for `apply_diff`:**

1.  **Line Identifiers (`:start_line`):**
    *   **Location:** ONLY within the `<<<<<<< SEARCH` block, immediately after the `<<<<<<< SEARCH` marker and before the `-------` delimiter.
    *   **Purpose:** Specifies the exact starting line number in the target file for the search operation.

2.  **Search Content (between `-------` and `=======`):**
    *   **Must contain** the exact and complete code snippet to be replaced.
    *   **Must include** the entire logical unit (e.g., complete functions, methods, blocks).
    *   **Must capture** the absolute first line (e.g., declarations, function signature) and the absolute last line (e.g., closing braces `}`) of the section to be replaced.

3.  **Replacement Content (between `=======` and `>>>>>>> REPLACE`):**
    *   **Must contain** only the new code that will replace the search content.
    *   **Must NOT include** any `:start_line` markers, metadata, or comments about line numbers.

4.  **Required Delimiters:**
    *   Use the exact markers: `<<<<<<< SEARCH`, `-------`, `=======`, `>>>>>>> REPLACE`.

**Example for `apply_diff`:**
  ```xml
  <apply_diff>
    <path>file/path.js</path>
    <diff>
  <<<<<<< SEARCH
  :start_line:42
  -------
  function example() {
    // Complete code block to replace
    return result;
  }
  =======
  function example() {
    // New implementation
    return updatedResult;
  }
  >>>>>>> REPLACE
    </diff>
  </apply_diff>
  ```

**Failure Handling for `apply_diff`:**
*   If `apply_diff` fails to modify the file correctly, **DO NOT** attempt `apply_diff` again. Proceed according to the "File Modification Strategy": first try `insert_content` or `search_and_replace` if appropriate for the task and if they haven't failed already for this modification. If those also fail or are not appropriate, **IMMEDIATELY** resort to `write_file`.

---

### Tool: `write_file`
Overwrites the entire file with new content.

*   **Primary Use Case (Fallback):** This tool is the **MANDATORY** fallback when `apply_diff`, `insert_content`, or `search_and_replace` fail to modify a file. Its use in such scenarios is critical to prevent loops and ensure task completion.
*   **Usage:**
    ```xml
    <write_file>
      <path>file.js</path>
      <content>entire new file content here</content>
    </write_file>
    ```

---

### Tool: `read_file`
Retrieves the current content of a specified file.

*   **Usage:**
    ```xml
    <read_file>file.js</read_file>
    ```

---

### Tool: `insert_content`
Adds new content at a specified line number in a file.

*   **Usage:**
    ```xml
    <insert_content>
      <path>file.js</path>
      <line>10</line> <!-- Line number BEFORE which the content will be inserted -->
      <content>new code to insert</content>
    </insert_content>
    ```
*   **Failure Handling:** If `insert_content` fails, **IMMEDIATELY AND ALWAYS** use `write_file` as the fallback, as per the "File Modification Strategy". Do not re-attempt `insert_content`.

---

### Tool: `search_and_replace`
Performs a simple text search and replaces all occurrences with new text.

*   **Use When:** `apply_diff` is unsuitable (e.g., for very simple, non-structural text changes, or when line numbers are unreliable).
*   **Usage:**
    ```xml
    <search_and_replace>
      <path>file.js</path>
      <search>text to find</search>
      <replace>text to replace with</replace>
    </search_and_replace>
    ```
*   **Failure Handling:** If `search_and_replace` fails, **IMMEDIATELY AND ALWAYS** use `write_file` as the fallback, as per the "File Modification Strategy". Do not re-attempt `search_and_replace`.

---

### Tool: `execute_command`
Runs shell commands. This tool is not for direct file modification.

*   **Usage:**
    ```xml
    <execute_command>npm test</execute_command>
    ```

---

### Tool: `mcp_tool`
Invokes tools on external MCP (Multi-Channel Processing) servers to access various AI or external API functionalities.

*   **Primary Purpose:**
    - Used for AI queries, external data retrieval, and complex automation via external integrations.
    - Example: Call tools on servers such as Perplexity, Bing, Google, etc.

*   **Usage:**
    ```xml
    <use_mcp_tool>
      <server_name>SERVER_NAME</server_name>
      <tool_name>TOOL_NAME</tool_name>
      <arguments>{JSON arguments}</arguments>
    </use_mcp_tool>
    ```
    - `<server_name>`: Name of the MCP server to call (e.g., perplexity)
    - `<tool_name>`: Name of the tool on the MCP server (e.g., perplexity_ask)
    - `<arguments>`: Arguments to pass to the tool (as a JSON string)
