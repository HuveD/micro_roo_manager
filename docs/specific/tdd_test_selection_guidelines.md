# Enhanced TDD Test Selection & Management Guidelines

This document outlines key principles for selecting, designing, and managing tests within a Test-Driven Development (TDD) approach, focusing on maximizing value, maintainability, and resource optimization.

---

## I. Tests to Prioritize for Creation (High-Value Tests)

Focus design and creation efforts on tests that validate:

1.  **Core Business Logic Flows:**
    *   **Definition:** Functions essential for delivering the application's core value, or where a single failure has a critical business impact. Prioritize tests for features directly linked to user stories that provide tangible user value (e.g., core calculation engines, critical state transitions directly impacting user outcomes).
2.  **(Elevated Priority) Refactor for Testability First, Then Test:**
    *   **Guideline:** For complex production code, prioritize refactoring to simplify logic and improve testability *before* writing tests. Tests for this refactored, critical logic are high-value, as they validate core functionality that is now easier and more reliably tested. This significantly reduces long-term test creation and maintenance costs.
3.  **Payment/Transaction Processing:** Any logic involving financial transactions, order processing, or sensitive data exchange.
4.  **Security and Authentication/Authorization Validation:** Mechanisms protecting access, verifying identities, and enforcing permissions.
5.  **Error Handling and Recovery Paths:** How the system behaves under failure conditions and its ability to recover gracefully.
6.  **Asynchronous Operations and Concurrency:** Behavior of background tasks, message queues, and concurrent data access.
7.  **Data Integrity Checks:** Validation of data consistency, constraints, and transformations.
8.  **Key Integration Points Between Critical Modules:** Interactions and contracts between essential components of the system, ensuring they work together as expected.

---

## II. Tests to Avoid, De-prioritize, or Remove (Anti-Patterns & Low-Value Tests)

Actively avoid creating these tests. For removal during test suite hygiene:
*   **Immediate Removal Candidate:** Tests exhibiting characteristics marked with `[IMMEDIATE REMOVAL]` should be removed promptly.
*   **Strong Removal Candidate:** Tests meeting one or more other characteristics listed below, especially if they also lack clear, ongoing business value or violate test layering principles.

### A. General Anti-Patterns & Low-Value Characteristics

1.  **No Clear Business Value `[IMMEDIATE REMOVAL]`:**
    *   Tests for trivial getters and setters that perform no validation or logic.
    *   Tests for code that is demonstrably unused or dead.
2.  **Over-Mocked or Brittle Tests:**
    *   Unit tests where mock/stub setup constitutes significantly more than ~70% of the test's code, or where mocks obscure the actual logic being tested.
        *   **Guidance:** If mocking exceeds this threshold, it's often a signal to refactor the production code for better cohesion, reduced coupling, or simpler interfaces to improve testability. Consider if the unit under test has too many responsibilities.
    *   Tests that primarily verify the behavior of the mocking framework itself or third-party library internals, rather than application logic.
    *   Tests that are highly likely to break due to minor, unrelated changes in the production code (high coupling to implementation details).
3.  **Redundant or Duplicate Coverage:**
    *   Multiple tests verifying the exact same input-output behavior or logic path.
    *   Fine-grained unit tests for edge cases that are already adequately covered by more comprehensive integration tests or higher-level component tests.
    *   **Guidance:** Adhere to a clear test layering strategy (e.g., Test Pyramid, Test Trophy). Unit tests should focus on isolated logic, integration tests on module interactions, and End-to-End (E2E) tests on user scenarios, minimizing overlap and ensuring each layer has distinct responsibilities.
4.  **Placeholder or Unimplemented Tests `[IMMEDIATE REMOVAL]`:**
    *   Conceptual tests ("TODO: Test X") that lack concrete assertions or verification steps.
    *   Test stubs or empty test methods. These should be implemented immediately upon creation or removed. Do not commit placeholder tests.
5.  **Superficial UI or Presentation Layer Tests (in the context of unit/integration TDD):**
    *   Unit tests for design tokens (e.g., color values, font sizes) unless they drive conditional logic.
    *   Unit tests for static UI properties of widgets that don't involve dynamic behavior or application logic.
    *   **Guidance:** Focus UI unit/integration tests on dynamic behavior or application logic within UI components. For static elements or styles, consider visual regression testing or manual QA as more appropriate validation methods.
6.  **Simple Data Transfer Object (DTO) / Schema Validation:**
    *   Tests that only confirm data can be set and retrieved from DTOs without any transformation or validation logic within the DTO itself.
    *   **Guidance:** Validate DTO structure/schema using dedicated schema validation tools (e.g., JSON Schema) or at the API gateway level. Focus business logic tests on how DTOs are *used* correctly within the application logic, not just their data-holding capabilities.
7.  **Third-Party Library Internal Verification:**
    *   Tests that re-verify the documented functionality of well-established third-party libraries. Focus on testing the *integration* with these libraries (i.e., that your code uses them correctly), not the libraries themselves.
