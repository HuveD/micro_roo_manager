# Tool Usage Guidelines Index for aiGI

To prevent common errors when using tools, refer to these detailed guidelines:

## Core Tool Usage Guidelines

**!!! Most Important Absolute Rule: DO NOT use `tool_name` !!!**
- `tool_name` is merely a concept for explanation and should **never** be used in the actual output. Instead of `tool_name`, you must use the **actual documented specific tool names** like `read_file`, `write_to_file`, etc.

**1. Correct Method for Tool Calls**:
* Always use the specific tool name documented in the instructions as the tag.
* Example: For the file reading tool, the tag is <read_file>.
* Example: For the file writing tool, the tag is <write_to_file>.
* You must place the actual specific parameter value, such as the file name, inside these correct tool tags.
* Correct Example: <read_file>actual_document_name.txt</read_file>
* Correct Example: <write_to_file>output_data.csv</write_to_file>

**2. Commonly Observed Error Patterns (Absolutely DO NOT use like this):**

* **Very Incorrect Usage Example 1:** `<tool_name>read_file</tool_name>`
    * *Reason for Error:* Used the placeholder string `tool_name` as the actual tag. The correct tag should be `<read_file>`. `read_file` is the tag name, not content inside a `tool_name` tag.

* **Very Incorrect Usage Example 2:** `<tool_name>read_file</tool_name> reflection_LS2.md </read_file>`
    * *Reason for Error:* This format is completely wrong. It still uses `tool_name` as the tag, and the internal structure is also incorrect. `reflection_LS2.md` must be placed inside the `<read_file>` tag.

* **Very Incorrect Usage Example 3:** `<tool_name>actual_filename_here</tool_name>`
    * *Reason for Error:* `tool_name` is a placeholder and cannot be used as a tag.

* **Very Incorrect Usage Example 4 (Using placeholders as values):**
    * `<read_file>tool_name</read_file>`
    * `<write_to_file>filename</write_to_file>`
        * *Reason for Error:* Used conceptual placeholder words like `tool_name` or `filename` as the value inside the correct tool tag. This location requires the **actual specific value** (e.g., `my_document.txt`).

**3. Correct Usage (Strongly Repeated Emphasis):**
* If you need to read the file `reflection_LS2.md`:
    * **Correct Answer:** `<read_file>reflection_LS2.md</read_file>`
* If you need to write to the file `my_notes.txt`:
    * **Correct Answer:** `<write_to_file>my_notes.txt</write_to_file>`

**4. Distinction Between 'Parameter Name' and 'Value'**:
* Terms like parameter_name (or 파일명 in "파일명을 입력하세요") are concepts explaining what kind of information is needed.
* Do not use the literal string parameter_name or filename (as a general concept) in the location where the actual value is required. You must provide the actual value.

**Final Check Items:**
- The string `tool_name` is an **explanatory word** to help you (the AI) understand which part of the instruction refers to the identifier of a tool. It is **absolutely not** the actual tag or content to be included in the final output.
- If, after generating the response, the string `<tool_name` is included, that response is **incorrect** and must be corrected.

## File Operations
- [File Operations Guidelines](../references//file_operations_guidelines.md) - Guidelines for read_file, write_to_file, and list_files

## Code Editing
- [Apply Diff Guidelines](../references//apply_diff_guidelines.md) - Guidelines for apply_diff
- [Search and Replace Guidelines](../references//search_replace.md) - Guidelines for search_and_replace
- [Insert Content Guidelines](../references//insert_content.md) - Guidelines for insert_content

## Testing
- [TDD Guidelines](./tdd_guidelines.md) - Guidelines for test-driven development

## Key Points to Remember:
1. Always include all required parameters for each tool
2. Verify file existence before attempting modifications
3. For apply_diff, never include literal diff markers in code examples
4. For search_and_replace, always include both search and replace parameters
5. For write_to_file, always include the line_count parameter
6. For insert_content, always include valid line and content parameters
7. Follow TDD principles by writing tests before implementation
8. Use MCP tools to validate operations before execution

## Test-Driven Development Integration
1. Write tests before implementation code
2. Use tools to incrementally update code to pass tests
3. Maintain comprehensive test coverage
4. Leverage MCP for test enhancement and error resolution