{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.neovim = {
    enable = true;

    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
    
    extraPackages =
      with pkgs;
      [
        cmake # some plugins requiring cmake

        # Language servers
        lua-language-server # Lua LSP
        nixd # Nix LSP
        efm-langserver # General purpose LSP
        pyright # Python LSP
        typos-lsp # Spell checker LSP

        # Python tools
        ruff # Python linter/formatter with built-in language server

        # Formatters & Linters (used by efm-langserver)
        stylua # Lua formatter
        hadolint # Dockerfile linter
        actionlint # GitHub Actions linter

        # Node.js-based language servers
        astro-language-server # Astro
        emmet-language-server # Emmet
        prisma-language-server # Prisma
        stylelint # CSS linter
        stylelint-lsp # Stylelint LSP
        svelte-language-server # Svelte
        tailwindcss-language-server # Tailwind CSS
        textlint # Natural language linter
        vscode-langservers-extracted # HTML/CSS/JSON/ESLint
        vue-language-server # Vue.js
        yaml-language-server # YAML
      ]; 
  };
}
