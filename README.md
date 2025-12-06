# Emacs Configuration

A comprehensive Emacs configuration for modern software development and writing.

## Features

### Programming Languages
- **Python**: LSP support (pyright), virtual environments (pyvenv, conda, poetry), testing (pytest), formatting (black, isort), Jupyter notebooks
- **Go**: LSP support, gofmt/goimports, testing, code navigation
- **Java**: Eclipse JDT LSP, Maven/Gradle integration, debugging (DAP)
- **C/C++**: LSP (clangd), CMake support, clang-format, modern C++ syntax
- **CUDA**: CUDA mode with syntax highlighting, compilation support, nvcc integration
- **Docker**: Dockerfile and docker-compose support, container management
- **Frontend**: JavaScript, TypeScript, React, Vue, HTML/CSS, JSON, YAML, web-mode

### Writing
- **Org Mode**: Advanced configuration with org-roam, org-babel, presentations, export backends
- **Markdown**: GitHub-flavored markdown, live preview (grip), TOC generation

### Data Formats
- **CSV/TSV**: Advanced CSV editing with alignment and sorting
- **SQL**: PostgreSQL, SQLite, formatting, indentation
- **Parquet**: View support via parquet-tools or pyarrow
- **Other**: JSON, XML, Protocol Buffers, Avro, Thrift, HDF5, Arrow/Feather

### General Features
- **Package Management**: straight.el for reproducible, version-controlled packages
- **Evil Mode**: Vim emulation with space as leader key and comma as local leader
- Modern UI with doom-themes and doom-modeline
- LSP integration for intelligent code completion
- Git integration (magit, git-gutter, diff-hl)
- Project management (projectile)
- Smart completion (company, vertico, orderless)
- Syntax checking (flycheck)
- Code snippets (yasnippet)
- Tree-sitter for better syntax highlighting
- File explorer (treemacs)
- Terminal emulation (vterm)
- Spell checking (flyspell)

## Installation

### Prerequisites

1. **Emacs 28.1 or later** (recommended: Emacs 29+)
   ```bash
   # Ubuntu/Debian
   sudo apt install emacs

   # macOS
   brew install emacs

   # Arch Linux
   sudo pacman -S emacs
   ```

2. **Git**
   ```bash
   git --version
   ```

### Quick Start

1. Clone this repository to `~/.emacs.d`:
   ```bash
   git clone <repository-url> ~/.emacs.d
   ```

2. Start Emacs:
   ```bash
   emacs
   ```

3. On first launch, Emacs will automatically:
   - Bootstrap `straight.el` (declarative package manager)
   - Clone and build all required packages
   - Compile configuration files
   - This may take 5-10 minutes on first run

