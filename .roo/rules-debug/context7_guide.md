# Context7 MCP Usage for AI

## 1. Core Objective
The primary objective when using the `context7` MCP (Meta-Cognitive Primitive) is to **ensure the generation of accurate, up-to-date, and version-specific information**, particularly for software libraries, APIs, frameworks, SDKs, and code examples. Active utilization of `context7` mitigates reliance on potentially outdated training data and prevents hallucinated or incorrect technical details.

## 2. Usage Triggers: When to Use Context7
You **MUST** invoke `context7` via the `use_mcp_tool` structure under the following circumstances:

*   **2.1. Specific Software Component Information:** When the user query explicitly requests or implicitly requires information about a named software library, framework, API, or SDK.
*   **2.2. Version-Specific Details:** When version-specific details of a technology are crucial for accuracy or explicitly mentioned by the user.
*   **2.3. Code Example Generation:** When asked to provide code examples for a particular library, function, class, or software component.
*   **2.4. Accuracy Confirmation:** Before generating code, technical explanations, or configurations where up-to-date accuracy is paramount to avoid errors, deprecation issues, or non-functional examples.
*   **2.5. Outdated Knowledge Suspicion:** If there is a reasonable suspicion that your internal knowledge regarding a specific technical query might be outdated, too generic, or incomplete.
*   **2.6. Uncertainty in Usage:** When uncertain about the correct usage, API details, or best practices for a software library or framework.
*   **2.7. Error Resolution and Correction:** When errors occur related to software libraries, frameworks, or APIs, to obtain accurate troubleshooting information or validated code corrections.

## 3. Querying Process & Refinement

*   **3.1. Identify Need:** Recognize that a user's query falls under the triggers defined in Section 2.
*   **3.2. Formulate Precise Arguments for Context7:**
    *   Construct targeted arguments for the `context7` server.
    *   The `arguments` JSON **MUST** include the `library` name.
    *   The `arguments` JSON **SHOULD** include the `version` if specified by the user or if critical for accuracy.
    *   The `arguments` JSON **MAY** include `type` (`documentation`, `code_example`, `api_reference`) to narrow results from the `get-library-docs` tool.
    *   Ensure the `query` string within `arguments` is specific enough to yield relevant results.
*   **3.3. Execute MCP Tool Call:** Trigger the `context7` server using the `use_mcp_tool` structure with the formulated parameters. The primary tool for fetching information is `get-library-docs`.
    ```xml
    <use_mcp_tool>
    <server_name>context7</server_name>
    <tool_name>get-library-docs</tool_name>
    <arguments>
    {
      "query": "<your_query_string>",
      "library": "<library_name>",
      "version": "<version_if_applicable>",
      "type": "<type_if_applicable>"
    }
    </arguments>
    </use_mcp_tool>
    ```
*   **3.4. Evaluate & Integrate Response:**
    *   Review the information returned by `context7`.
    *   **MUST** prioritize `context7` information over general knowledge for the specific query it addresses.
    *   Directly use the retrieved information to formulate your answer.
    *   If providing code, ensure it aligns with or is based on the examples/API details from `context7`.
    *   Synthesize the information clearly and accurately for the user.
*   **3.5. Self-Correction and Refinement (If Necessary):**
    *   **IF** `context7` (e.g., via `get-library-docs` tool) returns no relevant information or if the information is too broad:
        1.  Analyze the `arguments` for potential issues:
            *   Is the `library` name correct and specific?
            *   Can a `version` be added or corrected?
            *   Would specifying a `type` (`documentation`, `code_example`, `api_reference`) improve results?
            *   Is the `query` string too vague or too narrow?
        2.  Refine the `arguments` based on the analysis.
        3.  Retry the `use_mcp_tool` call with refined `arguments`.
    *   **CRITICAL: Do NOT hallucinate or invent information if `context7` cannot provide it.**
        *   If, after refinement, `context7` still cannot provide the specific up-to-date information, you **MUST** clearly state to the user that the information could not be retrieved via `context7` for the given parameters. Avoid providing potentially incorrect or outdated information from your general knowledge base for that specific failed query.

## 4. MCP Tool Call Examples

*   **Example 1:** Get code examples for the `map` function in pandas version 2.1.0.
    ```xml
    <use_mcp_tool>
    <server_name>context7</server_name>
    <tool_name>get-library-docs</tool_name>
    <arguments>
    {
      "query": "how to use map function",
      "library": "pandas",
      "version": "2.1.0",
      "type": "code_example"
    }
    </arguments>
    </use_mcp_tool>
    ```

*   **Example 2:** Find documentation on authentication middleware in Express.js (version not specified).
    ```xml
    <use_mcp_tool>
    <server_name>context7</server_name>
    <tool_name>get-library-docs</tool_name>
    <arguments>
    {
      "query": "authentication middleware",
      "library": "Express.js",
      "type": "documentation"
    }
    </arguments>
    </use_mcp_tool>
    ```

*   **Example 3:** Get API reference for S3 PutObject with the AWS SDK for Python (Boto3).
    ```xml
    <use_mcp_tool>
    <server_name>context7</server_name>
    <tool_name>get-library-docs</tool_name>
    <arguments>
    {
      "query": "S3 PutObject",
      "library": "AWS SDK for Python (Boto3)",
      "type": "api_reference"
    }
    </arguments>
    </use_mcp_tool>
    ```

---

## 5. Absolute Imperative
**The use of `context7` via `use_mcp_tool` (e.g., with the `get-library-docs` tool) for queries pertaining to software libraries, APIs, or specific code implementations is NOT OPTIONAL. It is a fundamental requirement to ensure the delivery of correct, current, and reliable information.**