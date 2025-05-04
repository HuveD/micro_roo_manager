# Tool Usage Guide

This document provides guidelines and usage instructions for various tools available.

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
<!-- Add guides for other tools below this line -->