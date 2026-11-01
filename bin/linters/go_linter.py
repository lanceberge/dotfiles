#!/usr/bin/env python3
"""Run Go lint tools concurrently and print their reports in a stable order."""

from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import subprocess
import sys
import tempfile


ROOT = Path.cwd()
IGNORE = r"_test\.go|/vendor/|/testdata/"


def command(args, cwd=ROOT):
    try:
        result = subprocess.run(args, cwd=cwd, text=True, stdout=subprocess.PIPE,
                                stderr=subprocess.STDOUT, check=False)
        return result.returncode, result.stdout
    except OSError as error:
        return 127, f"{args[0]}: {error}\n"


def source_files():
    return sorted(path for path in ROOT.rglob("*.go")
                  if not path.name.endswith("_test.go")
                  and not any(part in {"vendor", "testdata", ".git", ".jj"}
                              for part in path.relative_to(ROOT).parts))


def halstead():
    outputs = []
    status = 0
    for path in source_files():
        code, output = command(["halstead", str(path.relative_to(ROOT))])
        outputs.append(f"{path.relative_to(ROOT)}\n{output}")
        status = max(status, code)
    return status, "\n".join(outputs) or "No Go source files.\n"


def lines():
    files = [str(path.relative_to(ROOT)) for path in source_files()]
    return command(["wc", "-l", *files]) if files else (0, "No Go source files.\n")


def coverage():
    with tempfile.TemporaryDirectory(prefix="pr-lint-coverage-") as directory:
        profile = str(Path(directory) / "coverage.out")
        code, output = command(["go", "test", "-coverpkg=./...",
                                f"-coverprofile={profile}", "./..."])
        if code == 0:
            detail_code, detail = command(["go", "tool", "cover", f"-func={profile}"])
            return detail_code, output + detail
        return code, output


def main():
    if not (ROOT / "go.mod").is_file():
        print("pr_lint: run from a Go module root", file=sys.stderr)
        return 2

    jobs = [
        ("Cyclomatic complexity (< 22)", lambda: command(["gocyclo", "-ignore", IGNORE, "."])),
        ("Cognitive complexity (< 22)", lambda: command(["gocognit", "-ignore", IGNORE, "."])),
        ("Halstead difficulty (< 80)", halstead),
        ("Lines per Go file (< 500)", lines),
        ("Test coverage (100% statements)", coverage),
        ("CRAP (< 25)", lambda: command(["go-crap", "scan", "--threshold", "25"])),
        ("Surviving mutants (0)", lambda: command(["gremlins", "unleash", "--workers", "1"])),
        ("Dead and redundant code (0)", lambda: command([
            "golangci-lint", "run", "--enable-only",
            "unused,ineffassign,unparam,govet,dupl", "--tests=false", "./..."
        ])),
    ]
    with ThreadPoolExecutor(max_workers=len(jobs)) as pool:
        results = list(pool.map(lambda job: job[1](), jobs))

    for (label, _), (code, output) in zip(jobs, results):
        print(f"\n== {label} ==")
        print(output, end="" if output.endswith("\n") else "\n")
        if code:
            print(f"exit status: {code}")
    return 1 if any(code for code, _ in results) else 0


if __name__ == "__main__":
    sys.exit(main())
