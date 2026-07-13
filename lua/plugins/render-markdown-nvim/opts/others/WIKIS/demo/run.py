import argparse
import subprocess
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Literal


@dataclass(frozen=True)
class Conf:
    name: str
    value: dict[Any, Any]
    info: list[str] = field(default_factory=list)

    def lua(self, additional: dict[Any, Any]) -> str:
        config = additional | self.value
        return Conf.to_lua(config, 0)

    @staticmethod
    def to_lua(value: Any, indent: int) -> str:
        curr_indent = "    " * indent
        next_indent = "    " * (indent + 1)
        if isinstance(value, dict):
            if len(value) == 0:
                return "{}"
            items: list[str] = []
            for k, v in value.items():
                if isinstance(k, str):
                    k = (k,)
                item = Conf.to_lua(v, indent + 1)
                for i in range(len(k) - 1, -1, -1):
                    item = f"{k[i]} = {item}"
                    if i > 0:
                        item = "{ " + item + " }"
                items.append(f"{next_indent}{item}")
            return "{\n" + ",\n".join(items) + f",\n{curr_indent}}}"
        elif isinstance(value, list):
            items: list[str] = []
            for v in value:
                items.append(Conf.to_lua(v, indent))
            return "{ " + ", ".join(items) + " }"
        elif isinstance(value, str):
            return f"'{value}'"
        elif isinstance(value, bool):
            return "true" if value else "false"
        elif isinstance(value, (int, float)):
            return str(value)
        else:
            raise Exception(f"Unhandled type {type(value)}")


@dataclass(frozen=True)
class Group:
    name: str
    height: int
    configs: list[Conf]
    wait: int = 250
    width: int = 900
    variant: Literal["image", "gif"] = "image"
    general_config: dict[Any, Any] = field(default_factory=dict)

    def demo_path(self) -> Path:
        return Path(f"demo/_{self.name}.md")

    def output_path(self, name: str) -> Path:
        match self.variant:
            case "image":
                return Path(f"images/{self.name}/{name}.png")
            case "gif":
                return Path(f"media/{name}.gif")

    def run(self) -> None:
        for config in self.configs:
            self.demo(config.name, config.lua(self.general_config))

    def demo(self, name: str, config: str) -> None:
        output = self.output_path(name)

        directory = output.parent
        if not directory.exists():
            directory.mkdir()

        if output.exists():
            return

        minit, tape = Path("demo/minit.lua"), Path("demo/demo.tape")
        minit.write_text(self.minit_content(config))
        tape.write_text(self.tape_content())

        result = subprocess.run(["vhs", tape])
        assert result.returncode == 0

        image, gif = Path("temp.png"), Path("temp.gif")
        if self.variant == "image":
            image.rename(output)
        elif self.variant == "gif":
            gif.rename(output)

        for file in [minit, tape, image, gif]:
            if file.exists():
                file.unlink()

    def minit_content(self, config: str) -> str:
        content = Path("demo/minit.format.lua").read_text()
        content = content.replace("--CONFIG_HERE", config)
        return content

    def tape_content(self) -> str:
        content = Path(f"demo/{self.variant}.format.tape").read_text()
        content = content.replace("WIDTH", str(self.width))
        content = content.replace("HEIGHT", str(self.height))
        content = content.replace("WAIT", str(self.wait))
        content = content.replace("FILENAME", str(self.demo_path()))
        return content


def main(name: str) -> None:
    get_group(name).run()


def get_group(name: str) -> Group:
    groups: list[Group] = [
        main_group(),
        headings_group(),
        checkboxes_group(),
        code_group(),
        quote_group(),
        dash_group(),
        list_group(),
        callout_group(),
        table_group(),
        link_group(),
        paragraphs_group(),
        sign_group(),
        latex_group(),
        indent_group(),
    ]
    run_groups: list[Group] = []
    for group in groups:
        if group.name == name:
            run_groups.append(group)
    assert len(run_groups) == 1
    return run_groups[0]


def main_group() -> Group:
    return Group(
        name="main",
        width=900,
        height=1000,
        variant="gif",
        configs=[
            Conf("default", dict()),
            Conf("all", dict(render_modes=True)),
        ],
    )


