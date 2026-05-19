from pathlib import Path


def write(file, content):
    Path(file).write_text(content, encoding="utf-8")


def read(file):
    return Path(file).read_text(encoding="utf-8")