# SPARC Global Development Rules

## Core Principles
1.  **Simplicity:** Prioritize clear, maintainable solutions. Minimize complexity.
2.  **Iteration:** Enhance existing code unless fundamental changes are justified.
3.  **Focus:** Adhere strictly to defined task scope. Avoid unrelated changes.
4.  **Quality:** Deliver clean, tested, documented, secure code via structured workflows.
5.  **Collaboration:** Foster effective human-AI teamwork.
6.  **Document-Driven & Test-Driven:** All development MUST be driven by verified specification documents and accompanied by tests (TDD).

## Global Constraints
1.  **Tool Usage & Delegation:**
    *   `switch_mode` tool is prohibited.
    *   Delegate tasks via `new_task`.
    *   Refer to `docs/rules/tool_guide.md` for detailed tool usage.
2.  **Response Language:**
    *   Respond only in Korean.
3.  **Documentation Management:**
    *   All specification and documentation artifacts MUST reside within the `/docs` directory structure defined below.
    *   Context referencing MUST be based on documents within `/docs`.

## Methodology & Roles
*   Follow structured SPARC workflows (Specification to Deployment) as detailed in `docs/rules-sparc/rules.md`.
*   Adapt processes based on project complexity, always adhering to DDD/TDD.
*   Continuously improve codebase via analysis and feedback.
*   Integrate reflective awareness at each stage.
*   **Role Distinction:**
    *   `spec-pseudocode` (Specification Writer): Responsible for creating and *updating* the living specification documents and pseudocode within `/docs/specifications` and `/docs/pseudocode` throughout the workflow, based on SPARC requests. Manages removal of obsolete information.
    *   `docs-writer` (Documentation Writer): Responsible for creating final user and technical documentation within `/docs/user-guides` and `/docs/technical-docs` *after* the entire SPARC task is completed, using the final updated specifications and SPARC's detailed completion report as primary inputs.

## Documentation Folder Structure (`/docs`)

To maintain clarity and alignment with DDD principles, all specification and documentation artifacts generated during the SPARC workflow MUST reside within the `/docs` directory, following this structure:

/docs
├── README.md             # High-level overview of the documentation structure
├── specifications/       # Living documents defining system behavior (Managed by spec-pseudocode)
│   ├── bounded-contexts/ # Specifications organized by DDD Bounded Contexts
│   │   ├── <context_name_1>/
│   │   │   ├── aggregates/
│   │   │   │   └── <aggregate_name>.md # Spec for a specific aggregate
│   │   │   ├── value-objects/
│   │   │   │   └── <value_object_name>.md
│   │   │   ├── domain-events/
│   │   │   │   └── <event_name>.md
│   │   │   └── context_overview.md    # Overview of the bounded context
│   │   └── <context_name_2>/
│   │       └── ...
│   ├── cross-cutting/      # Specifications for concerns spanning multiple contexts (e.g., auth, logging)
│   │   └── <concern_name>.md
│   └── ubiquitous-language.md # Glossary of domain terms
├── architecture/         # Architectural decisions and diagrams (Managed by architect mode)
│   ├── ADRs/               # Architecture Decision Records
│   │   └── <adr_number>-<decision_title>.md
│   ├── diagrams/           # C4 models, sequence diagrams, etc. (as code or images)
│   │   └── ...
│   └── overview.md         # High-level architectural overview
├── pseudocode/           # Detailed implementation logic outlines (Managed by spec-pseudocode)
│   └── <feature_or_module_name>/
│       └── <component_name>.pseudo.md
├── user-guides/          # Final user-facing documentation (Managed by docs-writer)
│   ├── setup.md
│   ├── tutorials/
│   │   └── <tutorial_name>.md
│   └── features/
│       └── <feature_name>.md
├── technical-docs/       # Final technical/developer documentation (Managed by docs-writer)
│   ├── api-reference/      # Auto-generated or manually written API docs
│   │   └── ...
│   ├── integration-guides/
│   │   └── <integration_point>.md
│   └── deployment.md
└── reports/              # Internal reports (e.g., security audits, analysis summaries - Optional)
    └── <report_type>/
        └── <report_name>-<timestamp>.md

**Notes:**
- `<..._name>` placeholders should be replaced with descriptive, kebab-case names.
- Modes operate primarily within their designated subdirectories.
- SPARC orchestrates creation and updates by delegating to appropriate modes, ensuring documents are stored correctly.

## Configuration & Context Management
*   **`.roorules`:** Defines available AI modes and their specific operational rules (`.roo/rules-<mode>/*.md`).
*   **`/docs` Directory:** Serves as the primary source of truth and context. All specifications, architecture, pseudocode, and final documentation reside here.
*   **Document-Based Context:** AI modes MUST derive their understanding and context primarily from the relevant documents within the `/docs` structure provided in task requests. Reference existing documents for consistency and informed decision-making.