8.  **Over-Specified Implementation Details:**
    *   Tests that are tightly coupled to the specific internal implementation of a method, rather than its observable behavior or contract. These tests are brittle and hinder refactoring.
9.  **Platform-Specific Behavior Tests (unless core to cross-platform logic):**
    *   Tests that verify behavior specific to a particular operating system or browser if that behavior is not part of the application's core, portable logic.
10. **Tests Solely for Quota `[IMMEDIATE REMOVAL]`:**
    *   Tests created *only* to meet an arbitrary test coverage percentage without adding significant validation value or confidence in the system's correctness. These provide false confidence, waste resources, and are immediate removal candidates.
11. **Excessively Complex Unit Tests Due to Poor Code Design (Pre-Refactoring):**
    *   Unit tests that are extremely difficult to write or maintain due to issues in the underlying production code design (e.g., God objects, tight coupling, lack of seams for testing), *before* an attempt has been made to refactor the production code for testability (see Section I.2).

---

## III. Test Suite Management & Optimization

Beyond individual test selection, effective management of the entire test suite is crucial for resource optimization and maintaining TDD benefits.

### 1. Test File Structure & Location Convention
This is a foundational rule for maintaining a clean and predictable codebase.

*   **Primary Rule: Consistency**
    *   **IF** an existing test file structure convention is present in the project:
    *   **THEN** all new test files **MUST** strictly adhere to that established convention.
    *   **Example:** If all existing tests are located in a root `/tests` directory, all new tests must also be created there.

*   **Fallback Rule: Best Practices**
    *   **IF** no established test convention exists (e.g., a new project):
    *   **THEN** implement the standard, idiomatic convention for the project's primary language and testing framework.
    *   **Examples:**
        *   **Java (Maven/Gradle):** `src/test/java/...`
        *   **Python (pytest):** A parallel `/tests` directory (`/src`, `/tests`).
        *   **JavaScript (Jest):** A `/__tests__/` subdirectory or `.test.js`/`.spec.js` files adjacent to source files.
        *   **Go:** `_test.go` files in the same package/directory as the source code.

*   **Prohibition**
    *   **DO NOT** introduce a new or conflicting test file structure if one already exists. The goal is absolute consistency. Avoid creating tests in multiple locations (e.g., some in `/src` and some in `/tests`).

### 2. Test Data Management Strategy
Develop a clear strategy for managing test data to ensure consistency, isolation, and efficiency:
*   **Reusability & Isolation:** Design test data to be reusable where appropriate, but ensure tests are isolated to prevent interdependencies and flaky results.
*   **Realistic Data:** Use data that reflects production scenarios (anonymized and desensitized if originating from production) without using actual sensitive production data in test environments.
*   **Efficient Setup & Teardown:** Implement efficient data setup and teardown mechanisms (e.g., transactional fixtures, in-memory databases reset per test/suite, data factories).
*   **Minimize Test Data Footprint:** Keep test data concise and focused on the specific scenario being tested.

### 3. Test Execution Speed Optimization
Continuously monitor and optimize test execution speed to maintain developer productivity and enable rapid feedback loops:
*   **Minimize I/O:** Avoid unnecessary disk or network I/O in unit and integration tests. Favor in-memory fakes or stubs.
*   **In-Memory Alternatives:** Utilize in-memory databases or lightweight service fakes for faster execution where appropriate, especially for unit and component integration tests.
*   **Parallelization:** Explore and leverage parallel test execution capabilities of your test runner and CI/CD pipeline.
*   **Identify Bottlenecks:** Regularly profile test runs to identify and address slow-running tests. These might be candidates for refactoring or re-evaluation of their value versus cost.

### 4. Periodic Test Suite Hygiene
Establish a regular, proactive process for test suite hygiene to maintain its value, relevance, and efficiency:
*   **Scheduled Reviews:** Periodically review the entire test suite (e.g., quarterly, bi-annually, or triggered by significant refactoring efforts) with the team.
*   **Refactor & Remove:** Actively refactor brittle, unclear, or overly complex tests. Remove tests that no longer provide value based on the criteria in Section II.
*   **Team Responsibility:** Make test suite health and maintenance a collective team responsibility, not an afterthought. Integrate hygiene activities into regular team processes (e.g., sprint planning, retrospectives).

---

## IV. Specific Exclusions from TDD Scope

The following test types are generally outside the scope of the typical unit/integration TDD cycle and require different approaches:

1.  **Performance Tests:**
    *   Do not design or include performance tests (e.g., load tests, stress tests, benchmark tests) as part of the unit/integration TDD cycle. These are distinct activities requiring different tools, environments, and methodologies.
2.  **Test Environment Conditionals in Production Code:**
    *   Do not write tests that necessitate or encourage the addition of conditional logic (e.g., `if (isTestEnvironment)`) within the *production codebase*. Such conditionals are a strong indicator of flawed test design or production code that is not inherently testable. If found, these conditionals should be targeted for removal by refactoring the production code and/or the test approach.