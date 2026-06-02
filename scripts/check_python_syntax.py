from __future__ import annotations

import ast
from pathlib import Path


def main() -> None:
    root = Path(__file__).resolve().parent.parent
    python_files = sorted((root / "server").rglob("*.py"))

    for file_path in python_files:
        source = file_path.read_text(encoding="utf-8")
        ast.parse(source, filename=str(file_path))
        print(f"OK {file_path.relative_to(root)}")


if __name__ == "__main__":
    main()
