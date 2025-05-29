Okay, I've updated the AI Rule Generator protocol based on your requirements.

The key changes include:
1.  **`/add-rule` Command Enhancement:**
    *   The command now explicitly supports both creating new rules and updating existing `local_` rules.
    *   A new step (1.2) in Phase 1 handles intent analysis to determine if the user wants to create or update, and specifically checks if an update target is a `local_` rule.
    *   It clarifies that non-`local_` rules (project rules) cannot be updated using this command.
    *   Phase 2 adapts its questioning based on whether a new rule is being created or an existing `local_` rule is being updated (e.g., loading existing content for modification).
    *   In update mode, the filename of the `local_` rule remains fixed during the operation; only its content (including the human-readable title within the Markdown) can be changed.

2.  **Optional 'Examples' Section Clarification:**
    *   Step 2.3 (Request Examples) has been rephrased to clearly state that providing examples is optional and beneficial, rather than mandatory. The AI's dialogue now offers it as a choice: "Adding examples can help... Would you like to provide or update examples...?"

3.  **Confirmation Messages:**
    *   Phase 4 (Completion and Notification) now provides different confirmation messages depending on whether a new rule was created or an existing `local_` rule was updated.

The rest of the protocol maintains its structure and adheres to the original key guidelines for clarity, conciseness, and AI-friendliness.

Here is the updated protocol:

---

# AI Rule Generator: Markdown Rule File Creation Protocol

This document outlines the protocol for the AI to process user `/add-rule` commands and generate or update Markdown rule files for a project. The AI must actively engage the user to ensure clarity, specificity, and completeness of each rule.

## Phase 1: Command Detection and Initial Analysis

### Step 1.1: Command Trigger
*   **Action:** Initiate the rule process when a user message includes the `/add-rule` command.

### Step 1.2: Initial Requirement and Intent Analysis
*   **Action:** Analyze the initial rule content/title provided by the user alongside the `/add-rule` command.
    *   **Example User Input:** `/add-rule Commit messages must always include an issue number.`
*   **Action:** Determine if the request is for creating a new rule or potentially updating an existing `local_` rule.
    *   Set default mode to "create new".
    *   Check if the provided title or content closely matches an existing rule file named `local_*.md` (e.g., `local_commit_messages_rule.md`).
    *   **If a potential `local_` rule match is found:**
        *   **AI Dialogue:** "I found an existing local rule: `[filename of matched local_ rule]` that seems related. Are you intending to update this rule, or create an entirely new one?"
        *   If user confirms **update**: Set mode to "update" and store the `[filename of matched local_ rule]` as the target file. Proceed to Phase 2, preparing to load existing rule content.
        *   If user confirms **new rule**: Keep mode as "create new". Proceed to Phase 2. The AI may optionally warn about potential duplication if similarity to an existing rule is high.
    *   **If the input suggests an attempt to modify a non-`local_` rule (i.e., a rule file not starting with `local_`):**
        *   **AI Dialogue:** "It appears you might be trying to modify a project rule. The `/add-rule` command is designed to create new rules or update existing `local_` rules (those with filenames starting with `local_`). Project rules cannot be modified with this command. Would you like to create a new `local_` rule instead?"
        *   If user agrees to create a new `local_` rule: Keep mode as "create new". Proceed to Phase 2.
        *   If user does not wish to create a new `local_` rule: End process for `/add-rule`.
    *   **If no match, or clearly a new rule and not an attempt to modify a non-`local_` rule:** Keep mode as "create new". Proceed to Phase 2.

## Phase 2: Information Gathering and Rule Definition (⭐ CRITICAL PHASE ⭐)

The AI must proactively question the user to ensure the rule is **clear, specific, and comprehensive,** whether creating anew or updating.

*   **If in "update" mode for an existing `local_` rule:**
    *   **Action:** Load the content of the target `local_*.md` file identified in Step 1.2.
    *   **AI Dialogue:** "Okay, we will update the rule `[target_filename]`. Let's review its current content and make the necessary changes."
    *   The following steps will involve presenting current content and asking for modifications.

### Step 2.1: Query Purpose and Background (or Review/Modify Existing)
*   **Action (If mode is "create new"):** Ask the user:
    *   "What is the primary purpose or background for adding this new rule?"
    *   "What problem are you trying to solve, or what value do you aim to achieve with this rule?"
*   **Action (If mode is "update"):**
    *   Present the current purpose/background from the loaded rule (if available in a structured way, or from the 'Rule Definition' section).
    *   **AI Dialogue:** "The current stated purpose/background for `[target_filename]` is: '[current purpose/background]'. Would you like to revise this?"

### Step 2.2: Elicit Detailed Rule Specifications (or Review/Modify Existing)
*   **Action (If mode is "create new"):** Prompt for specific details:
    *   "Could you elaborate on the rule? (e.g., the scope of 'always', the exact format for 'must include')."
    *   "What are the specific situations or conditions where this rule should apply?"
    *   "Are there any exceptions where this rule would not apply, or specific prohibitions?"
    *   "(Optional) What are the consequences if this rule is violated?"
*   **Action (If mode is "update"):**
    *   Present current specifications/requirements from the loaded rule (e.g., from 'Key Requirements / Criteria' and 'Rule Definition' sections).
    *   **AI Dialogue:** "Here are the current key requirements for `[target_filename]`: [list current requirements]. Would you like to add, remove, or modify any of these? What about its applicability, conditions, or prohibitions described in the definition?"

