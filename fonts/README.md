# Bundled Chinese fonts

Source: [Google Fonts / Noto Serif SC](https://github.com/google/fonts/tree/main/ofl/notoserifsc)

The two static TrueType fonts were instantiated from the upstream
`NotoSerifSC[wght].ttf` variable font using fontTools 4.55.3:

- `NotoSerifSC-Regular.ttf`: weight 400.
- `NotoSerifSC-Bold.ttf`: weight 700.

Static family/style name records are normalized to Regular and Bold.
All upstream glyphs are retained (not a subset restricted to the example text).
The fonts are distributed under SIL Open Font License 1.1; see
`OFL-NotoSerifSC.txt` for the copyright notice and full license.
Font files must accompany the template; no system font installation is needed.
XeTeX embeds used glyphs and explicit Unicode mappings in the resulting PDF.
Chinese italics use a slight synthetic slant because this family has no italic face.

Upstream variable font SHA-256: `050080d9255a86808f2945bffac582b31ef32bc36411ce29563b4961670c66f9`.

Reproduction (Python with fontTools; not needed to compile the LaTeX template):

```python
from fontTools.ttLib import TTFont
from fontTools.varLib.instancer import instantiateVariableFont
for weight, style in [(400, "Regular"), (700, "Bold")]:
    font = TTFont("NotoSerifSC[wght].ttf")
    instantiateVariableFont(font, {"wght": weight}, inplace=True)
    names = {1: "Noto Serif SC", 2: style,
             3: f"Homework-NotoSerifSC-{style}",
             4: f"Noto Serif SC {style}", 6: f"NotoSerifSC-{style}",
             16: "Noto Serif SC", 17: style}
    for record in font["name"].names:
        if record.nameID in names:
            record.string = names[record.nameID].encode(record.getEncoding())
    font.save(f"NotoSerifSC-{style}.ttf")
```
