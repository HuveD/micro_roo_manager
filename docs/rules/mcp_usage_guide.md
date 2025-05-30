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
*   **For in-depth information from specific websites or structured content extraction:**
    *   **Primary Tool:** `firecrawl`.
*   **For maintaining conversational context, personalization, and remembering user-specific information across interactions:**
    *   **Supporting Tool:** `mem0` (used in conjunction with other tools or general response generation).
*   **If internal knowledge is suspect for any query:**
    *   Consider `context7` for technical knowledge gaps.
    *   Consider `perplexity` for general/web knowledge gaps.
    *   Consider `firecrawl` for accuracy/freshness gaps regarding specific website information.

## 2. MCP Tool Usage Priority

1.  **`context7` (Highest Priority for Technical/Code Queries):**
    *   **Purpose:** Provides version-specific, accurate technical documentation and code.
    *   **When:** Queries related to software libraries, APIs, SDKs, specific versions, and code examples. Its use is often **mandatory**.

2.  **`perplexity` (Priority for Real-Time & Sourced Web Information):**
    *   **Purpose:** Accesses and synthesizes real-time web information with sources.
    *   **When:** Queries requiring current events, latest information, trends, or facts needing web verification, where `context7` is not applicable and general web search is sufficient.

3.  **`firecrawl` (Priority for Targeted Web Content Extraction & Structuring):**
    *   **Purpose:** Directly extracts detailed or structured information from specific websites, providing it in an LLM-friendly format.
    *   **When:** General search results from `perplexity` are insufficient, and specific website content (full page, specific data patterns like product lists, comments) needs to be fetched, or a URL's content needs accurate Markdown conversion.

4.  **`mem0` (Contextual & Personalization Layer):**
    *   **Purpose:** Enables stateful, context-aware interactions by remembering prior user interactions.
    *   **When:** Need to maintain conversational context, recall user preferences, or personalize responses. Supports other tools and general conversation; not a primary information retrieval tool like `context7`, `perplexity`, or `firecrawl`.

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

## 5. `firecrawl` MCP: Targeted Web Content Extraction & Structuring

### 5.1. Core Objective
To directly extract detailed content from specific websites or URLs and transform it into structured data (e.g., Markdown) that an LLM can effectively analyze and utilize.

### 5.2. When to Use `firecrawl`
You **SHOULD** consider using `firecrawl` when:
*   Information deeper or more specific to a particular website is required than what `perplexity` (general web search) can provide.
*   Full text, specific HTML elements, or structured data needs to be extracted from one or more specific URLs (e.g., article bodies, product descriptions, lists of user comments).
*   A webpage needs to be converted into a clean, LLM-friendly Markdown format.
*   The latest information must be fetched from external documentation sites not managed internally (e.g., partner API documentation), especially when `context7` is not applicable (e.g., for non-code, general documentation).

### 5.3. Usage Example
```json
{
  "name": "firecrawl_scrape",
  "arguments": {
    "url": "https://example.com",
    "formats": ["markdown"],
    "onlyMainContent": true,
    "waitFor": 1000,
    "timeout": 30000,
    "mobile": false,
    "includeTags": ["article", "main"],
    "excludeTags": ["nav", "footer"],
    "skipTlsVerification": false
  }
}
```

---

## 6. `mem0` MCP: Contextual Memory & Personalization

### 6.1. Core Objective
To enable **stateful, context-aware, and personalized interactions** by allowing the AI to remember and recall information from current or previous interactions.

### 6.2. When to Utilize `mem0`
Utilize `mem0` to:
*   Maintain conversational context and coherence across multiple turns.
*   Remember and recall user preferences or key information stated by the user.
*   Personalize responses and avoid asking for previously provided information.
*   Support multi-turn task completion by tracking gathered details.