### Step 2.3: Request Examples and Non-Examples (Optional, Review/Modify Existing)
*   **Action (Applicable for both "create new" and "update" modes):**
    *   **AI Dialogue:** "Adding examples can help in understanding the rule. This is optional, but can be very helpful. Would you like to provide or update examples of correctly following this rule, and perhaps examples of what would violate it?"
    *   If the user agrees, gather compliant and non-compliant examples.
    *   If in "update" mode and examples exist, present them: "Currently, we have these examples: [show examples]. Would you like to add, remove, or modify them?"
    *   (If necessary) "If there are any borderline or ambiguous cases, discussing them would be helpful."
*   **AI Behavior:** Do not repeatedly ask for examples if the user declines or provides none. The 'Examples' section in the Markdown is optional.

### Step 2.4: Solicit/Confirm Rule Title (Human-Readable and Snake Case for New Rules)
*   **Action (If mode is "create new"):**
    *   Ask the user: "Can you suggest a concise English title (keyword) for this new rule that makes it easily identifiable? (e.g., 'Commit Message Issue Number', 'Variable Naming Convention')."
    *   **AI Behavior:**
        *   The AI should consider the user's suggestion.
        *   If no suggestion is provided, or if the suggestion is unsuitable, the AI should infer an appropriate English title based on the rule's content.
        *   The final title **must** be converted to `snake_case` for filename generation (e.g., `commit_message_issue_number`). This `snake_case` title will also be used to derive the `RULE_TITLE_HUMAN_READABLE`.
*   **Action (If mode is "update"):**
    *   The `snake_case` title for the filename (`[target_filename]`) is fixed for this update operation.
    *   Present the current human-readable title from the loaded rule.
    *   **AI Dialogue:** "The rule is identified by the filename `[target_filename]`. The current human-readable title within the file is `[Current Human Readable Title]`. Would you like to update this human-readable title?"
    *   If the user provides a new human-readable title, this will be used for `{{RULE_TITLE_HUMAN_READABLE}}` in the Markdown.

### Step 2.5: Confirmation and Iteration
*   **Action:** Summarize all gathered/modified information and the AI's understanding of the rule.
    *   **AI Dialogue Example (If "create new"):** "Based on our discussion, I understand the new rule to be: [AI's summary of the rule]. The title will be `[snake_case_title]`, leading to filename `.roo/rules/local_[snake_case_title]_rule.md`. Is this accurate? Are there any additions or modifications needed?"
    *   **AI Dialogue Example (If "update"):** "Based on our discussion, the updated rule `[target_filename]` will contain: [AI's summary of the updated rule, including any changes to the human-readable title]. Is this accurate? Are there any further changes?"
*   **AI Behavior:** Iterate through the relevant information gathering and rule definition steps (2.1-2.4) based on user feedback until the rule content is finalized.

## Phase 3: Markdown Rule File Generation

### Step 3.1: Rule Content Composition
*   **Action:** Populate the following concise, AI-optimized Markdown template with the finalized rule information.

    ```markdown
    # Rule: {{RULE_TITLE_HUMAN_READABLE}} <!-- Human-readable version of the snake_case title (for new rules) or updated human-readable title (for updates) -->

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
    <!-- Provide clear examples of adherence and violation if provided by the user. -->

    {{#IF GOOD_EXAMPLE_1}}
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
    {{/IF}}

    {{#IF BAD_EXAMPLE_1}}
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
        *   `{{RULE_TITLE_HUMAN_READABLE}}` is derived from the `snake_case` title for new rules, or is the (potentially updated) human-readable title for existing rules.
        *   `{{#IF ...}} {{/IF}}` and `{{#IF ...}} {{ELSE}} {{/IF}}` are conditional blocks. The AI populates these based on whether relevant information was gathered. If examples are not provided, the entire "3. Examples (Optional)" section (or its content part) should be omitted or minimal.
        *   For `Key Requirements / Criteria`, list each distinct requirement.
        *   For `Exceptions`, if none are specified, the AI can omit the section or write "None."

### Step 3.2: Filename Determination
*   **Action (If mode is "create new"):** Use the `snake_case` title finalized in Step 2.4.
    *   **Format:** Construct the filename as `.roo/rules/local_${title}_rule.md`.
    *   **Example:** If the title is `commit_message_issue_number`, the filename will be `.roo/rules/local_commit_message_issue_number_rule.md`.
*   **Action (If mode is "update"):** Use the `[target_filename]` (e.g., `.roo/rules/local_existing_rule_name_rule.md`) identified in Step 1.2. This filename does not change during the update operation.

### Step 3.3: File Storage
*   **Action:** Save the generated Markdown content to the path and filename determined in Step 3.2. If updating, this will overwrite the existing file.

## Phase 4: Completion and Notification

### Step 4.1: Rule Creation/Update Confirmation
*   **Action:** Inform the user about the outcome.
    *   **If a new rule was created (mode "create new"):**
        *   **AI Dialogue Example:** "The new rule file for '[Human Readable Title]' has been successfully created at: `[generated_filename]`."
        *   **AI Dialogue Example:** "This rule is now part of the project's local rule set."
    *   **If an existing `local_` rule was updated (mode "update"):**
        *   **AI Dialogue Example:** "The rule file `[target_filename]` has been successfully updated with your changes."

This protocol ensures the AI accurately captures user requirements and systematically generates or updates clear, well-defined rule documents that are beneficial to the project. **Active and precise communication with the user during Phase 2 is paramount.**
