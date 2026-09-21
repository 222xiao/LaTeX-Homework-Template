# 通用中英文 LaTeX 作业模板

适用于课程作业、习题解答和课程小报告。由原澳门城市大学作业项目整理而来，现已移除默认的个人、课程和学校绑定。封面恢复原版的大校徽、居中课程名、作业类型、下划线题目、上下横线作者栏与日期布局；原有 `cityu.png` 默认作为示例校徽显示。本项目是个人设计的模板，不是任何学校的官方格式。

- **中文 / English**：两套可直接编译的示例，均支持中英文混排。
- **作业结构**：题目、解答、公式、表格、图片和交叉引用示例。
- **统一配置**：集中修改学校、课程、姓名、学号、教师与日期。
- **可选封面、目录和校徽**：默认独立封面、无目录，显示原校徽作为例子；封面明确注明学校、课程、姓名和图片均可替换。
- **文献管理**：UTF-8 `references.bib`，通过 BibTeX 自动生成数字编号参考文献。
- **可移植字体**：项目自带 Noto Serif SC 中文 TrueType 字体，PDF 嵌入字体与 Unicode 字符映射，避免部分预览器依赖外部 Adobe-GB1 映射而缺字或乱码；无需安装系统中文字体。英文字体使用 TeX Gyre。

## 快速开始

### Overleaf

1. 下载本仓库 ZIP，选择 **New Project → Upload Project** 上传完整项目。不要只上传 `main.tex`。
2. 在项目设置中选择 **XeLaTeX** 编译器。
3. 主文档选择 `main.tex`（中文）或 `main-en.tex`（英文）。
4. 修改对应的 `config-zh.tex` / `config-en.tex` 和 `contents/homework-zh.tex` / `contents/homework-en.tex`。
5. 点击编译。若文献或交叉引用仍显示 `?`，使用 **Recompile from scratch** 清理缓存并重新编译。

### 本地编译

需要安装含中文支持的 TeX Live 或 MacTeX，以及 `latexmk`。Windows 也可使用已安装所需宏包的 MiKTeX。依赖包含 `ctex`、`xeCJK`、TeX Gyre、`natbib`、`fancyhdr`、`enumitem`、`ulem` 等；完整发行版通常已包含这些组件。

在项目根目录运行：

```sh
latexmk              # 同时编译中文与英文，自动调用 XeLaTeX 和 BibTeX
latexmk main.tex      # 只编译中文 -> main.pdf
latexmk main-en.tex   # 只编译英文 -> main-en.pdf
latexmk -c           # 清理中间文件，保留 PDF
```

没有 `latexmk` 时，按以下顺序编译（英文将 `main` 换成 `main-en`）：

```sh
xelatex -interaction=nonstopmode -halt-on-error main.tex
bibtex main
xelatex -interaction=nonstopmode -halt-on-error main.tex
xelatex -interaction=nonstopmode -halt-on-error main.tex
```

请使用 **XeLaTeX + BibTeX**；当前模板不使用 Biber，也不支持 pdfLaTeX。

## 文件结构

```text
main.tex                    中文入口
main-en.tex                 英文入口
homework.cls                共用文档类、字体、版式和作业命令
config-zh.tex               中文作业信息和显示选项
config-en.tex               英文作业信息和显示选项
document.tex                共用封面、目录、正文、参考文献结构
contents/homework-zh.tex     中文题目与解答
contents/homework-en.tex     英文题目与解答
references.bib              两套示例共享的文献数据库
cityu.png                   原版校徽，默认作为可替换的示例
figures/example-results.png 实际 PNG 插图，使用演示数据
fonts/                      自带中文字体、来源说明和 OFL 许可证
.latexmkrc                  XeLaTeX 自动编译配置
.github/workflows/latex.yml  中英文编译检查及 PDF 构建产物
```

## 效果预览

以下截图由当前模板实际编译生成；封面延续原版排版，校徽和所有信息仅为例子；目录为开启选项后的英文示例。

| 封面 | 中文正文 |
| --- | --- |
| ![封面](cover_page.png) | ![中文正文](main_text.png) |

| 英文图表与参考文献 | 可选目录 |
| --- | --- |
| ![英文正文](main_text_en.png) | ![英文目录](contents.png) |

## 配置自己的作业

在对应的 `config-*.tex` 中修改：

```tex
\homeworksetup{
  assignment={课程作业},
  title={第一次课程作业的具体题目},
  short-title={作业一},
  university={学校名称},
  department={学院名称},
  course={课程名称},
  course-code={COURSE101},
  author={姓名},
  student-id={12345678},
  instructor={教师姓名},
  date={2026-09-21},
  logo={cityu.png},
  example-note={示例封面：请替换学校、姓名与校徽。}
}
```

`assignment` 是封面中间的作业类型（如“课程作业”）；`title` 是其下方的下划线题目，并用于 PDF 标题；`short-title` 用于页眉，请保持简短。页眉右侧显示姓名。所有值建议放在花括号中；文本中的 `&`、`%`、`_` 应分别写成 `\&`、`\%`、`\_`。

学校、学院、课程、学号、教师等可选字段设为 `{}` 后自动隐藏。日期默认使用 `\today`，也可以填写固定提交日期。默认 `logo={cityu.png}` 展示原校徽作为例子，可改成自己的 PNG、JPG、PDF 文件路径，或设为 `logo={}` 隐藏。路径不存在时会跳过校徽并输出警告。

