---
name: trace
description: Interactively, in emacs, trace the a reqeusted code path
---

# Trace

When the user invokes this skill with code paths, walk them through the requested code path in Emacs

## Workflow

1. Inspect the requested files, symbols, functions, routes, stack trace entries, or directories.
2. Build a concise ordered path of source locations. Prefer the smallest set of locations that explains the flow.
3. For each location, include:
   - `:file`: absolute path, or a path resolvable from the current project root.
   - `:line`: 1-based starting line number.
   - `:mark`: optional 1-based ending line number when a region should be highlighted.
   - `:description`: one short sentence describing why this location matters.
4. Send the path to Emacs with `emacsclient --eval`, wrapping the trace call and Hyprland focus call in one `progn`.
5. After starting the trace, briefly tell the user what was loaded.

## Emacs Invocation

Evaluate:

```sh
emacsclient --eval "(progn (+agent-shell-trace '((:file \"/abs/path/abc/thing.el\" :line 95 :mark 97 :description \"Builds the prompt payload.\") (:file \"/abs/path/abc/thing2.el\" :line 10 :description \"Dispatches the request.\"))) (when (executable-find \"hyprctl\") (call-process \"hyprctl\" nil nil nil \"dispatch\" \"focuswindow\" \"class:Emacs\")))"
```

The `hyprctl` call is intentionally inside the evaluated Emacs expression so Claude and Codex can use a single `emacsclient --eval` command.

## Rules

- Use absolute paths when possible.
- If a target is a region, put point at the beginning and mark at the end by setting `:mark`.
- If a whole function is relevant, use its first line as `:line` and its last line as `:mark`.
- Keep descriptions short enough for the minibuffer.
- If `emacsclient` fails because no server is running, tell the user to start Emacs server mode with `(server-start)` or run Emacs as a daemon.

## Do Not

- Do not fabricate line numbers. Read the files first.
- Do not include every caller or helper. Trace the path needed to answer the user's request.
- Do not edit files unless the user explicitly asks for code changes.
