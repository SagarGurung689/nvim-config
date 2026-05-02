# Neovim + Python Quick Reference

Beginner-friendly Neovim setup for Python and FastAPI on Windows.

## Overview

This config is built for:

- Neovim with `lazy.nvim`
- Python development on Windows
- FastAPI backend work
- A lightweight workflow with:
  - file search
  - syntax highlighting
  - autocomplete
  - LSP support
  - linting
  - formatting
  - terminal-based app running

Main tools used:

- `telescope.nvim` for file finding
- `nvim-treesitter` for better syntax highlighting
- `nvim-lspconfig` + `mason.nvim` for `pyright`
- `nvim-cmp` for autocomplete
- `nvim-lint` for Ruff linting
- `conform.nvim` for Black formatting

## Daily Workflow

1. Open the project in Neovim.
2. Activate your virtual environment or let the config detect `.venv`.
3. Open or create a Python file.
4. Edit code.
5. Save to format automatically.
6. Run the file, FastAPI app, or tests from Neovim.
7. Fix diagnostics as they appear.

## Create, Edit, and Run Python Files

### Create a file

Use Neovim to create a new file:

```text
:e app/main.py
```

### Edit the file

Write Python code normally in insert mode.

### Run the file from Neovim

Use:

```text
<leader>rs
```

This runs the current Python file in a terminal split.

### Run the file from terminal

From PowerShell:

```powershell
python app\main.py
```

## Python Virtual Environments on Windows

### Create a virtual environment

From your project folder:

```powershell
py -m venv .venv
```

### Activate it

PowerShell:

```powershell
.venv\Scripts\Activate.ps1
```

Command Prompt:

```cmd
.venv\Scripts\activate.bat
```

### Install packages

```powershell
pip install fastapi uvicorn[standard] pyright ruff black pytest
```

### Deactivate

```powershell
deactivate
```

## Running Python Programs

### From terminal

```powershell
python script.py
```

### From inside Neovim

- `<leader>rs` runs the current Python file
- `<leader>tt` opens a terminal split
- `<leader>rt` runs `pytest`
- `<leader>ru` runs FastAPI with uvicorn

## Essential Neovim Shortcuts

### Navigation

- `h` left
- `j` down
- `k` up
- `l` right
- `gg` top of file
- `G` bottom of file
- `0` line start
- `$` line end

### Insert mode

- `i` insert before cursor
- `I` insert at line start
- `a` append after cursor
- `A` append at line end
- `o` open new line below
- `O` open new line above

### Saving and quitting

- `:w` save
- `:q` quit
- `:wq` save and quit
- `:q!` quit without saving

### Search

- `/text` search forward
- `n` next match
- `N` previous match

### Split windows

- `:sp` horizontal split
- `:vsp` vertical split
- `<C-w>h/j/k/l` move between splits

### Terminal mode

- `<Esc><Esc>` leave terminal mode
- `<leader>tt` open a terminal split

### File switching

- `<leader>ff` find files
- `<leader>fg` search text
- `<leader>ex` open file explorer (`:Ex`)
- `<leader>bn` next buffer
- `<leader>bp` previous buffer

### Harpoon

- `<leader>ha` add current file
- `<leader>hh` open Harpoon menu
- `<leader>hn` next Harpoon file
- `<leader>hp` previous Harpoon file
- `<leader>h1` to `<leader>h4` jump to saved files

## Python Shortcuts in Neovim

### Run current file

- `<leader>rs`

### Open terminal

- `<leader>tt`

### Search files

- `<leader>ff`

### LSP actions

If Pyright is active:

- `gd` go to definition
- `gr` references
- `K` hover docs
- `<leader>rn` rename symbol
- `<leader>ca` code action
- `[d` previous diagnostic
- `]d` next diagnostic
- `<leader>cd` line diagnostic
- `<leader>q` diagnostics list

### Formatting

- `<leader>f` format buffer with Black

## FastAPI Workflow

### 1. Create a project

Example structure:

```text
project/
  app/
    main.py
  tests/
  .venv/
  pyproject.toml
```

### 2. Install dependencies

```powershell
pip install fastapi uvicorn[standard] ruff black pytest pyright
```

### 3. Minimal `app/main.py`

```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI"}
```

### 4. Run uvicorn

From terminal:

```powershell
uvicorn app.main:app --reload
```

From Neovim:

```text
<leader>ru
```

### 5. Hot reload

Use `--reload` while developing. Save the file and uvicorn reloads automatically.

## Troubleshooting

### Python not found

- Check that Python is installed.
- Run `py --version` in PowerShell.
- Make sure `.venv` is activated.
- Restart Neovim after creating a venv.

### Plugin errors

- Run `:Lazy` inside Neovim.
- Use `:Lazy sync` to install missing plugins.
- Check for Lua syntax errors in your config.

### Virtual environment activation problems

- On PowerShell, run:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

- Then activate again:

```powershell
.venv\Scripts\Activate.ps1
```

## Best Practices

- Keep one project per folder.
- Use `.venv` in every Python project.
- Save often and format on save.
- Fix diagnostics early.
- Keep keymaps simple and consistent.
- Use terminal commands for learning and debugging.
- Start with one FastAPI route, then expand.
- Read errors carefully before changing code.

## Suggested File Layout

```text
project/
  app/
    main.py
    api/
    core/
    schemas/
  tests/
  .venv/
  pyproject.toml
  README.md
```

## Current Neovim Keymaps

- `<leader>ff` file finder
- `<leader>fg` live grep
- `<leader>rs` run current Python file
- `<leader>ru` run uvicorn
- `<leader>rt` run tests
- `<leader>f` format buffer
- `<leader>tt` terminal split
- `<leader>sq` open `shortcuts.md`
- `<leader>bn` next buffer
- `<leader>bp` previous buffer

## Learning Tip

Use Neovim as a feedback loop:

edit -> save -> run -> read errors -> fix -> repeat