## Programming Guidelines
*   **Clarity:** Write straightforward, self-explanatory code. Use comments for complex logic.
*   **Best Practices:** Adhere to language-specific (Python, JS, etc.) and project conventions.
*   **Consistency:** Maintain uniform conventions across the project codebase.

## Project Understanding
*   **Documentation First:** Review essential docs within `/docs` before implementation. Request clarification or specification updates via SPARC if needed.
*   **Architecture Adherence:** Follow established module boundaries and designs documented in `/docs/architecture`. Justify architectural deviations via ADRs.
*   **Pattern/Stack Awareness:** Use documented technologies/patterns. Justify introducing new elements.

## SPARC Workflow Execution
*   **Detailed Workflow:** The full SPARC workflow (Specification, Pseudocode, Architecture, Implementation/Refinement, Completion) including mandatory evaluation and **document update steps** is defined in `docs/rules-sparc/rules.md`. **Adhere strictly to this detailed workflow.**

## AI Collaboration
*   **Clear Instructions:** Provide explicit directives, outcomes, constraints, context (referencing specific documents in `/docs`).
*   **Context Referencing:** Reference relevant documents in `/docs`.
*   **Suggest vs. Apply:** Clearly indicate AI action ("Suggestion:" vs. "Applying fix:").
*   **Critical Evaluation:** Thoroughly review AI outputs against documents and requirements.
*   **Focused Tasks:** Assign specific, well-defined tasks aligned with documents.
*   **Leverage Strengths:** Use AI for refactoring, analysis, optimization, test generation based on specs. Human oversight for core logic/architecture.
*   **Incremental Progress:** Break complex tasks into reviewable sub-steps with potential document updates.
*   **Standard Check-in:** Confirm understanding referencing documents (e.g., "Reviewed `/docs/specifications/.../spec.md`, goal is [goal], proceeding with [step].").

## Advanced Capabilities
*   Utilize AI's emergent intelligence, pattern recognition, and adaptive optimization capabilities where appropriate, guided by specifications.
*   Integrate symbolic reasoning for robust decision-making and coherent documentation, grounded in `/docs`.

## Code Quality & Style
1.  **Typing & Documentation:**
    *   **Prefer Static Typing:** Use static types or hints.
    *   **Document Clearly:** Use standard doc comments referencing specifications where applicable.
    *   **Avoid Ambiguous Types:** Strictly avoid `any`, `dynamic`, raw `Object`. Favor explicit types/interfaces/classes defined or implied by specs.
2.  **Maintainability:** Write modular, scalable, clear code aligned with specs.
3.  **Conciseness:** Keep files concise (< 300 lines); refactor proactively.
4.  **DRY (Don't Repeat Yourself):** Systematically identify and remove redundancy.
5.  **Linting/Formatting:** Adhere strictly to project's configured tools (ESLint, Prettier, Black, etc.).
6.  **File Naming:** Use descriptive, standardized names.
7.  **No One-Time Scripts:** Do not commit temporary utility scripts.

## Refactoring
*   **Purposeful:** Refactor with clear goals (readability, redundancy reduction, architecture/spec alignment).
*   **Holistic:** Consolidate similar components.
*   **Direct Modification:** Modify existing code directly; avoid duplication.
*   **Verification:** Verify integrations and spec adherence after changes.

## Testing & Validation (TDD Focus)
*   **Test-Driven:** Define and write tests *based on specifications* before implementing features or fixes.
*   **Coverage:** Ensure thorough test coverage for spec requirements (critical paths, edge cases).
*   **Tests Must Pass:** Address failing tests immediately.
*   **Manual Checks:** Complement automated tests with structured manual verification against specs.

## Debugging
*   **Root Cause:** Identify underlying causes relative to expected behavior defined in specs.
*   **Logging:** Use precise, targeted logging.
*   **Research Tools:** Utilize agentic tools for complex issues.

## Security
*   **Server-Side Authority:** Keep sensitive logic/data server-side.
*   **Input Sanitization:** Enforce rigorous server-side validation based on spec constraints.
*   **Credentials:** Manage securely via environment variables. No hardcoding.

## Version Control & Environment
*   **Git Hygiene:** Commit frequently with clear messages referencing tasks/specs.
*   **Branching:** Adhere strictly to the defined strategy.
*   **Environment Consistency:** Ensure code compatibility across environments.
*   **Server Management:** Restart servers systematically after updates.

## Documentation Maintenance (Living Documents)
*   **Accurate & Updated:** Keep `/docs/specifications` and other relevant documents current throughout the development lifecycle via SPARC-delegated updates.
*   **Continuous Updates:** Regularly refine guidelines.
*   **Check Files:** Ensure all documented files are accurate and relevant.
*   **Comments:** Use code comments to clarify implementation details not obvious from specs.
