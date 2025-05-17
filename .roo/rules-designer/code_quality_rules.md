# AI-Optimized Code Quality Guidelines

## Core Principles
*   **Strict Adherence:** These guidelines are foundational for maintaining high-quality, maintainable, and understandable code.
*   **AI Assistance Focus:** This document also guides AI tools in providing feedback and refactoring suggestions based on these rules.

## 1. Method Design
*   **Maximum Length:** Methods MUST NOT exceed **ten (10)** lines of code, excluding comments and blank lines.
*   **Single Responsibility Principle (SRP):** Each method MUST have one, and only one, reason to change, performing a single, well-defined task.
*   **Extraction:** Refactor methods violating length or SRP into smaller, highly focused units.

## 2. Code Structure and Modularity
*   **File Organization:**
    *   Group code into separate files by logical concerns (e.g., feature, module, primary class, interface, enum).
    *   Prohibition: Monolithic files. Avoid files containing unrelated or loosely related code.
*   **Cohesion and Coupling:**
    *   Maximize intra-module cohesion (related code elements belong together).
    *   Minimize inter-module coupling (reduce dependencies between modules).

## 3. Abstraction Consistency
*   **Single Level of Abstraction (SLA):** Each method MUST operate at a single, consistent level of abstraction.
    *   A method should consistently either orchestrate calls to other services/methods (high-level) or implement detailed logic (low-level).
    *   Prohibition: Do not mix high-level operational logic (e.g., coordinating multiple complex steps) with low-level implementation details (e.g., data manipulation, direct hardware interaction) within the same method.

## 4. Conditional Logic
*   **Guard Clauses:** Use guard clauses (early `if` exits) for preconditions and input validation, primarily at the beginning of methods.
*   **Prohibition: `if/else` Constructs:** Avoid `if/else` statements.
    *   Alternatives: Prefer multiple guard clauses for simple conditions, or polymorphism/Strategy pattern for complex logic.
*   **Prohibition: `switch` Statements:** Strictly avoid `switch` (or `case`) statements.
    *   Alternatives: Utilize polymorphism, Strategy pattern, or other object-oriented design patterns.
*   **Pure Conditions:** All conditional expressions (e.g., in `if` statements, loops) MUST be pure, meaning they do not cause side effects.

## 5. Object-Oriented Programming (OOP) Principles
*   **Interface-Based Inheritance:** Inherit exclusively from interfaces.
    *   Prohibition: Do not inherit from concrete or abstract classes.
*   **Tell, Don't Ask Principle:**
    *   Objects MUST encapsulate their state and behavior, performing actions based on commands received.
    *   Minimize or avoid public getters that merely expose internal state for external code to make decisions upon.
*   **Type Code Elimination:** Replace primitive type codes (e.g., integers or strings used to represent types or states) with dedicated classes, subclasses, or object-oriented patterns (e.g., State pattern, Strategy pattern).

## 6. Code Clarity and Maintainability
*   **Self-Documenting Code:** Strive for code where its intent and functionality are clear from reading the code itself, making most comments redundant.
*   **Purposeful Comments:** If comments are absolutely necessary:
    *   They MUST explain *why* a particular design choice was made or *why* a piece of code exists (e.g., rationale, trade-offs, workarounds for external system quirks).
    *   Prohibition: Do not write comments that explain *what* the code is doing; the code itself should fulfill this role.
    *   Ultimate Goal: Write code that requires no comments to be understood.
*   **Eliminate Waste:** Ruthlessly delete unnecessary, dead (unreachable), or overly complex code.
*   **Prioritization:** Prioritize clarity, correctness, and long-term maintainability over premature optimization.
*   **Identify & Refactor Problematic Code:** Actively identify code that is poorly structured, overly complex, or difficult to understand. Prioritize such code for refactoring.

## AI Assistance Protocol
When assisting developers, the AI should prioritize guidance and refactoring suggestions based on these guidelines, focusing in the following order:

1.  **Method Length & SRP Violations:**
    *   Identify methods exceeding the 10-line limit.
    *   Suggest extraction of logic to ensure each method adheres to SRP and meets length requirements.
2.  **Complex Conditional Logic:**
    *   Identify uses of `if/else` constructs and `switch` statements.
    *   Recommend replacements such as guard clauses, polymorphism, or strategy patterns.
3.  **"Tell, Don't Ask" Principle Adherence:**
    *   Identify excessive use of getters that lead to external code querying object state for decision-making.
    *   Suggest refactoring to empower objects with behavior, internalizing decision logic.
4.  **Inheritance Practices:**
    *   Detect inheritance from concrete or abstract classes.
    *   Advise migration to interface-based inheritance.
5.  **File Organization & Modularity Issues:**
    *   Detect monolithic files or poor logical grouping of code.
    *   Advise on restructuring to improve cohesion and reduce coupling.
6.  **Abstraction Level Consistency:**
    *   Identify methods mixing different levels of abstraction.
    *   Suggest refactoring to maintain a single level of abstraction per method.
7.  **Use of Type Codes:**
    *   Find instances where primitive type codes are used.
    *   Recommend replacing them with dedicated classes or appropriate OO patterns.
8.  **Code Clarity & Waste Reduction:**
    *   Highlight opportunities to improve code clarity (e.g., removing comments that explain the 'what').
    *   Suggest removal of dead, unnecessary, or overly complex code.
9.  **Tooling Encouragement:**
    *   Encourage developers to leverage compiler feedback and static analysis tools as part of their development and refactoring workflow.