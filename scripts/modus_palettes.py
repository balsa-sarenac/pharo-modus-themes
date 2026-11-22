"""Parse the palettes out of protesilaos/modus-themes' modus-themes.el.

Used by generate-palettes.py; kept separate so it can be imported on its own.
"""
import re

VARIANTS = [
    "operandi", "operandi-tinted", "operandi-deuteranopia", "operandi-tritanopia",
    "vivendi", "vivendi-tinted", "vivendi-deuteranopia", "vivendi-tritanopia",
]

_ENTRY = re.compile(r'^\s*\((?P<name>[a-z0-9-]+)\s+(?P<value>"#[0-9a-fA-F]{6}"|[a-z0-9-]+)\)', re.M)


def _block(source, const):
    start = source.index("(defconst %s" % const)
    # The constant ends at its docstring, which follows the closing of the palette list.
    end = source.index('"The entire palette', start) if const != "modus-themes-common-palette-mappings" \
        else source.index("(defconst", start + 10)
    return source[start:end]


def _entries(text):
    return [(m.group("name"), m.group("value").strip('"')) for m in _ENTRY.finditer(text)]


def load(path):
    source = open(path, encoding="utf-8").read()
    common = _entries(_block(source, "modus-themes-common-palette-mappings"))
    result = {}
    for variant in VARIANTS:
        own = _entries(_block(source, "modus-themes-%s-palette" % variant))
        raw = dict(common)
        raw.update(dict(own))  # theme-specific entries win over common mappings
        order = [n for n, _ in own] + [n for n, _ in common if n not in dict(own)]

        def resolve(name, seen=()):
            value = raw[name]
            if value.startswith("#"):
                return value[1:].lower()
            if value == "unspecified":
                return None
            if name in seen:
                raise ValueError("cycle at " + name)
            return resolve(value, seen + (name,))

        resolved = []
        for name in order:
            value = resolve(name)
            if value is not None:
                resolved.append((name, value))
        result[variant] = resolved
    return result
