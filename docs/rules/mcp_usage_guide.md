# MCP Tools: Core Usage Rules

## 1. Available MCP Tools & Primary Use Cases

This guide outlines the available MCP tools. You MUST select the most appropriate tool for the user's query to ensure accuracy and relevance.

### 1.1. `context7`
-   **Purpose**: To retrieve highly accurate, version-specific technical information and code. It is the primary source for software-related queries.
-   **When to Use**:
    -   Queries about software libraries, APIs, SDKs, or frameworks.
    -   Requests for code examples, debugging help, or version compatibility.
    -   Validating technical specifications or function signatures.
-   **Note**: Usage is often **MANDATORY** for technical queries to prevent outdated or incorrect information.

### 1.2. `perplexity`
-   **Purpose**: To access real-time, general information from the web with verifiable sources.
-   **When to Use**:
    -   Queries about current events, news, or recent trends.
    -   Requests for general knowledge or facts that may be outside the internal knowledge base.
    -   When a user asks for information that requires web-based verification and source citation.

### 1.3. `firecrawl`
-   **Purpose**: To extract and structure detailed content from specific web pages or URLs.
-   **When to Use**:
    -   When a user provides a specific URL and asks for a summary, analysis, or data extraction.
    -   When information from a general search (`perplexity`) is insufficient and you need the full content of a specific page (e.g., an article, a product page, documentation).
    -   To convert a webpage's content into clean, LLM-friendly Markdown.

## 2. Quick-Reference Examples

### 2.1. `context7` Example
-   **User Query**: "How do I create a pandas DataFrame from a dictionary in pandas version 2.1?"
-   **Action**: Use `context7` to get the precise, version-correct code example.

### 2.2. `perplexity` Example
-   **User Query**: "What are the latest developments in generative AI in the last month?"
-   **Action**: Use `perplexity` to search the web for recent news and articles, providing a synthesized answer with sources.

### 2.3. `firecrawl` Example
-   **User Query**: "Can you summarize the main points from this article: https://example.com/news/long-article"
-   **Action**: Use `firecrawl` to scrape the content of the URL and then generate a summary.
    ```json
    {
      "name": "firecrawl_scrape",
      "arguments": {
        "url": "https://example.com/news/long-article",
        "formats": ["markdown"],
        "onlyMainContent": true
      }
    }
    ```