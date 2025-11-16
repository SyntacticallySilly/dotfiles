# Syndot & Synvim

**An advanced, opinionated, and performance-focused dotfiles setup for Termux.**

This repository contains the configuration files for **Syndot**, a comprehensive command-line environment, and **Synvim**, a highly customized Neovim setup. The entire system is designed to provide a modern, efficient, and visually appealing experience on Android devices using Termux.

*NOTE: This project is still in its alpha stages. There may be inconsistencies and problems. Contributions are welcome!*

## Features

-   **Modern Shell**: A powerful Zsh setup with live autocompletion, syntax highlighting, and fzf-powered tab completion.
-   **Efficient Workflow**: A modal, mnemonic-driven keybinding system for both the shell (Zellij) and the editor (Neovim).
-   **Beautiful UI**: A clean, modern, and transparent aesthetic across all tools, with a custom theme switcher.
-   **Integrated Tooling**: A curated set of command-line tools for file management, searching, and system information.
-   **Powerful Neovim**: A fast, lazy-loaded Neovim configuration with deep LSP integration, advanced navigation, and a focus on user experience.

## Documentation

To learn how to use this setup, please refer to the detailed documentation:

-   **[Syndot: The Comprehensive Guide](syndot.md)**: For the general shell environment, tools, and scripts.
-   **[Synvim: The Opinionated Neovim Guide](synvim.md)**: For the Neovim configuration, plugins, and keybindings.

## Installation

To install Syndot and Synvim, run the following command in your Termux home directory (`~`):

```bash
pkg install git stow && git clone https://github.com/SyntacticallySilly/dotfiles.git && bash ~/dotfiles/install.sh
```

This will automatically:
1.  Clone this repository to `~/dotfiles`.
2.  Install all necessary dependencies.
3.  Remove any conflicting default configurations.
4.  Symlink all the new configurations into place using `stow`.
5.  Set Zsh as your default shell and reload your session.

## Updating

To keep your setup up-to-date, you can run the `update.sh` script or use the `sysup` alias. This will pull the latest changes from the repository, re-apply the configurations, and update all your system packages.