默认示例保留澳门城市大学、数据科学学院等字样以演示原封面风格，不代表模板仅适用于该学校。`example-note` 会在封面日期下方显示“示例”说明。替换全部信息后，可将 `example-note={}` 清空。学号和教师默认留空以保持原版三行作者栏，如需显示可以自行填写。

在配置文件中取消对应命令前的 `%`，即可切换版式：

```tex
\homeworkcoverfalse % 将标题与信息放在正文首页
\homeworktoctrue    % 添加目录，目录之后另起一页
```

两个选项相互独立；对于短作业，建议只使用简洁首页。封面不显示页码，正文从 1 开始；启用目录时，目录计入页码。

中文入口使用 `\documentclass[chinese]{homework}`；英文入口使用 `\documentclass[english]{homework}`。语言选项控制标题标签、日期格式和正文示例选择，**不会自动翻译作业内容**。两种模式都能直接输入中文与英文。自定义宏包可在入口文件的 `\begin{document}` 之前加载。

## 写题目、公式和插图

```tex
\problem{题目标题}
\label{sec:question}
这里写题目。
\begin{solution}
这里写答案，也可以包含列表、公式和图表。
\begin{equation}
  E = mc^2
  \label{eq:energy}
\end{equation}
引用公式：式~\eqref{eq:energy}。
\end{solution}
```

`\problem` 是带编号的节标题，可以自动出现在目录中；也可以直接使用 `\section`、`\subsection` 撰写报告型作业。将图片上传到项目后，用 `\includegraphics[width=0.8\linewidth]{figures/result.png}` 替换示例图片路径。仓库已提供 `figures/example-results.png`，图内标题和中英文图注均明确注明为示例；图中 A、B 两组数值仅用于演示，不是实际研究数据。默认采用 `[htbp]` 浮动方式，图表的位置由排版空间决定。

## 添加参考文献

在 `references.bib` 中添加条目：

```bibtex
@book{mybook,
  author    = {{张三} and {李四}},
  title     = {书名},
  publisher = {出版社},
  year      = {2026}
}
```

以上是格式示例，请替换为真实资料。正文引用方式：

```tex
\citep{mybook}                    % 数字编号引用
\citep{lamport1994,knuth1984}      % 多篇引用
\citet{lamport1994}               % 作者加编号
```

默认采用 `natbib` + `unsrtnat`：按首次引用顺序编号，连续多篇引用可压缩。中文作者姓名使用额外花括号保护，多个作者用 `and` 分隔；引用键建议只用英文字母和数字。修改 `.bib` 后重新执行完整编译流程。默认只输出已引用条目；如需列出全部文献，可在 `\bibliography{references}` 前加入 `\nocite{*}`。

这是一种通用数字引用样式，**并非 GB/T 7714、APA 或某学校的专用规范**。中文书目信息可以正常显示，但 `unsrtnat` 的版本等辅助用语仍采用英文。如课程规定了引用格式，应按其要求更换文献样式。

## 常见问题

- **中文或字体报错**：确认使用 XeLaTeX，并保留完整 `fonts/` 文件夹，且已安装 `ctex` 和 TeX Gyre；不要只安装最小英文 TeX 环境。
- **PDF 预览缺字或乱码**：请使用本次修订后的完整项目重新编译，而不是继续打开旧 PDF。新版改用自带 TrueType 中文字体并嵌入 Unicode 映射；只替换 `.tex` 而不上传 `fonts/` 会导致字体加载失败。
- **引用出现 `?`**：检查引用键是否存在、`.bib` 花括号是否配对，再运行完整编译流程。
- **切换语言后没有翻译**：应选择正确的主文档；语言模式只控制模板标签，作业内容需要自行翻译。
- **页眉太长**：缩短 `short-title` 和姓名显示文本。
- **需要学校指定格式**：自行调整 `homework.cls` 中的页边距、字体和行距。本模板不承诺满足所有院校要求。

## English guide

A general homework template with Chinese and English entry points. This is a personal template, not an official university format.

1. Upload the **entire repository** to Overleaf, select **XeLaTeX**, and set `main-en.tex` as the main document.
2. Edit `config-en.tex` for your course and student information.
3. Replace `contents/homework-en.tex` with your questions and solutions.
4. Add sources to `references.bib` and cite them with `\citep{key}` or `\citet{key}`.
5. Locally, run `latexmk main-en.tex`; `.latexmkrc` selects XeLaTeX and automatically runs BibTeX.

Set optional metadata fields to `{}` to hide them. Add `\homeworkcoverfalse` for a compact first-page heading or `\homeworktoctrue` for a contents page. The original cover layout is preserved. `logo={cityu.png}` displays the original university logo as an example by default; replace it or set `logo={}` to hide it. `assignment` controls the assignment type and `title` the underlined topic. `example-note` marks the cover as an example and can be cleared after personalizing it. Keep `short-title` brief for the page header.

Both language modes support mixed Chinese/English text. Language selection changes template labels and selects the sample content; it does not translate your writing. Chinese TrueType fonts are bundled in `fonts/` to embed explicit Unicode maps and avoid missing text in PDF previewers. Keep this folder when uploading the project; English fonts come from the TeX distribution. The bibliography uses numbered, citation-order `unsrtnat` formatting, not APA or GB/T 7714. Chinese author names should be braced, for example `author = {{刘海洋}}`.

The GitHub Actions workflow compiles both entry points and uploads the resulting PDFs. The PNG previews in this README were rendered from the current templates.

The included `figures/example-results.png` is an actual image with illustrative data, clearly marked as an example in the image and captions. Replace it with your own figure. Font provenance and redistribution terms are in `fonts/README.md` and `fonts/OFL-NotoSerifSC.txt`.
