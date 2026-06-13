# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Clawdeck CLI is a Python CLI tool (v0.5.3) that provides an AI-powered coding assistant using multiple LLM providers. Built with Click (CLI framework) and pydantic-ai (AI agent framework). Requires Python >=3.10,<4.0. Published on PyPI as `clawdeck`.

## Build & Development Commands

```bash
# Install dependencies (creates venv, installs all deps, editable mode)
poetry install

# Run the CLI
poetry run clawdeck

# Run all tests (CLAWDECK_SKIP_CONFIRM=1 suppresses command confirmation prompts)
CLAWDECK_SKIP_CONFIRM=1 poetry run pytest tests/ -v

# Run a single test file
poetry run pytest tests/test_agent.py -v

# Run a specific test class or method
poetry run pytest tests/test_utils.py::TestExecuteCommandSafe -v

# Run with coverage
poetry run pytest tests/ --cov=clawdeck --cov-report=html

# Build package
poetry build
```

## Architecture

### Entry Flow
`clawdeck` CLI entry point -> `clawdeck/cli.py:main()` (Click) -> loads config -> initializes `ClawdeckAgent` -> runs async chat loop with slash command handling.

### Core Modules (`clawdeck/`)
- **`cli.py`** - Click CLI definition, async chat loop, and the large slash-command dispatcher. Slash commands cover many subsystems (e.g. `/clear`, `/history`, `/save`, `/load`, `/tokens`, `/model`, `/config`, `/memory`, `/plan`, `/skills`, `/plugins`, `/hooks`, `/cron`, `/rewind`, `/buddy`, `/budget`, `/workers`, `/vision`, `/github`, `/pdf`, `/word`). Provider/model shortcuts: `/opus`, `/sonnet`, `/switch`, `/apikey`, `/aistudio`
- **`agent.py`** - `ClawdeckAgent` class using pydantic-ai. Routes to providers via `_get_client_choice()`: 1=Anthropic, 2=Bedrock, 3=Gemini, 4=OpenAI
- **`config.py`** - Three-tier config system: user (`~/.clawdeck/config.yaml`) < project (`.clawdeck.yaml`) < env vars (`CLAWDECK_*`). Merges into `ClawdeckConfig` dataclass
- **`utils.py`** - File operations, code parsing, safe command execution, performance metrics
- **`document_readers.py`** - Multi-format document processing (Excel/Word/PDF) with OCR, chunking, and embedding support
- **`browser_use.py`** / **`browser_controller.py`** - Website fetching with caching, Playwright-based browser automation
- **`session_manager.py`** - Conversation history persistence (JSON)
- **`credential_manager.py`** - Encrypted token storage for GitHub/HuggingFace
- **`vision_engine.py`** - Claude Vision API for image analysis

### Agent Subsystems (`clawdeck/`)
These extend the agent beyond the core chat loop; most are surfaced via slash commands and tested in `tests/test_<name>.py`:
- **`memory.py`** - Persistent cross-session memory in `~/.clawdeck/memory/` with `MEMORY.md` as index and relevance-based recall
- **`dream.py`** - Background memory consolidation that reviews recent sessions
- **`compaction.py`** - Auto-summarizes old messages when the context window fills
- **`token_budget.py`** - Per-turn token budgeting; auto-continues when the model hits `max_tokens`, with diminishing-returns detection
- **`planner.py`** - Plan mode: produces a step-by-step plan for user approval before execution
- **`subagent.py`** - Spawns parallel pydantic-ai worker agents for research/implementation
- **`skills.py`** - User-extensible slash commands loaded from YAML files
- **`plugin_system.py`** - User-installable plugins (Python packages or single-file modules)
- **`hooks.py`** - Pre/post-response hooks for validation and custom processing (registered via `hook_manager.register_builtin_hooks()`)
- **`cron_agent.py`** - Schedules agents to run on recurring intervals
- **`rewind.py`** - Conversation snapshots for undo/revert to prior states
- **`lsp_client.py`** - LSP integration (pyright, ruff, etc.) for diagnostics
- **`buddy.py`** / **`voice.py`** / **`vim_mode.py`** - Companion UI, speech-to-text input, and vi-style input keybindings

### Browser Tools (`clawdeck/tools/browser/`)
Modular browser automation subsystem with DOM analysis, screenshot-based fallback via Claude Vision, Stagehand integration, sandboxed Python execution, and intelligent error recovery. The orchestrator (`automation_orchestrator.py`, plus `enhanced_automation_orchestrator.py`) selects between DOM-first and screenshot approaches.

### Tool Registration Pattern
Tools are registered by passing bound methods of `ClawdeckAgent` in the `tools=[...]` list of the pydantic-ai `Agent` constructor (see `agent.py` around the `tools_list` assignment), **not** via an `@agent.tool` decorator. Provider quirks are handled when building this list: Bedrock does not support `builtin_tools`, and Gemini / OpenAI (ResponsesModel) cannot mix `builtin_tools` (like `WebSearchTool`) with custom tools. When changing the model at runtime, the agent is fully recreated with a fresh `tools=[...]` list.

## Configuration

Provider selection is interactive (prompted at startup) or set via environment:
- `ANTHROPIC_API_KEY` - Direct Anthropic API
- `AWS_ACCESS_KEY_ID` + `AWS_SECRET_ACCESS_KEY` + `AWS_DEFAULT_REGION` - AWS Bedrock
- `GOOGLE_API_KEY` - Google Gemini
- `OPENAI_API_KEY` - OpenAI

## Documentation

The docs "book" is a single Docusaurus site in `docusaurus-docs/` (Docusaurus + Node.js, deployed via `.github/workflows/deploy-docusaurus.yml`). The legacy MkDocs system (`docs/` + `mkdocs.yml`) was removed in the Clawdeck rebrand.

Version is tracked in both `pyproject.toml` and `clawdeck/__init__.py`.
