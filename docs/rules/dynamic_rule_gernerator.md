# AI Rule Generator: Markdown Rule File Creation Protocol

This document outlines the protocol for the AI to process user `/add-rule` commands and generate Markdown rule files for a project. The AI must actively engage the user to ensure clarity, specificity, and completeness of each rule.

## Phase 1: Command Detection and Initial Analysis

### Step 1.1: Command Trigger
*   **Action:** Initiate the rule generation process when a user message includes the `/add-rule` command.

### Step 1.2: Initial Requirement Analysis
*   **Action:** Analyze the initial rule content provided by the user alongside the `/add-rule` command.
    *   **Example User Input:** `/add-rule Commit messages must always include an issue number.`

## Phase 2: Information Gathering and Rule Definition (⭐ CRITICAL PHASE ⭐)

The AI must proactively question the user to ensure the rule is **clear, specific, and comprehensive.**

### Step 2.1: Query Purpose and Background
*   **Action:** Ask the user:
    *   "What is the primary purpose or background for adding this rule?"
    *   "What problem are you trying to solve, or what value do you aim to achieve with this rule?"

### Step 2.2: Elicit Detailed Rule Specifications
*   **Action:** Prompt for specific details:
    *   "Could you elaborate on the rule? (e.g., the scope of 'always', the exact format for 'must include')."
    *   "What are the specific situations or conditions where this rule should apply?"
    *   "Are there any exceptions where this rule would not apply, or specific prohibitions?"
    *   "(Optional) What are the consequences if this rule is violated?"

### Step 2.3: Request Examples and Non-Examples
*   **Action:** Ask the user:
    *   "Please provide one or two good examples of correctly following this rule."
    *   "Could you also provide examples of what would violate this rule?"
    *   (If necessary) "If there are any borderline or ambiguous cases, discussing them would be helpful."

### Step 2.4: Solicit Rule Title Suggestion
*   **Action:** Ask the user:
    *   "Can you suggest a concise English title (keyword) for this rule that makes it easily identifiable? (e.g., 'Commit Message Issue Number', 'Variable Naming Convention')."
*   **AI Behavior:**
    *   The AI should consider the user's suggestion.
    *   If no suggestion is provided, or if the suggestion is unsuitable, the AI should infer an appropriate English title based on the rule's content.
    *   The final title **must** be converted to `snake_case`.

### Step 2.5: Confirmation and Iteration
*   **Action:** Summarize the gathered information and the AI's understanding of the rule.
    *   **AI Dialogue Example:** "Based on our discussion, I understand the rule to be: [AI's summary of the rule]. Is this accurate? Are there any additions or modifications needed?"
*   **AI Behavior:** Iterate through the information gathering and rule definition steps based on user feedback until the rule is finalized.

## Phase 3: Markdown Rule File Generation

### Step 3.1: Rule Content Composition
*   **Action:** Populate the following concise, AI-optimized Markdown template with the finalized rule information.

    ```markdown
    # Rule: {{RULE_TITLE_HUMAN_READABLE}} <!-- Human-readable version of the snake_case title -->

    ## 1. Rule Definition
    <!--
    A clear, direct statement of the rule.
    This section should cover:
    - What the rule is (the core statement).
    - The primary purpose (why it exists), if not immediately obvious from the statement.
    - The scope (when/where it applies) and any key conditions.
    -->
    {{RULE_DEFINITION_PURPOSE_SCOPE}}

    ## 2. Key Requirements / Criteria
    <!--
    Specific, actionable criteria, actions, or steps for compliance.
    - What MUST be done.
    - What MUST NOT be done.
    - Required formats, if any.
    Use a list for clarity.
    -->
    - {{REQUIREMENT_1}}
    {{#IF REQUIREMENT_2}}
    - {{REQUIREMENT_2}}
    {{/IF}}
    {{#IF REQUIREMENT_3_ETC}}
    - {{REQUIREMENT_3_ETC}}
    {{/IF}}

    ## 3. Examples (Optional)
    <!-- Provide clear examples of adherence and violation. -->

    ### Compliant
    <!-- Example(s) of correctly following the rule. -->
    ```
    {{GOOD_EXAMPLE_1}}
    ```
    {{#IF GOOD_EXAMPLE_2}}
    ```
    {{GOOD_EXAMPLE_2}}
    ```
    {{/IF}}

    ### Non-Compliant
    <!-- Example(s) of violating the rule. -->
    ```
    {{BAD_EXAMPLE_1}}
    ```
    {{#IF BAD_EXAMPLE_2}}
    ```
    {{BAD_EXAMPLE_2}}
    ```
    {{/IF}}

    ## 4. Exceptions (Optional)
    <!--
    Specific situations where this rule does not apply.
    If none, this section can be omitted or explicitly state "None."
    -->
    {{#IF RULE_EXCEPTIONS_EXIST}}
    {{RULE_EXCEPTIONS_DETAILS}}
    {{ELSE}}
    <!-- This section can be omitted if there are no exceptions, or state "None." -->
    {{/IF}}
    ```
    *   **Note:**
        *   `{{PLACEHOLDER}}` denotes information to be filled in by the AI based on user interaction.
        *   `{{RULE_TITLE_HUMAN_READABLE}}` should be derived from the `snake_case` title (e.g., `commit_message_issue_number` -> `Commit Message Issue Number`).
        *   `{{#IF ...}} {{/IF}}` and `{{#IF ...}} {{ELSE}} {{/IF}}` are conditional blocks. The AI should populate these based on whether the relevant information was gathered.
        *   For `Key Requirements / Criteria`, the AI should list out each distinct requirement.
        *   For `Exceptions`, if none are specified, the AI can either omit the section or write "None."

### Step 3.2: Filename Generation
*   **Action:** Use the `snake_case` title confirmed or generated in Step 2.4.
*   **Format:** Construct the filename as `.roo/rules/local_${title}_rule.md`.
    *   Replace `${title}` with the `snake_case` version of the rule title.
    *   **Example:** If the title is `commit_message_issue_number`, the filename will be `.roo/rules/local_commit_message_issue_number_rule.md`.

### Step 3.3: File Storage
*   **Action:** Save the generated Markdown content to the specified path and filename.

## Phase 4: Completion and Notification

### Step 4.1: Rule Creation Confirmation
*   **Action:** Inform the user that the rule file has been successfully created.
    *   **AI Dialogue Example:** "The rule file for '[Summary of original rule description]' has been successfully created at: `.roo/rules/local_${title}_rule.md`."
    *   **AI Dialogue Example:** "This rule is now part of the project's overall rule set."

This protocol ensures the AI accurately captures user requirements and systematically generates clear, well-defined rule documents that are beneficial to the project. **Active and precise communication with the user during Phase 2 is paramount.**