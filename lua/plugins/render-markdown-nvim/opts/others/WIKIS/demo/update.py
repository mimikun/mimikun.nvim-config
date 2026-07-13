import re
from pathlib import Path
from textwrap import indent

import run
import tree_sitter_lua
from tree_sitter import Language, Parser, Query, QueryCursor


def main() -> None:
    config_files: list[tuple[str, str, str]] = [
        ("bullet", "ListBullets.md", "list"),
        ("callout", "Callouts.md", "callout"),
        ("checkbox", "Checkboxes.md", "checkboxes"),
        ("code", "CodeBlocks.md", "code"),
        ("dash", "DashedLine.md", "dash"),
        ("heading", "Headings.md", "headings"),
        ("indent", "Indent.md", "indent"),
        ("latex", "Latex.md", "latex"),
        ("link", "Links.md", "link"),
        ("paragraph", "Paragraphs.md", "paragraphs"),
        ("pipe_table", "Tables.md", "table"),
        ("quote", "BlockQuotes.md", "quote"),
        ("sign", "Signs.md", "sign"),
    ]
    for name, file, group_name in config_files:
        group = run.get_group(group_name)
        update(name, Path(file), group)


def update(name: str, file: Path, group: run.Group) -> None:
    # add space before capital letters
    title = re.sub(r"([A-Z])", r" \1", file.stem).strip()
    lines: list[str] = [
        f"# {title}",
        "",
        "Raw data being used:",
        "",
        "````text",
        group.demo_path().read_text().strip(),
        "````",
        "",
    ]

    root = Path("../render-markdown.nvim")
    for config in group.configs:
        heading = " ".join(word.capitalize() for word in config.name.split("-"))
        section = [f"## {heading}", ""]

        if len(config.info) > 0:
            section.extend(config.info)
            section.append("")

        path = "/" + str(group.output_path(config.name))
        section.extend([f"[[{path}|{heading}]]", ""])

        lua = get_default(root, name) if config.name == "default" else config.lua({})
        lua = f"require('{root.stem}').setup({lua})"
        section.extend(["```lua", lua, "```", ""])

        lines.extend(section)

    text = "\n".join(lines)
    file.write_text(text)


def get_default(root: Path, name: str) -> str:
    file = root / "lua" / root.stem / "settings.lua"
    query = f"""
    (assignment_statement
        (variable_list
            name: (dot_index_expression
                table: (dot_index_expression
                    field: (identifier) @name1
                    (#eq? @name1 "{name}"))
                field: (identifier) @name2
                (#eq? @name2 "default")))
        (expression_list value: (table_constructor)) @value)
    """
    configs = ts_query(file, query, "value")
    assert len(configs) == 1
    config = configs[0]
    config = indent(f"{name} = {config}", "    ")
    config = f"{{\n{config},\n}}"
    return remove_comments(config)


def remove_comments(config: str) -> str:
    lines: list[str] = []
    for line in config.splitlines():
        if len(line) > 0 and "--" not in line:
            lines.append(line)
    return "\n".join(lines)


def ts_query(file: Path, query: str, target: str) -> list[str]:
    assert file.suffix == ".lua"
    tree_sitter_language = tree_sitter_lua

    language = Language(tree_sitter_language.language())
    tree = Parser(language).parse(file.read_text().encode())
    captures = QueryCursor(Query(language, query)).captures(tree.root_node)

    nodes = captures[target]
    nodes.sort(key=lambda node: node.start_byte)
    result: list[str] = []
    for node in nodes:
        text = node.text
        assert text is not None
        result.append(text.decode())
    return result


if __name__ == "__main__":
    main()
