# Roo Modes Base Rules

## Core Directives
- **Language:** All responses, generated text and markdown document(*.md) **MUST** be in Korean.

## Tool Usage Guidelines

### File Modification Strategy
1. **Primary Tool:** First attempt precise modifications with `apply_diff`
2. **Alternative Tools:** If unsuccessful, try `insert_content` or `search_and_replace` as appropriate
3. **Fallback Guarantee:** If any modification tool fails, **ALWAYS** use `write_file` to ensure file updates

### Primary Tool: `apply_diff`
For precise code modifications with strict formatting requirements:

**Critical Formatting Rules:**

1. **Line Identifiers (`:start_line`):**
   - **Location:** ONLY within `<<<<<<< SEARCH` block, immediately after marker and before `-------`
   - **Purpose:** Specifies starting line number for search operation

2. **Search Content:**
   - **Must contain** exact and complete code snippet to replace
   - **Must include** entire logical unit (complete functions, methods, etc.)
   - **Must capture** absolute first line (declarations) and last line (closing braces)

3. **Replacement Content:**
   - **Must contain** only new code to replace search content
   - **Must NOT include** `:start_line`, metadata, or comments about line numbers

4. **Required Delimiters:**
   - Use exact markers: `<<<<<<< SEARCH`, `-------`, `=======`, `>>>>>>> REPLACE`

**Example:**
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

### Secondary Tools

- **`write_file`:** Overwrites entire file with new content
  - **Critical:** MUST be used as fallback when any other file modification tool fails
  - **Usage:** `<write_file><path>file.js</path><content>entire file content</content></write_file>`

- **`read_file`:** Retrieves current file content
  - **Usage:** `<read_file>file.js</read_file>`

- **`insert_content`:** Adds new content at specified position
  - **Fallback:** If fails, use `write_file`
  - **Usage:** `<insert_content><path>file.js</path><line>10</line><content>new code</content></insert_content>`

- **`search_and_replace`:** Simple text replacement
  - **Use when:** `apply_diff` is unsuitable for simple changes
  - **Fallback:** If fails, use `write_file`
  - **Usage:** `<search_and_replace><path>file.js</path><search>old text</search><replace>new text</replace></search_and_replace>`

- **`execute_command`:** Runs shell commands
  - **Usage:** `<execute_command>npm test</execute_command>`