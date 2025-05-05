# Tool Usage Guide

This document provides guidelines and usage instructions for various tools available.

---

## General Tool Usage Format

All tools must be invoked using XML-style tags. The tool name itself forms the main tag, and each parameter is enclosed within its own tag inside the main tool tag.

**Correct Format:**

```xml
<tool_name>
  <parameter1_name>value1</parameter1_name>
  <parameter2_name>value2</parameter2_name>
</tool_name>
```

**Incorrect Format (Example):**

```xml
<tool_use>  <!-- Incorrect: Should be the tool name -->
  <tool_name>read_file</tool_name> <!-- Incorrect: Parameter name should be used -->
  value_here <!-- Incorrect: Value should be inside parameter tags -->
</tool_use>
```

Always refer to the specific tool's documentation below for the correct parameters and usage.

---

## `search_files`

### Overview

The `search_files` tool performs regex searches across multiple files within a specified directory. It's useful for locating specific code patterns, text snippets, or other content throughout the project, providing results with surrounding context.

### Parameters

*   `path` (required): The directory path to search within (relative to the workspace root).
*   `regex` (required): The regular expression pattern to search for (using Rust regex syntax).
*   `file_pattern` (optional): A glob pattern to filter files (e.g., `*.ts`, `*.py`). If omitted, searches all files.

### Usage

*   **Finding Code:** Locate specific function calls, variable usages, or class definitions across the codebase.
*   **Refactoring:** Identify all instances of a pattern before making changes.
*   **Searching Text:** Find specific comments (like `TODO`), configuration values, or text strings in multiple files.

### Precautions

*   **Regex Syntax:** Uses Rust regex syntax, which might differ slightly from other implementations (e.g., JavaScript, Python).
*   **Performance:** Searching very large directories or using complex regex patterns might take longer.
*   **Binary Files:** Primarily designed for text files. Results for binary files might not be meaningful.
*   **Result Limit:** Automatically limits output to the first 300 matches. Use more specific `regex` or `file_pattern` if needed.
*   **Context:** Shows 1 line of context before and after each match by default. Context might merge for nearby matches.

### Example

Search for `TODO` or `FIXME` comments in all TypeScript files within the `src` directory:

```xml
<search_files>
<path>src</path>
<regex>TODO|FIXME</regex>
<file_pattern>*.ts</file_pattern>
</search_files>
```

---

## `read_file`

### Overview

The `read_file` tool reads the contents of a file in your project. It is used to inspect code, configuration files, and documentation to provide better context and support for development tasks.

### Parameters

*   `path` (required): The path to the file to read, relative to the workspace root.
*   `start_line` (optional): The starting line number to read from (1-based, inclusive).
*   `end_line` (optional): The ending line number to read to (1-based, inclusive).

### Usage

*   **Code Review:** Read source files to understand or review code.
*   **Configuration Analysis:** Inspect config files for troubleshooting or setup.
*   **Documentation:** Read documentation files before suggesting changes or improvements.
*   **Partial Reads:** Use `start_line` and `end_line` to efficiently read only the relevant section of large files.

### Reading Strategy

1. **Explicit Line Range:**
    - If `start_line` or `end_line` is provided, only the specified range is read.
    - This is the highest priority and is efficient for large files.
2. **Automatic Truncation:**
    - If no line range is specified and the file is large (e.g., over 500 lines), only the first N lines (e.g., 500) are read.
    - A truncation notice is appended, and for code files, a summary of definitions may be included.
3. **Full File Read:**
    - If the file is small or a supported binary (PDF/DOCX), the entire content is read or extracted.

### Example

Read the entire file:
```xml
<read_file>
<path>src/app.js</path>
</read_file>
```

Read a specific line range:
```xml
<read_file>
<path>src/app.js</path>
<start_line>10</start_line>
<end_line>20</end_line>
</read_file>
```

### Error Handling

*   If the file does not exist, an error message is returned.
*   If access is denied (e.g., by `.rooignore`), an error message is returned.
*   For very large files, only the first N lines are shown with a truncation notice.

### Reference
- For more details, see the [official documentation](https://docs.roocode.com/advanced-usage/available-tools/read-file).

<!-- Add guides for other tools below this line -->