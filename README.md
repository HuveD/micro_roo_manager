# Micro Roo Manager

> An AI-driven orchestration framework inspired by SPARC methodology and micro-responsibility principles

## Overview

Micro Roo Manager is an innovative project that combines the structured SPARC methodology with a micro-orchestration approach to transform AI-driven development workflows. This framework enables efficient task distribution based on the single responsibility principle, allowing teams to build modular, maintainable, and thoroughly tested applications.

The project draws inspiration from:
- [rUv-dev](https://github.com/ruvnet/rUv-dev) - SPARC methodology implementation
- [RooCodeMicroManager](https://github.com/adamwlarson/RooCodeMicroManager) - Micro orchestration concepts

## Quick Installation

> **Note:** This project requires `jq` (a lightweight JSON processor) for installation. The install script will attempt to install it automatically using Homebrew (macOS) or apt (Linux). If you are on a different OS, please install jq manually before running the script.
>
> **If you want to install jq manually:**
> - **macOS:**
>   ```bash
>   brew install jq
>   ```
> - **Ubuntu/Debian Linux:**
>   ```bash
>   sudo apt-get update && sudo apt-get install -y jq
>   ```
> - **Other OS:** See [https://stedolan.github.io/jq/download/](https://stedolan.github.io/jq/download/) for installation instructions.

```bash
curl -s https://raw.githubusercontent.com/HuveD/micro_roo_manager/main/install.sh | bash
```

- The script will check for `jq` and install it if not present.
- On macOS, Homebrew is required for automatic installation. If you don't have Homebrew, install it from <https://brew.sh>
- On Linux, `sudo apt-get` is used. For other distributions, please install jq manually.

## Core Principles

### Single Responsibility Orchestration

Micro Roo Manager breaks down complex development tasks into efficient, focused units. Each component has a clearly defined purpose, making the codebase more maintainable and easier to understand.

### Documentation-Driven Development

All development starts with comprehensive documentation and specifications. This approach ensures clear requirements and expectations before any code is written, reducing misunderstandings and rework.

### Test-Driven Development

Every component includes thorough test cases that validate functionality against specifications. This practice ensures reliability and makes continuous integration/continuous deployment more effective.

### AI-Driven Workflow

The framework establishes reliable AI-driven development flows where each step is guided by documentation, verified through testing, and orchestrated efficiently.

## Key Features

- **Structured Development Process**: Implementation of the SPARC methodology (Specification, Pseudocode, Architecture, Refinement, Completion)
- **Micro-Responsibility Focus**: Tasks are distributed in optimally sized units for efficiency
- **Continuous Documentation**: Ensures documentation remains current throughout development
- **Automated Testing**: Built-in test validation processes
- **Extensible Architecture**: Designed for sustainable project growth and adaptation

## Benefits

- Reduced development time through focused task distribution
- Improved code quality through rigorous testing
- Enhanced maintainability through clear documentation
- Scalable architecture that grows with project needs
- Consistent development practices across teams

## License

This project is open-source and freely available for anyone to use.

---

Built with ❤️ for the AI development community
