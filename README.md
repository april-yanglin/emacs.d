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
- Modern UI with doom-themes and doom-modeline
- LSP integration for intelligent code completion
- Git integration (magit, git-gutter, diff-hl)
- Project management (projectile)
- Smart completion (company, vertico, orderless)
- Syntax checking (flycheck)
- Code snippets (yasnippet)
- Tree-sitter for better syntax highlighting
- Multiple cursors
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
   - Install `use-package`
   - Download and install all packages from MELPA
   - Compile configuration files
   - This may take a few minutes

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

### General
- `C-x g` - Magit status
- `C-s` - Search (consult-line)
- `C-c p` - Projectile commands
- `C-c f` - Format buffer
- `M-;` - Comment/uncomment

### LSP (when in a programming buffer)
- `C-c l` - LSP command prefix
- `M-.` - Go to definition
- `M-,` - Go back
- `M-?` - Find references
- `C-c l r r` - Rename symbol
- `C-c l a a` - Code actions

### Org Mode
- `C-c l` - Store link
- `C-c a` - Agenda
- `C-c c` - Capture
- `C-c C-c` - Execute code block
- `C-c n f` - Org-roam find node
- `C-c n i` - Org-roam insert node

### Python
- `C-c t t` - Run pytest

### Go
- `C-c t t` - Run current test
- `C-c t f` - Test current file

### Docker
- `C-c d` - Docker management
- `C-c C-b` - Build Docker image (in Dockerfile)

### Multiple Cursors
- `C->` - Mark next like this
- `C-<` - Mark previous like this
- `C-c C-<` - Mark all like this

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
;; Don't load Java support
;; (require 'lang-java)
```

## Troubleshooting

### Packages Not Installing

1. Refresh package contents:
   ```elisp
   M-x package-refresh-contents
   ```

2. Reinstall packages:
   ```elisp
   M-x package-reinstall RET package-name
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
