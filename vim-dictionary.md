# Vim Reference Guide

> Plugin-free `~/.vimrc` setup — `<leader>` is `Space`

---

## Table of Contents

- [Core Concepts](#core-concepts)
  - [Modes](#modes)
  - [The Vim Language](#the-vim-language)
  - [Text Objects](#text-objects)
- [Navigation](#navigation)
  - [Basic Motion](#basic-motion)
  - [In-File Navigation](#in-file-navigation)
  - [Screen Position](#screen-position)
  - [Jump List](#jump-list)
  - [Marks](#marks)
- [Editing](#editing)
  - [Inserting Text](#inserting-text)
  - [Deleting](#deleting)
  - [Changing](#changing)
  - [Undo / Redo / Repeat](#undo--redo--repeat)
  - [Indentation](#indentation)
  - [Visual Mode Editing](#visual-mode-editing)
  - [Visual Block](#visual-block)
  - [Macros](#macros)
- [Clipboard & Registers](#clipboard--registers)
  - [Copy / Paste](#copy--paste)
  - [Registers](#registers)
- [Search & Replace](#search--replace)
  - [Search](#search)
  - [Search & Replace](#search--replace-commands)
  - [Quickfix List](#quickfix-list)
- [Windows, Buffers & Tabs](#windows-buffers--tabs)
  - [Splits / Windows](#splits--windows)
  - [Buffers](#buffers)
  - [Tabs](#tabs)
- [Files & Project](#files--project)
  - [File Commands](#file-commands)
  - [Netrw File Explorer](#netrw-file-explorer)
  - [File Find](#file-find)
  - [Project Search (ripgrep)](#project-search-ripgrep)
- [Tools](#tools)
  - [Terminal](#terminal)
  - [Run Code](#run-code)
  - [Git](#git)
  - [Completion](#completion)
  - [Folding](#folding)
- [Settings & Help](#settings--help)
- [Common Situations & How to Fix Them](#common-situations--how-to-fix-them)
- [Config Leader Shortcuts — At a Glance](#config-leader-shortcuts--at-a-glance)
- [Learning Path](#learning-path)

---

## Core Concepts

### Modes

Vim is a **modal editor** — keys do different things depending on which mode you're in.

| Key   | Mode               | Purpose                        |
| ----- | ------------------ | ------------------------------ |
| `Esc` | **Normal**         | Navigate, compose commands     |
| `i`   | **Insert**         | Type text (before cursor)      |
| `v`   | **Visual**         | Select characters              |
| `V`   | **Visual Line**    | Select whole lines             |
| `Ctrl+v` | **Visual Block**   | Select rectangular columns     |
| `:`   | **Command-line**   | Run Ex commands                |

See [Inserting Text](#inserting-text) for all ways to enter Insert mode.

### The Vim Language

The core idea that makes Vim powerful: **commands are composable**.

```
operator + motion       →  act on a range
operator + text object  →  act on a structured unit
```

| Operator | Meaning | Example     | Result                  |
| -------- | ------- | ----------- | ----------------------- |
| `d`      | Delete  | `dw`        | Delete to next word     |
| `c`      | Change  | `c$`        | Change to end of line   |
| `y`      | Yank    | `yiw`       | Yank current word       |
| `>`      | Indent  | `>}`        | Indent to next paragraph|
| `<`      | Unindent| `<i{`       | Unindent inside `{}`    |
| `=`      | Format  | `gg=G`      | Auto-indent entire file |

**More examples:**

| Command | Read as                      | Result                    |
| ------- | ---------------------------- | ------------------------- |
| `d$`    | **d**elete to **$** (EOL)    | Delete to end of line     |
| `d0`    | **d**elete to **0** (BOL)    | Delete to start of line   |
| `cw`    | **c**hange **w**ord          | Change word               |
| `ci"`   | **c**hange **i**nside **"**  | Change inside quotes      |
| `di(`   | **d**elete **i**nside **(**  | Delete inside parentheses |
| `yiw`   | **y**ank **i**nner **w**ord  | Yank entire word          |
| `y}`    | **y**ank to next **}**       | Yank to next paragraph    |

> **You don't memorize every command — you compose them.**

### Text Objects

Text objects define *what* you're acting on. Use them with `i` (inner) or `a` (around, includes delimiter/space).

| Object | `i` (inner)             | `a` (around)                  |
| ------ | ----------------------- | ----------------------------- |
| `w`    | `iw` — word             | `aw` — word + surrounding space |
| `"`    | `i"` — inside `"..."`   | `a"` — includes the quotes   |
| `'`    | `i'` — inside `'...'`   | `a'` — includes the quotes   |
| `` ` ``| `` i` `` — inside backticks | `` a` `` — includes backticks |
| `(`    | `i(` — inside `(...)`   | `a(` — includes the parens   |
| `[`    | `i[` — inside `[...]`   | `a[` — includes the brackets |
| `{`    | `i{` — inside `{...}`   | `a{` — includes the braces   |
| `t`    | `it` — inside XML/HTML tag | `at` — includes the tag    |
| `p`    | `ip` — paragraph        | `ap` — paragraph + blank line|
| `s`    | `is` — sentence         | `as` — sentence + space      |

**Example:** Given `foo("hello world");` with cursor inside the quotes:

| Command | Result                              |
| ------- | ----------------------------------- |
| `ci"`   | Replaces `hello world`, stays in Insert mode |
| `di"`   | Deletes `hello world`               |
| `yi"`   | Yanks `hello world`                 |
| `da(`   | Deletes `("hello world")` including parens |

---

## Navigation

### Basic Motion

| Key  | Motion                         |
| ---- | ------------------------------ |
| `h`  | ← Left                        |
| `j`  | ↓ Down                        |
| `k`  | ↑ Up                          |
| `l`  | → Right                       |
| `w`  | Start of next word             |
| `b`  | Start of previous word         |
| `e`  | End of current/next word       |
| `ge` | End of previous word           |
| `0`  | Start of line                  |
| `^`  | First non-whitespace character |
| `$`  | End of line                    |
| `g_` | Last non-whitespace character  |
| `%`  | Matching bracket `()[]{}` |

### In-File Navigation

| Key    | Motion            |
| ------ | ----------------- |
| `gg`   | Top of file       |
| `G`    | Bottom of file    |
| `{n}G` | Go to line `n`    |
| `:{n}` | Go to line `n`    |
| `Ctrl+d`  | Half page down    |
| `Ctrl+u`  | Half page up      |
| `Ctrl+f`  | Full page down    |
| `Ctrl+b`  | Full page up      |

### Screen Position

| Key  | Cursor position          |
| ---- | ------------------------ |
| `H`  | Top of screen            |
| `M`  | Middle of screen         |
| `L`  | Bottom of screen         |
| `zz` | Scroll: cursor to center |
| `zt` | Scroll: cursor to top    |
| `zb` | Scroll: cursor to bottom |

### Jump List

Vim remembers where you've been. Jump between locations:

| Key   | Action         |
| ----- | -------------- |
| `Ctrl+o` | Jump backward  |
| `Ctrl+i` | Jump forward   |

> **Example:** line 10 → 500 → 1200, then `Ctrl+o` → back to 500, `Ctrl+o` again → back to 10.

### Marks

Set named bookmarks within a file:

| Action         | Key / Command |
| -------------- | ------------- |
| Set mark `a`   | `ma`          |
| Jump to mark `a` | `'a`       |
| List all marks | `:marks`      |

---

## Editing

### Inserting Text

All of these enter Insert mode:

| Key | Where                          |
| --- | ------------------------------ |
| `i` | Before cursor                  |
| `a` | After cursor                   |
| `I` | At start of line               |
| `A` | At end of line                 |
| `o` | New line below                 |
| `O` | New line above                 |

### Deleting

All delete commands also yank (copy) the deleted text.

| Key  | Deletes                         |
| ---- | ------------------------------- |
| `x`  | Character under cursor          |
| `X`  | Character before cursor         |
| `dw` | To next word                    |
| `de` | To end of word                  |
| `db` | Previous word                   |
| `dd` | Entire line                     |
| `D`  | From cursor to end of line      |
| `d0` | From cursor to start of line    |

Prefix with a count: `5dd` deletes 5 lines.

### Changing

`c` = delete + enter Insert mode. Same motions as `d`:

| Key   | Changes                          |
| ----- | -------------------------------- |
| `cw`  | To next word                     |
| `ciw` | Entire word (inner)              |
| `cc`  | Entire line                      |
| `C`   | From cursor to end of line       |

### Undo / Redo / Repeat

| Key  | Action               |
| ---- | -------------------- |
| `u`  | Undo                 |
| `Ctrl+r`| Redo                 |
| `.`  | Repeat last edit     |

> `.` is extremely powerful — e.g. `dd` then `.` `.` deletes three lines total.

### Indentation

| Key    | Action                  |
| ------ | ----------------------- |
| `>>`   | Indent line             |
| `<<`   | Unindent line           |
| `==`   | Auto-indent line        |
| `gg=G` | Auto-indent entire file |

### Visual Mode Editing

This config adds persistent-selection indent and block movement:

| Keys                | Action                              |
| ------------------- | ----------------------------------- |
| `Visual` + `>` / `<`| Indent / unindent (selection stays) |
| `Visual` + `J`      | Move selected block down            |
| `Visual` + `K`      | Move selected block up              |

### Visual Block

Insert text on multiple lines at once:

1. `Ctrl+v` — enter Visual Block mode
2. Select a column of lines with `j`/`k`
3. `I` — type your text — `Esc`

**Example** — prepend `const ` to three lines:

```
BEFORE              AFTER
int a = 1;          const int a = 1;
int b = 2;          const int b = 2;
int c = 3;          const int c = 3;
```

### Macros

Record a sequence of edits and replay them:

| Step    | Key  | Action                            |
| ------- | ---- | --------------------------------- |
| Record  | `qa` | Start recording into register `a` |
| (edit)  | ...  | Perform your edits                |
| Stop    | `q`  | Stop recording                    |
| Replay  | `@a` | Play back macro `a`               |
| Re-replay | `@@` | Replay the last used macro      |

Prefix with a count: `10@a` runs the macro 10 times.

---

## Clipboard & Registers

### Copy / Paste

| Key  | Action                    |
| ---- | ------------------------- |
| `yy` | Yank (copy) entire line   |
| `Y`  | Yank entire line          |
| `yw` | Yank word                 |
| `y$` | Yank to end of line       |
| `p`  | Paste after cursor        |
| `P`  | Paste before cursor       |

Prefix with a count: `5yy` yanks 5 lines.

### Registers

Vim has multiple named clipboards called registers. View them with `:reg`.

| Register | Contents                     |
| -------- | ---------------------------- |
| `"`      | Unnamed — last d/c/y         |
| `0`      | Last yank (not delete)       |
| `1`–`9`  | Recent deletes (history)     |
| `+`      | System clipboard             |
| `a`–`z`  | User-named registers         |

> **This config sets `clipboard=unnamedplus`**, which means all `y`, `d`, `c`, and `p` commands automatically use the system clipboard. You don't need `"+y` or `"+p` — regular `yy` and `p` already copy/paste to/from macOS clipboard.

**If you ever need an explicit register:**

| Command | Action                              |
| ------- | ----------------------------------- |
| `"ayy`  | Yank line into register `a`         |
| `"ap`   | Paste from register `a`             |
| `"0p`   | Paste last yank (ignoring deletes)  |

---

## Search & Replace

### Search

| Key / Command | Action                            |
| ------------- | --------------------------------- |
| `/pattern`    | Search forward                    |
| `?pattern`    | Search backward                   |
| `n`           | Next match                        |
| `N`           | Previous match                    |
| `*`           | Search word under cursor (forward)|
| `#`           | Search word under cursor (backward)|
| **`Space h`** | Clear search highlight *(config)* |

### Search & Replace Commands

| Command           | Scope                          |
| ----------------- | ------------------------------ |
| `:s/old/new/`     | First match in current line    |
| `:s/old/new/g`    | All matches in current line    |
| `:%s/old/new/g`   | All matches in entire file     |
| `:%s/old/new/gc`  | All matches, with confirmation |

### Quickfix List

The Quickfix list holds a list of locations (search results, compiler errors, grep output). Navigate through them:

| Key / Command   | Action           | Source     |
| --------------- | ---------------- | ---------- |
| `:copen`        | Open Quickfix    | Command    |
| `:cclose`       | Close Quickfix   | Command    |
| `:cnext`        | Next item        | Command    |
| `:cprevious`    | Previous item    | Command    |
| `:cfirst`       | First item       | Command    |
| `:clast`        | Last item        | Command    |
| **`Space co`** | Open Quickfix    | Config     |
| **`Space cc`** | Close Quickfix   | Config     |
| **`Space cn`** | Next result      | Config     |
| **`Space cp`** | Previous result  | Config     |

Quickfix works with: `:grep`, `:make`, `Space /` (ripgrep), compiler errors.

---

## Windows, Buffers & Tabs

> **Buffer** = an open file in memory
> **Window** = a visible viewport into a buffer
> **Tab** = a layout of windows

### Splits / Windows

#### Creating

| Key / Command | Action           |
| ------------- | ---------------- |
| `Ctrl+w s`       | Horizontal split |
| `Ctrl+w v`       | Vertical split   |
| `:split`      | Horizontal split |
| `:vsplit`     | Vertical split   |

#### Navigating

| Key     | Action                           | Source  |
| ------- | -------------------------------- | ------- |
| `Ctrl+h`   | Go to left window                | Config  |
| `Ctrl+j`   | Go to window below               | Config  |
| `Ctrl+k`   | Go to window above               | Config  |
| `Ctrl+l`   | Go to right window               | Config  |
| `Ctrl+w w` | Cycle to next window             | Default |
| `Ctrl+w p` | Go to previously active window   | Default |

#### Managing

| Key     | Action                              |
| ------- | ----------------------------------- |
| `Ctrl+w o` | **Close all other windows**         |
| `Ctrl+w q` | Close current window                |
| `Ctrl+w c` | Close current window                |
| `Ctrl+w =` | Equalize all window sizes           |
| `Ctrl+w +` | Increase height                     |
| `Ctrl+w -` | Decrease height                     |
| `Ctrl+w >` | Increase width                      |
| `Ctrl+w <` | Decrease width                      |

### Buffers

| Key / Command    | Action          | Source  |
| ---------------- | --------------- | ------- |
| `:ls`            | List buffers    | Default |
| `:bnext`         | Next buffer     | Default |
| `:bprevious`     | Previous buffer | Default |
| `:bdelete`       | Delete buffer   | Default |
| **`Space bn`**  | Next buffer     | Config  |
| **`Space bp`**  | Previous buffer | Config  |
| **`Space bd`**  | Delete buffer   | Config  |

### Tabs

| Key / Command    | Action               |
| ---------------- | -------------------- |
| `:tabnew`        | New tab              |
| `:tabedit file`  | Open file in new tab |
| `gt`             | Next tab             |
| `gT`             | Previous tab         |
| `{n}gt`          | Go to tab `n`        |
| `:tabclose`      | Close tab            |

---

## Files & Project

### File Commands

| Command         | Action                         |
| --------------- | ------------------------------ |
| `:e file`       | Open file                      |
| `:enew`         | Create new empty buffer        |
| `:saveas file`  | Save As                        |
| `:r file`       | Insert file contents at cursor |
| `:pwd`          | Show working directory         |
| `:cd path`      | Change working directory       |
| `:Explore`      | Open Netrw file browser        |

### Netrw File Explorer

Open with **`Space e`** (runs `:Lexplore`)

| Key     | Action                 |
| ------- | ---------------------- |
| `Enter` | Open file / directory  |
| `-`     | Go up a directory      |
| `%`     | Create new file        |
| `d`     | Create new directory   |
| `D`     | Delete                 |
| `R`     | Rename                 |
| `s`     | Change sort order      |
| `i`     | Change display style   |
| `q`     | Close explorer         |

### File Find

Open with **`Space f`** (runs `:find`)

With `set path+=**` in the config, `:find` searches recursively through all subdirectories.

### Project Search (ripgrep)

Open with **`Space /`**

Runs `rg --vimgrep --smart-case` and loads results into the [Quickfix list](#quickfix-list). Use `Space cn` / `Space cp` to navigate results.

---

## Tools

### Terminal

| Key / Shortcut | Action                   |
| -------------- | ------------------------ |
| **`Space t`**  | Open terminal below      |
| `Ctrl+\ Ctrl+n`     | Exit terminal → Normal mode |

### Run Code

All triggered with **`Space r`** — saves the file, compiles (if needed), and runs:

| Language | Command                                         |
| -------- | ------------------------------------------------ |
| C        | `cc file.c -o /tmp/a.out && /tmp/a.out`          |
| C++      | `c++ -std=c++20 file.cpp -o /tmp/a.out && /tmp/a.out` |
| Java     | `javac File.java && java File`                   |
| Python   | `python3 file.py`                                |

> For Maven / Gradle / complex projects, use a proper build system instead.

### Git

| Key        | Action                 |
| ---------- | ---------------------- |
| `Space gs` | `git status`           |
| `Space gd` | `git diff`             |
| `Space gl` | `git log --oneline --decorate --graph -20` |
| `Space ga` | `git add` current file |

### Completion

In Insert mode:

| Key       | Action              |
| --------- | ------------------- |
| `Ctrl+n`     | Next completion     |
| `Ctrl+p`     | Previous completion |
| `Ctrl+x Ctrl+f` | File path completion |
| `Ctrl+x Ctrl+o` | Omni completion     |

### Folding

| Key  | Action          |
| ---- | --------------- |
| `za` | Toggle fold     |
| `zo` | Open fold       |
| `zc` | Close fold      |
| `zR` | Open all folds  |
| `zM` | Close all folds |

---

## Settings & Help

### Useful Settings

| Command              | Effect                    |
| -------------------- | ------------------------- |
| `:set number`        | Show line numbers         |
| `:set nonumber`      | Hide line numbers         |
| `:set syntax=on`     | Enable syntax highlighting|
| `:set hlsearch`      | Highlight search matches  |
| `:set nohlsearch`    | Disable search highlights |

Query current values with `?`: `:set tabstop?`, `:set shiftwidth?`

### Built-in Help

Vim has comprehensive built-in documentation:

```vim
:help split
:help text-objects
:help quickfix
:help terminal
:help registers
:help usr_04          " Vim tutorial chapter 4
```

---

## Common Situations & How to Fix Them

Things can get messy when panels and splits pile up. Here's how to recover.

### Too many splits / windows open

You pressed `Space e`, `Space t`, `Space r`, or `Ctrl+w s` multiple times and now you have a mess of windows.

| What you want                    | Key         |
| -------------------------------- | ----------- |
| **Keep only the window you're in, close everything else** | `Ctrl+w o` |
| Close just the current window    | `Ctrl+w q`     |
| Close one window at a time       | Move to it with `Ctrl+h/j/k/l`, then `Ctrl+w q` |

> **`Ctrl+w o` is the panic button** — it instantly goes back to a single clean window.

### Netrw explorer won't go away

`Space e` opens `:Lexplore`, which is a **toggle** — press `Space e` again to close it. If that doesn't work:

| Fix                               | How                          |
| --------------------------------- | ---------------------------- |
| Toggle it off                     | `Space e` (press again)      |
| Close it as a window              | Move to it with `Ctrl+h`, then `Ctrl+w q` |
| Nuclear: close all other windows  | Focus your code, then `Ctrl+w o` |

### Stuck in a terminal split

`Space t` or `Space r` opens a terminal. Terminal mode captures all your keys — including `Esc`.

| Step | Action                              |
| ---- | ----------------------------------- |
| 1    | `Ctrl+\ Ctrl+n` — exit terminal mode back to Normal |
| 2    | `Ctrl+w q` — close the terminal window |

Or skip straight to: `Ctrl+\ Ctrl+n` then `Ctrl+w o` to close everything else.

### Ran code (`Space r`) and output is blocking

`Space r` opens a terminal split with your program's output. When you're done reading:

| Fix                              | How                               |
| -------------------------------- | --------------------------------- |
| Close the output split           | `Ctrl+\ Ctrl+n` then `Ctrl+w q`           |
| Go back to your code, keep output| `Ctrl+k` or `Ctrl+w p`                 |
| Close everything except your code| Focus your code, then `Ctrl+w o`    |

### Git/grep command output is showing, can't get back

`Space gs`, `Space gd`, `Space gl` run shell commands. The output shows in a full-screen view.

| Fix                          | How                              |
| ---------------------------- | -------------------------------- |
| Dismiss the output           | Press `Enter` or `q`            |

### Quickfix window appeared and won't close

After `Space /` (grep) or `:make`, a Quickfix window may open.

| Fix                          | How              |
| ---------------------------- | ---------------- |
| Close Quickfix               | `Space cc`       |
| Close it as a window         | `Ctrl+w q` (while in Quickfix window) |
| Close everything else        | Focus your code, then `Ctrl+w o`  |

### Summary: the 3 keys that fix almost everything

```
Ctrl+\ Ctrl+n     Get out of terminal mode
Ctrl+w q          Close current window
Ctrl+w o          Keep ONLY current window (close all others)
```

---

## Config Leader Shortcuts — At a Glance

All shortcuts below use `Space` as the leader key.

| Shortcut      | Action                     |
| ------------- | -------------------------- |
| `Space w`     | Save                       |
| `Space q`     | Quit                       |
| `Space e`     | File explorer (Netrw)      |
| `Space f`     | Find file                  |
| `Space /`     | Project search (ripgrep)   |
| `Space t`     | Terminal                   |
| `Space r`     | Run current file           |
| `Space h`     | Clear search highlight     |
| `Space bn`    | Next buffer                |
| `Space bp`    | Previous buffer            |
| `Space bd`    | Delete buffer              |
| `Space co`    | Open Quickfix              |
| `Space cc`    | Close Quickfix             |
| `Space cn`    | Next Quickfix result       |
| `Space cp`    | Previous Quickfix result   |
| `Space gs`    | Git status                 |
| `Space gd`    | Git diff                   |
| `Space gl`    | Git log (graph, last 20)   |
| `Space ga`    | Git add current file       |

---

## Learning Path

If you're just getting started, learn in this order:

| Phase | Keys                           | Skill                      |
| ----- | ------------------------------ | -------------------------- |
| 1     | `Esc`                          | Always return to Normal    |
| 2     | `i` / `a` / `o`               | Enter Insert mode          |
| 3     | `h` `j` `k` `l`               | Basic movement             |
| 4     | `w` / `b`                      | Word-level movement        |
| 5     | `0` / `$`                      | Line start / end           |
| 6     | `gg` / `G`                     | File start / end           |
| 7     | `dd` / `yy` / `p`             | Delete, yank, paste lines  |
| 8     | `u` / `Ctrl+r` / `.`             | Undo, redo, repeat         |
| 9     | `/` / `n` / `N`               | Search                     |
| 10    | `ciw` / `diw`                  | Text objects               |
| 11    | `Ctrl+w s` / `Ctrl+w v` / `Ctrl+w o`   | Window management          |
| 12    | `Ctrl+h` / `Ctrl+j` / `Ctrl+k` / `Ctrl+l` | Navigate windows          |
| 13    | `Space w` / `Space q`          | Save and quit              |
| 14    | `Space e` / `Space t` / `Space r` | Explorer, terminal, run |
| 15    | `qa` ... `q` / `@a`           | Macros                     |

> **The heart of Vim isn't memorizing shortcuts — it's composing `operator + motion`.**
>
> `d` + `iw` = `diw` · `c` + `i"` = `ci"` · `y` + `}` = `y}`
