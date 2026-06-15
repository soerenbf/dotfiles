# AGENTS.md

## SWE
- Parse, don't validate.
- Keep it simple.
- Prefer "write everything twice" over premature DRY; introduce abstractions when they are clearly necessary.
- Add docstrings to everything public.
- For public functions, document arguments, error cases (if any), and minimal code example(s) that show how to use them.
- Use inline comments sparingly to explain non-obvious algorithms or tricky implementation details.
- Keep token usage minimal by default: prefer targeted searches and project-appropriate tools before reading large files or running broader commands; when possible, filter command output first (for example by piping into `rg`) to inspect only the relevant results.
- Adhere to best practices.
- Prioritize maintainability, performance, and security.

### Git
- Only perform read-only Git commands.
- Never run write operations such as `commit`, `push`, `pull`, `merge`, `rebase`, `cherry-pick`, `stash`, `tag`, `reset`, `checkout -b`, or anything else that changes Git state.
- If a Git write action is needed, stop and ask the user to do it.

### Rust
- Use `cargo` as the standard interface.
- Prefer the tools and commands already available in the current project directory.
- Use standard cargo workflows when applicable, such as `cargo fmt`, `cargo clippy`, and `cargo test`.
- Tool filter examples: 
  - `cargo test 2>&1 | rg "test result|error|fail"`
  - `cargo fmt --check 2>&1 | rg "error|diff|warning"`
  - `cargo clippy --all-targets --all-features 2>&1 | rg "error(\[|:)|warning"`
  - `cargo build 2>&1 | rg "error(\[|:)|warning"`
- Avoid `unwrap()` and `expect()` outside tests as a rule; prefer proper error handling and propagation.

### Haskell
- Use `stack`.
- Use `fourmolu` for formatting.
- Prefer explicit type signatures by default.
- Tool filter examples:
  - `stack test 2>&1 | rg "Error|FAIL|failures|test suite"`
  - `fourmolu --mode check $(rg --files -g '*.hs') 2>&1 | rg "would reformat|error"`
  - `stack build 2>&1 | rg "Error|warning|Failed"`
- Follow existing project conventions where they are more specific.

### TypeScript
- Use the package manager already defined by the project; stay package-manager neutral otherwise.
- Prefer strict TypeScript.
- Prefer Prettier and ESLint unless the project specifies otherwise.
- Tool filter examples:
  - `npm test -- --runInBand 2>&1 | rg "FAIL|PASS|Error|Test Suites"`
  - `prettier . --check 2>&1 | rg "Checking formatting|\[warn\]|\[error\]"`
  - `tsc --noEmit 2>&1 | rg "error TS|warning"`
- Follow existing project scripts and conventions when present.
