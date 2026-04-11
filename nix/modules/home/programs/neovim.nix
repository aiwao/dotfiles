{
  pkgs,
  lib,
  config,
  dotfilesDir,
  helpers,
  ...
}:
let
  nvimDotfilesDir = "${dotfilesDir}/nvim";
  nvimConfigDir = "${config.xdg.configHome}/nvim";

  jolPkg = pkgs.jol;
  jolJar = "${jolPkg}/share/jol-cli/jol-cli.jar";
  javaDbgPkg = pkgs.vscode-extensions.vscjava.vscode-java-debug;
  javaDbgJar = "${javaDbgPkg}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-0.53.1.jar";
in
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
        basedpyright # Python LSP
        typos-lsp # Spell checker LSP
        lemminx # XML LSP

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

        jolPkg # for jdtls
        javaDbgPkg
      ]; 
  };

  home.sessionVariables = {
    NEOVIM_JOL_JAR = jolJar;
    NEOVIM_JAVA_DEBUG = javaDbgJar;
  };

  # Create symlink to NeoVim configuration in dotfiles (bypassing Nix store)
  home.activation.linkNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${helpers.activation.mkLinkForce}
    link_force "${nvimDotfilesDir}" "${nvimConfigDir}"
  '';
}