**Note**: This configuration uses [straight.el](https://github.com/radian-software/straight.el) instead of package.el for reproducible, version-controlled package management.

### Language Server Protocol (LSP) Setup

Install language servers for the languages you use:

#### Python
```bash
pip install 'python-lsp-server[all]' pyright
```

#### JavaScript/TypeScript
```bash
npm install -g typescript typescript-language-server
```

#### Go
```bash
go install golang.org/x/tools/gopls@latest
```

#### C/C++
```bash
# Ubuntu/Debian
sudo apt install clangd

# macOS
brew install llvm
```

#### Java
LSP server is automatically downloaded by `lsp-java` on first use.

### Optional Tools

#### Code Formatting
```bash
# Python
pip install black isort

# JavaScript/TypeScript
npm install -g prettier eslint

# C/C++
# clang-format is usually included with clangd
```

#### Docker
```bash
# Dockerfile linter
brew install hadolint  # macOS
# or
wget -O /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
chmod +x /usr/local/bin/hadolint
```

#### Data Tools
```bash
# Parquet
pip install pyarrow parquet-tools

# SQL formatting
sudo apt install pgformatter  # or brew install pgformatter
```

## Configuration Structure

```
~/.emacs.d/
├── early-init.el              # Early initialization (performance)
├── init.el                    # Main entry point
├── lisp/                      # Configuration modules
│   ├── base-config.el         # Basic settings
│   ├── evil-config.el         # Evil mode (space leader)
│   ├── evil-local-leader.el   # Major-mode bindings (comma leader)
│   ├── ui-config.el           # UI and theming
│   ├── programming-config.el  # General programming setup
│   ├── lang-python.el         # Python configuration
│   ├── lang-go.el             # Go configuration
│   ├── lang-java.el           # Java configuration
│   ├── lang-cpp.el            # C/C++ configuration
│   ├── lang-cuda.el           # CUDA configuration
│   ├── lang-docker.el         # Docker configuration
│   ├── lang-frontend.el       # Frontend configuration
│   ├── writing-config.el      # Org and Markdown
│   └── data-config.el         # Data formats
└── README.md                  # This file
```

## Key Bindings

This configuration uses **Evil mode** (Vim emulation) with:
- **Space** (`SPC`) as the global leader key
- **Comma** (`,`) as the local leader for major-mode specific commands
- **M-SPC** and **M-,** for insert/emacs mode

Press `SPC` and wait to see available keybindings (powered by which-key).

### Evil Mode Basics

#### Normal Mode
- `hjkl` - Move cursor (left, down, up, right)
- `w/b` - Word forward/backward
- `0/$` - Line start/end
- `gg/G` - File start/end
- `i/a` - Insert before/after cursor
- `o/O` - New line below/above
- `v/V` - Visual/Visual line mode
- `d` - Delete (with motion)
- `c` - Change (with motion)
- `y` - Yank/copy (with motion)
- `p/P` - Paste after/before
- `u` - Undo
- `Ctrl-r` - Redo
- `gcc` - Comment line (evil-commentary)
- `gc{motion}` - Comment motion

### Global Leader (Space)

#### Files (`SPC f`)
- `SPC f f` - Find file
- `SPC f r` - Recent files
- `SPC f s` - Save file
- `SPC f d` - Delete file
- `SPC f D` - Open dired

#### Buffers (`SPC b`)
- `SPC b b` - Switch buffer
- `SPC b d` - Kill buffer
- `SPC b n/p` - Next/previous buffer
- `SPC b s` - Save buffer

#### Windows (`SPC w`)
- `SPC w s` - Split horizontally
- `SPC w v` - Split vertically
- `SPC w d` - Delete window
- `SPC w h/j/k/l` - Navigate windows (vim-style)
- `SPC w m` - Maximize window

#### Search (`SPC s`)
- `SPC s s` - Search buffer (consult-line)
- `SPC s p` - Search project (ripgrep)
- `SPC s i` - Search imenu
- `SPC s o` - Search outline

#### Project (`SPC p`)
- `SPC p p` - Switch project
- `SPC p f` - Find file in project
- `SPC p s` - Search in project
- `SPC p c` - Compile project
- `SPC p t` - Test project

#### Git (`SPC g`)
- `SPC g g` - Magit status
- `SPC g d` - Diff unstaged
- `SPC g c` - Commit
- `SPC g p/P` - Push/Pull
- `SPC g b` - Branch
- `SPC g l` - Log
- `SPC g B` - Blame

#### LSP (`SPC l`)
- `SPC l r` - Rename symbol
- `SPC l a` - Code actions
- `SPC l f` - Format buffer
- `SPC l d` - Find definition
- `SPC l R` - Find references
- `SPC l i` - Find implementation
- `SPC l S` - Restart LSP workspace

#### Code (`SPC c`)
- `SPC c c` - Compile
- `SPC c f` - Format buffer
- `SPC c r` - Comment/uncomment
- `SPC c x` - Execute code (quickrun)

#### Toggle (`SPC t`)
- `SPC t n` - Line numbers
- `SPC t w` - Whitespace mode
- `SPC t t` - Truncate lines
- `SPC t f` - Fullscreen

#### Open (`SPC o`)
- `SPC o t` - Terminal (vterm)
- `SPC o e` - Eshell
- `SPC o d` - Dired
- `SPC o p` - Treemacs

#### Help (`SPC h`)
- `SPC h f` - Describe function
- `SPC h v` - Describe variable
- `SPC h k` - Describe key
- `SPC h m` - Describe mode

### Local Leader (Comma) - Major Mode Specific

#### Python (`,`)
- `, c v` - Activate virtualenv
- `, c a` - Activate conda env
- `, t t` - Run pytest
- `, r b` - Black format
- `, r i` - Isort imports
- `, s s` - Start Python shell

#### Go (`,`)
- `, t t` - Test current
- `, t f` - Test file
- `, t p` - Test project
- `, r i` - Add import
- `, x r` - Run
- `, x b` - Build

#### Java (`,`)
- `, t t` - Test method
- `, t c` - Test class
- `, r o` - Organize imports
- `, d d` - Debug
- `, m c` - Maven clean
- `, m t` - Maven test

#### C/C++ (`,`)
- `, c c` - Compile
- `, f f` - Format with clang-format
- `, d d` - Start GDB
- `, d a` - Disassemble

#### JavaScript/TypeScript (`,`)
- `, r r` - Rename variable
- `, r e` - Extract function
- `, f f` - Prettier format
- `, n r` - NPM run script
- `, n i` - NPM install

#### Org Mode (`,`)
- `, t t` - Todo
- `, d d` - Deadline
- `, d s` - Schedule
- `, e e` - Export dispatch
- `, x x` - Execute code block
- `, l l` - Insert link
- `, c i/o` - Clock in/out

#### Markdown (`,`)
- `, p` - Preview
- `, i l` - Insert link
- `, i i` - Insert image
- `, t t` - Generate TOC

#### Docker (`,`)
- `, b` - Build image
- `, u` - Docker-compose up
- `, d` - Docker-compose down

#### SQL (`,`)
- `, s b` - Send buffer
- `, s r` - Send region
- `, c` - Connect
- `, f` - Format

## Customization

### Personal Settings

Create `~/.emacs.d/custom.el` for personal customizations:

```elisp
;; Custom settings
(setq user-full-name "Your Name"
      user-mail-address "your.email@example.com")

;; Override theme
(load-theme 'doom-tomorrow-night t)

;; Add to load path
(add-to-list 'load-path "~/my-elisp")
```

Then add to `init.el`:
```elisp
(when (file-exists-p (expand-file-name "custom.el" user-emacs-directory))
  (load-file (expand-file-name "custom.el" user-emacs-directory)))
```

### Disabling Features

Comment out unwanted modules in `init.el`:

```elisp
;; Disable Evil mode (if you prefer Emacs keybindings)
;; (require 'evil-config)
;; (require 'evil-local-leader)

;; Don't load Java support
;; (require 'lang-java)
```

**Note**: If you disable Evil mode, you'll use standard Emacs keybindings instead. Most functionality remains accessible through the default `C-c` and `M-x` bindings.

### Package Management with straight.el

This configuration uses **straight.el** instead of package.el for better reproducibility and version control.

#### Installing Additional Packages

Add packages to your configuration files using `use-package`:

```elisp
(use-package package-name
  :config
  (setq package-option value))
```

Since `straight-use-package-by-default` is enabled, all `use-package` declarations automatically use straight.el.

#### Updating Packages

Update all packages:
```elisp
M-x straight-pull-all         ; Pull latest changes
M-x straight-rebuild-all      ; Rebuild packages
```

Update a single package:
```elisp
M-x straight-pull-package RET package-name
M-x straight-rebuild-package RET package-name
```

#### Freezing Package Versions

Create a version lockfile for reproducibility:
```elisp
M-x straight-freeze-versions  ; Creates versions lockfile
```

This creates `~/.emacs.d/straight/versions/default.el` which you can commit to version control.

#### Advantages of straight.el

- **Reproducible**: Lock package versions with version files
- **Git-based**: Directly clone from Git repositories
- **Version control**: Easy to track package changes
- **Flexible**: Install from GitHub, GitLab, or local repositories
- **No waiting**: Packages are built on-demand, not pre-compiled

#### Installing from GitHub

```elisp
(use-package some-package
  :straight (:host github :repo "user/repo"))
```

#### Installing from Local Directory

```elisp
(use-package my-package
  :straight (:local-repo "~/path/to/package"))
```

## Troubleshooting

### Packages Not Installing

1. Rebuild a specific package:
   ```elisp
   M-x straight-rebuild-package RET package-name
   ```

2. Rebuild all packages:
   ```elisp
   M-x straight-rebuild-all
   ```

3. Check straight.el build logs:
   ```elisp
   M-x straight-get-recipe RET package-name
   ```

4. Clear build cache and rebuild:
   ```elisp
   M-x straight-prune-build
   M-x straight-rebuild-all
   ```

### LSP Not Working

1. Check if language server is installed:
   ```bash
   which pyright  # or gopls, clangd, etc.
   ```

2. Restart LSP workspace:
   ```elisp
   M-x lsp-workspace-restart
   ```

3. Check LSP logs:
   ```elisp
   M-x lsp-workspace-show-log
   ```

### Performance Issues

1. Increase GC threshold (in `early-init.el`):
   ```elisp
   (setq gc-cons-threshold (* 32 1024 1024))
   ```

2. Disable features you don't use

3. Use `M-x profiler-start` to identify slow operations

### Native Compilation Warnings

To suppress native compilation warnings:
```elisp
(setq native-comp-async-report-warnings-errors nil)
```

## Learning Resources

### Emacs Basics
- Built-in tutorial: `C-h t`
- Help system: `C-h ?`
- Describe key: `C-h k`
- Describe function: `C-h f`
- Describe variable: `C-h v`

### Package Documentation
- LSP: https://emacs-lsp.github.io/lsp-mode/
- Org Mode: https://orgmode.org/
- Magit: https://magit.vc/
- Projectile: https://docs.projectile.mx/

## Contributing

Feel free to customize this configuration for your needs. Submit issues or pull requests for improvements.

## License

This configuration is provided as-is under the MIT License.
