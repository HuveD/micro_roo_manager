---
Date: 2025.04.28 # Or current date
Category: Rule, Guideline, Document
---

# 04 Documentation Guidelines

## Goal

Establish a sustainable and easily referenceable project documentation system.

## Core Principles

* **Clarify Document Purpose:** Clearly distinguish what information each document holds (rule, reference, log, todo).
* **Maintain Currency:** Ensure core documents (rules, reference) are continuously managed to reflect the latest state.
* **Accessibility:** Structure documentation so that necessary information is easy to find.

## 1. Proposed Folder Structure

Manage documents by separating them into folders based on their nature:

* `docs/rules/`: Contains mandatory project rules, processes, role definitions, etc. (e.g., `01_architecture_role_principles.md`). These define **how things must be done**.
* `docs/reference/`: Core documents for **reference and learning**, such as technical designs, architecture diagrams, API specs, guides. Change history is important here. (e.g., `Technical_Architecture_Overview.md`).
* `docs/workflows/`: Documents defining the **procedures** for performing specific tasks. (e.g., `02_architecture_workflow_doc_updates.md`).
* `docs/logs/`: Time-ordered records of events, decisions, meeting notes, etc. Primarily additive.
* `docs/todos/`: Task lists or progress tracking documents for specific jobs. Can be marked `Completed: true` or managed separately upon completion.

## 2. Core Document Management (Rule, Reference, Workflow)

* **Importance:** These documents form the project's foundation and are essential for onboarding, decision-making, and maintenance.
* **Continuous Updates:** When changes occur, the relevant Rule, Reference, and Workflow documents **must be updated immediately** by the responsible role/person to maintain accuracy.
* **Clarity & Conciseness:** Write clearly and concisely so anyone can easily understand.

## 3. Log and Todo Management (Log, Todo)

* **Purpose:** For recording point-in-time information or tracking short-term tasks.
* **Separation:** Keep these clearly separate from core documents (use `docs/logs/` and `docs/todos/` folders).

## 4. Document Metadata Standard

All Markdown documents **must** include a metadata block at the top in the following YAML format:

```yaml
---
Date: YYYY.MM.DD       # Creation date or last significant update date
Category: Log | Todo | Rule | Document | Reference | Workflow | Guideline # Primary nature (select one or more)
(Optional) Completed: true | false # Use if Category includes Todo
(Optional) Related_Files: [./path/to/related1.md, ./path/to/related2.md] # Links to related documents
---

(Document body content starts here)