def headings_group() -> Group:
    return Group(
        name="headings",
        height=500,
        configs=[
            Conf("default", dict(heading={})),
            Conf("no-sign", {("heading", "sign"): False}),
            Conf("inline", {("heading", "position"): "inline"}),
            Conf("icons", {("heading", "icons"): ["󰼏 ", "󰎨 "]}),
            Conf("block", dict(heading=dict(width="block", left_pad=2, right_pad=4))),
            Conf("block-min", dict(heading=dict(width="block", min_width=30))),
            Conf(
                "block-center",
                dict(
                    heading=dict(
                        sign=False,
                        position="inline",
                        width="block",
                        left_margin=0.5,
                        left_pad=0.2,
                        right_pad=0.2,
                    )
                ),
            ),
            Conf(
                "width-level",
                dict(
                    heading=dict(width=["full", "block", "full", "block"], min_width=30)
                ),
            ),
            Conf("border", {("heading", "border"): True}),
            Conf(
                "border-virtual",
                dict(heading=dict(border=True, border_virtual=True)),
            ),
        ],
    )


def checkboxes_group() -> Group:
    return Group(
        name="checkboxes",
        height=200,
        configs=[
            Conf("default", dict(checkbox={})),
            Conf(
                "icons",
                dict(
                    checkbox={
                        ("unchecked", "icon"): "✘ ",
                        ("checked", "icon"): "✔ ",
                        ("custom", "todo", "rendered"): "◯ ",
                    }
                ),
            ),
            Conf(
                "state",
                dict(
                    checkbox=dict(
                        custom=dict(
                            important=dict(
                                raw="[~]", rendered="󰓎 ", highlight="DiagnosticWarn"
                            )
                        )
                    )
                ),
            ),
            Conf(
                "scope",
                {("checkbox", "checked", "scope_highlight"): "@markup.strikethrough"},
            ),
        ],
    )


def code_group() -> Group:
    return Group(
        name="code",
        height=350,
        configs=[
            Conf("default", dict(code={})),
            Conf("no-sign", {("code", "sign"): False}),
            Conf(
                "language-tab",
                dict(
                    code=dict(
                        language_border=" ",
                        language_left="",
                        language_right="",
                    )
                ),
            ),
            Conf("normal", {("code", "style"): "normal"}),
            Conf("language", {("code", "style"): "language"}),
            Conf("block", dict(code=dict(width="block", left_pad=2, right_pad=4))),
            Conf("block-min", dict(code=dict(width="block", min_width=45))),
            Conf(
                "block-min-left",
                dict(
                    code=dict(width="block", min_width=45, left_pad=2, language_pad=2)
                ),
            ),
            Conf(
                "block-center",
                dict(
                    code=dict(
                        width="block", left_margin=0.5, left_pad=0.2, right_pad=0.2
                    )
                ),
            ),
            Conf(
                "right",
                dict(code=dict(position="right", width="block", right_pad=10)),
            ),
            Conf("thick", dict(code=dict(style="normal", border="thick"))),
        ],
    )


def quote_group() -> Group:
    return Group(
        name="quote",
        height=400,
        configs=[
            Conf("default", dict(quote={})),
            Conf("icon", {("quote", "icon"): "▯"}),
            Conf("break-naive", {("quote", "repeat_linebreak"): True}),
            Conf(
                "break-works",
                {
                    ("quote", "repeat_linebreak"): True,
                    "win_options": dict(
                        showbreak=dict(default="", rendered="  "),
                        breakindent=dict(default=False, rendered=True),
                        breakindentopt=dict(default="", rendered=""),
                    ),
                },
                [
                    "In the previous example you can see that while the line break has the quote marker",
                    "the actual text is being cut off. This is due to all the settings that impact line",
                    "break behavior. Rather than validating these we provide an example that works",
                    "using the `win_options` field. There are many more ways to accomplish this.",
                ],
            ),
        ],
    )


def dash_group() -> Group:
    return Group(
        name="dash",
        height=200,
        configs=[
            Conf("default", dict(dash={})),
            Conf("icon", {("dash", "icon"): "█"}),
            Conf("width", {("dash", "width"): 15}),
        ],
    )


