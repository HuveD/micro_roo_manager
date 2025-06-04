# TDD Test Selection Guidelines

This document outlines key principles for selecting and designing tests within a Test-Driven Development (TDD) approach, focusing on maximizing value and maintainability.

## I. Tests to Prioritize for Creation (High-Value Tests)

Focus design efforts on tests that validate:

1.  **Core Business Logic Flows:** Critical paths and algorithms that define the application's primary purpose (e.g., calculation engines, state transitions).
2.  **Payment/Transaction Processing:** Any logic involving financial transactions, order processing, or sensitive data exchange.
3.  **Security and Authentication/Authorization Validation:** Mechanisms protecting access, verifying identities, and enforcing permissions.
4.  **Error Handling and Recovery Paths:** How the system behaves under failure conditions and its ability to recover gracefully.
5.  **Asynchronous Operations and Concurrency:** Behavior of background tasks, message queues, and concurrent data access.
6.  **Data Integrity Checks:** Validation of data consistency, constraints, and transformations.
7.  **Key Integration Points Between Critical Modules:** Interactions and contracts between essential components of the system.
8.  **Refactor-Simplified Logic:** Tests for critical logic that becomes straightforward to validate *after* production code has been refactored specifically to improve its testability.

## II. Tests to Avoid, De-prioritize, or Remove (Anti-Patterns & Low-Value Tests)

Actively avoid creating, and consider removing, tests that exhibit one or more of the following characteristics. For removal during test suite hygiene, consider tests meeting two or more of these.

### A. General Anti-Patterns & Low-Value Characteristics

1.  **No Clear Business Value:**
    *   Tests for trivial getters and setters that perform no validation or logic.
    *   Tests for code that is demonstrably unused or dead.
2.  **Over-Mocked or Brittle Tests:**
    *   Unit tests where mock/stub setup constitutes significantly more than 70% of the test's code, or where mocks obscure the actual logic being tested.
    *   Tests that primarily verify the behavior of the mocking framework itself or third-party library internals, rather than application logic.
    *   Tests that are highly likely to break due to minor, unrelated changes in the production code (high coupling to implementation details).
3.  **Redundant or Duplicate Coverage:**
    *   Multiple tests verifying the exact same input-output behavior or logic path.
    *   Fine-grained unit tests for edge cases that are already adequately covered by more comprehensive integration tests or higher-level component tests.
4.  **Placeholder or Unimplemented Tests:**
    *   Conceptual tests ("TODO: Test X") that lack concrete assertions or verification steps.
    *   Test stubs or empty test methods that remain unimplemented for an extended period (e.g., >48 hours).
5.  **Superficial UI or Presentation Layer Tests (in the context of unit/integration TDD):**
    *   Unit tests for design tokens (e.g., color values, font sizes) unless they drive conditional logic.
    *   Unit tests for static UI properties of widgets that don't involve dynamic behavior or application logic.
6.  **Simple Data Transfer Object (DTO) Validation:**
    *   Tests that only confirm data can be set and retrieved from DTOs without any transformation or validation logic within the DTO itself. (Consider schema validation or contract testing at a different level if needed).
7.  **Third-Party Library Internal Verification:**
    *   Tests that re-verify the documented functionality of well-established third-party libraries. Focus on testing the *integration* with these libraries, not the libraries themselves.
8.  **Over-Specified Implementation Details:**
    *   Tests that are tightly coupled to the specific internal implementation of a method, rather than its observable behavior or contract.
9.  **Platform-Specific Behavior Tests (unless core to cross-platform logic):**
    *   Tests that verify behavior specific to a particular operating system or browser if that behavior is not part of the application's core, portable logic.
10. **Tests Solely for Quota:**
    *   Tests created *only* to meet an arbitrary test coverage percentage without adding significant validation value or confidence in the system's correctness.
11. **Excessively Complex Unit Tests Due to Poor Code Design (Pre-Refactoring):**
    *   Unit tests that are extremely difficult to write or maintain due to issues in the underlying production code design (e.g., God objects, tight coupling, lack of seams for testing), *before* an attempt has been made to refactor the production code for testability.

### B. Specific Exclusions from TDD Scope

1.  **Performance Tests:**
    *   Do not design or include performance tests (e.g., load tests, stress tests, benchmark tests) as part of the unit/integration TDD cycle. These are distinct activities requiring different tools and methodologies.
2.  **Test Environment Conditionals in Production Code:**
    *   Do not write tests that necessitate or encourage the addition of conditional logic (e.g., `if (isTestEnvironment)`) within the *production codebase*. Such conditionals are a sign of flawed test design or production code that is not inherently testable. If found, these conditionals should be targeted for removal by refactoring the production code and/or the test approach.