---
name: code-quality
description: Detect and enforce project formatting and linting conventions for all code changes
---

## Purpose

Ensure all code produced by agents adheres to the project's formatting and linting standards. This skill provides the procedure for detecting available tools and applying them.

## When to Use

Use this skill after writing or modifying code, before presenting work for review or committing.

## Procedure

### 1. Detect Project Tools

Check for the presence of configuration files and tools in the project:

**Formatters** (check in order):
- `prettier` — look for `.prettierrc`, `.prettierrc.*`, `prettier.config.*`, or `"prettier"` in `package.json`
- `black` — look for `pyproject.toml` with `[tool.black]`, or `.black.cfg`
- `rustfmt` — look for `rustfmt.toml` or `.rustfmt.toml`
- `gofmt`/`goimports` — present if Go project (has `go.mod`)
- `stylua` — look for `.stylua.toml` or `stylua.toml`
- `shfmt` — available for shell scripts
- `clang-format` — look for `.clang-format`
- Check `package.json` scripts for a `format` script
- Check `Makefile` for a `format` or `fmt` target

**Linters** (check in order):
- `eslint` — look for `.eslintrc`, `.eslintrc.*`, `eslint.config.*`, or `"eslintConfig"` in `package.json`
- `ruff` — look for `pyproject.toml` with `[tool.ruff]`, or `ruff.toml`
- `clippy` — present if Rust project (has `Cargo.toml`)
- `golangci-lint` — look for `.golangci.yml` or `.golangci.yaml`
- `selene` — look for `selene.toml`
- `shellcheck` — available for shell scripts
- Check `package.json` scripts for a `lint` script
- Check `Makefile` for a `lint` or `check` target

**Type checkers**:
- `tsc` — look for `tsconfig.json`
- `mypy` — look for `mypy.ini` or `[tool.mypy]` in `pyproject.toml`
- `pyright` — look for `pyrightconfig.json` or `[tool.pyright]` in `pyproject.toml`

### 2. Apply Formatting

Run the detected formatter on all modified files:

```
# Examples — use whatever the project has configured
npx prettier --write <files>
black <files>
stylua <files>
gofmt -w <files>
```

If the project has a `format` script in `package.json` or Makefile, prefer using that over running the tool directly, as it may include project-specific flags.

### 3. Run Linting

Run the detected linter on all modified files:

```
# Examples
npx eslint --fix <files>
ruff check --fix <files>
```

- Use `--fix` or auto-fix flags when available
- For issues that cannot be auto-fixed, fix them manually
- If a lint rule seems wrong or overly strict, note it but still comply. Ask the user only if compliance would require a significant design change.

### 4. Run Type Checking

If a type checker is configured:

```
# Examples
npx tsc --noEmit
mypy <files>
```

- Fix any type errors introduced by the changes
- Do NOT modify existing type errors unrelated to the current changes

### 5. Verify

After all tools have run:
- Confirm no formatting diff remains: the formatter should be idempotent
- Confirm no lint errors remain on the modified files
- Confirm no new type errors

## Rules

- NEVER disable lint rules inline (`// eslint-disable`, `# noqa`, etc.) without explicit user approval
- NEVER modify formatter/linter configuration files
- If a formatter or linter is not available but the project clearly uses one (config file exists, tool not installed), inform the user and ask how to proceed
- When multiple formatters could apply to a file type, use the one the project has configured
- Format and lint ONLY the files you modified, not the entire codebase (unless the project's format script does that by design)