def list_group() -> Group:
    return Group(
        name="list",
        height=300,
        configs=[
            Conf("default", dict(bullet={})),
            Conf("icons", {("bullet", "icons"): ["", ""]}),
            Conf("nested", {("bullet", "icons"): [["󰫶 ", "󱂉 "]]}),
            Conf("left-pad", {("bullet", "left_pad"): 4}),
            Conf("right-pad", {("bullet", "right_pad"): 2}),
        ],
    )


def callout_group() -> Group:
    return Group(
        name="callout",
        height=300,
        configs=[
            Conf("default", dict(callout={})),
            Conf("override-text", {("callout", "note", "rendered"): "󰅾 Notary"}),
            Conf("override-quote", {("callout", "note", "quote_icon"): "█"}),
        ],
    )


def table_group() -> Group:
    return Group(
        name="table",
        height=300,
        configs=[
            Conf("default", dict(pipe_table={})),
            Conf("normal", {("pipe_table", "style"): "normal"}),
            Conf("min-width", {("pipe_table", "min_width"): 12}),
            Conf("round", {("pipe_table", "preset"): "round"}),
            Conf("double", {("pipe_table", "preset"): "double"}),
            Conf("heavy", {("pipe_table", "preset"): "heavy"}),
            Conf(
                "custom",
                dict(
                    pipe_table=dict(
                        border=["╓", "╥", "╖", "╟", "╫", "╢", "╙", "╨", "╜", "║", "─"]
                    )
                ),
            ),
            Conf("indicator", {("pipe_table", "alignment_indicator"): "┅"}),
            Conf("cell-trimmed", {("pipe_table", "cell"): "trimmed"}),
            Conf("cell-raw", {("pipe_table", "cell"): "raw"}),
            Conf("cell-overlay", {("pipe_table", "cell"): "overlay"}),
        ],
        general_config={("sign", "enabled"): False},
    )


def link_group() -> Group:
    return Group(
        name="link",
        height=300,
        configs=[
            Conf("default", dict(link={})),
            Conf("image-icon", {("link", "image"): "󰋵 "}),
            Conf("email-icon", {("link", "email"): " "}),
            Conf("link-icon", {("link", "hyperlink"): "󰌷 "}),
            Conf(
                "python-icon",
                dict(link=dict(custom=dict(python=dict(pattern="%.py$", icon="󰌠 ")))),
            ),
        ],
    )


def paragraphs_group() -> Group:
    return Group(
        name="paragraphs",
        height=300,
        configs=[
            Conf("default", dict(paragraph={})),
            Conf("center", {("paragraph", "left_margin"): 0.5}),
            Conf(
                "center-min-width",
                dict(paragraph=dict(left_margin=0.5, min_width=30)),
            ),
        ],
    )


def sign_group() -> Group:
    return Group(
        name="sign",
        height=300,
        configs=[
            Conf("default", dict(sign={})),
            Conf("disabled", {("sign", "enabled"): False}),
        ],
    )


def latex_group() -> Group:
    return Group(
        name="latex",
        height=600,
        width=1100,
        configs=[
            Conf("default", dict(latex={})),
            Conf("above", {("latex", "position"): "above"}),
            Conf("below", {("latex", "position"): "below"}),
            Conf("padding-top", {("latex", "top_pad"): 1}),
            Conf("padding-bottom", {("latex", "bottom_pad"): 1}),
            Conf("disabled", {("latex", "enabled"): False}),
        ],
    )


def indent_group() -> Group:
    return Group(
        name="indent",
        height=900,
        configs=[
            Conf("default", dict(indent={})),
            Conf(
                "enabled",
                {
                    ("heading", "border"): True,
                    ("indent", "enabled"): True,
                },
            ),
            Conf(
                "skip-level",
                {
                    ("heading", "border"): True,
                    "indent": dict(enabled=True, skip_level=0),
                },
            ),
            Conf(
                "skip-heading",
                {
                    ("heading", "border"): True,
                    "indent": dict(enabled=True, skip_heading=True),
                },
            ),
        ],
    )


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run demo for specific component")
    parser.add_argument("name", type=str)
    args = parser.parse_args()
    main(args.name)
