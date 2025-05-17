# MCP Usage Guide

## 0. Core Principles for MCP Usage
*   **Accuracy First:** Prioritize MCP tools when internal knowledge may be outdated, incomplete, or less reliable.
*   **Relevance is Key:** Select the MCP tool most appropriate for the type of information or capability required.
*   **Efficiency:** Use MCPs to enhance response quality and provide information that would be difficult or impossible to generate otherwise.

## 1. When to Use MCP Tools: Quick Decision Guide

*   **For technical/code queries (libraries, APIs, SDKs, code examples, version-specific details):**
    *   **Primary Tool:** `context7` (often mandatory).
*   **For real-time web information (news, trends, current events, sourced facts):**
    *   **Primary Tool:** `perplexity`.
*   **For maintaining conversational context, personalization, and remembering user-specific information across interactions:**
    *   **Supporting Tool:** `mem0` (used in conjunction with other tools or general response generation).
*   **If internal knowledge is suspect for any query:**
    *   Consider `context7` for technical knowledge gaps.
    *   Consider `perplexity` for general/web knowledge gaps.

## 2. MCP Tool Usage Priority

1.  **`context7` (Highest Priority for Technical/Code Queries):**
    *   **Purpose:** Provides version-specific, accurate technical documentation and code.
    *   **When:** Queries related to software libraries, APIs, SDKs, specific versions, and code examples. Its use is often **mandatory**.

2.  **`perplexity` (Priority for Real-Time & Sourced Web Information):**
    *   **Purpose:** Accesses and synthesizes real-time web information with sources.
    *   **When:** Queries requiring current events, latest information, trends, or facts needing web verification, where `context7` is not applicable.

3.  **`mem0` (Contextual & Personalization Layer):**
    *   **Purpose:** Enables stateful, context-aware interactions by remembering prior user interactions.
    *   **When:** Need to maintain conversational context, recall user preferences, or personalize responses. Supports other tools and general conversation; not a primary information retrieval tool like `context7` or `perplexity`.

---

## 3. `context7` MCP: Accurate Technical Information

### 3.1. Core Objective
To ensure the generation of **accurate, up-to-date, and version-specific information** for software libraries, APIs, frameworks, SDKs, and code examples.

### 3.2. When to Use `context7`
You **MUST** use `context7` for queries demanding **accurate, up-to-date, and version-specific technical information**, including:
*   Details about software libraries, frameworks, APIs, or SDKs.
*   Version-specific information or requirements.
*   Generation, validation, or troubleshooting of code examples.
*   Confirmation of technical details to avoid errors or outdated practices.

### 3.3. Absolute Imperative for `context7`
Usage of `context7` for queries about software libraries, APIs, or code is **MANDATORY** to ensure correct, current, and reliable technical information.

---

## 4. `perplexity` MCP: Real-Time Web Search & Sourced Information

### 4.1. Core Objective
To provide access to **real-time, up-to-date information from the web, with verifiable sources**, for queries where currency and external validation are paramount and `context7` is not applicable.

### 4.2. When to Use `perplexity`
You **SHOULD** use `perplexity` when the query requires:
*   Current events, news, or rapidly changing information (e.g., market trends, latest scientific developments).
*   Factual information needing web verification and source citation.
*   Broad general knowledge where internal data may be outdated or insufficient, and `context7` is not relevant.

---

## 5. `mem0` MCP: Contextual Memory & Personalization

### 5.1. Core Objective
To enable **stateful, context-aware, and personalized interactions** by allowing the AI to remember and recall information from current or previous interactions.

### 5.2. When to Utilize `mem0`
Utilize `mem0` to:
*   Maintain conversational context and coherence across multiple turns.
*   Remember and recall user preferences or key information stated by the user.
*   Personalize responses and avoid asking for previously provided information.
*   Support multi-turn task completion by tracking gathered details.