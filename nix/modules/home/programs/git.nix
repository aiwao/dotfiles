{
  config,
  helpers,
  ...
}:
let
  user = helpers.mkUser config;

  deltaSettings = {
    dark = true;
    syntax-theme = "GitHub";
    diff-so-fancy = true;
    keep-plus-minus-markers = true;
    side-by-side = true;
    hunk-header-style = "omit";
    line-numbers = true;
  };
in
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = deltaSettings;
  };

  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user = {
        name = user.username;
        inherit (user) email;
      };

      core = {
        autocrlf = "input";
        editor = "nvim";
        ignorecase = false;
        untrackedCache = false;
        fsmonitor = false;
      };

      ghq = {
        root = [
          "~/ghq"
        ];
      };

      color.ui = "auto";

      tag.sort = "version:refname";

      push = {
        default = "simple";
        autoSetupRemote = true;
        useForceIfIncludes = true;
      };

      commit.verbose = true;

      credential = {
        "https://github.com".helper = [
          ""
          "!gh auth git-credential"
        ];
        "https://gist.github.com".helper = [
          ""
          "!gh auth git-credential"
        ];
      };

      fetch = {
        writeCommitGraph = true;
        prune = true;
        pruneTags = true;
        all = true;
      };

      init.defaultBranch = "main";

      diff = {
        lockb = {
          textconv = "bun";
          binary = true;
        };
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      rebase = {
        autoStash = true;
        autoSquash = true;
        updateRefs = true;
      };

      merge = {
        ff = false;
        conflictstyle = "zdiff3";
      };

      pull.rebase = true;

      remote.pushDefault = "origin";

      column.ui = "auto";

      branch.sort = "-committerdate";

      help.autocorrect = "prompt";

      rerere = {
        enabled = true;
        autoupdate = true;
      };
    };

    ignores = [
      # Environment
      ".venv"
      ".direnv"

      # macOS
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"
      "Icon"
      "._*"
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      # Python
      "__pycache__/"
      "*.py[cod]"
      "*$py.class"
      "*.so"
      ".Python"
      "build/"
      "develop-eggs/"
      "dist/"
      "downloads/"
      "eggs/"
      ".eggs/"
      "lib64/"
      "parts/"
      "sdist/"
      "var/"
      "wheels/"
      "pip-wheel-metadata/"
      "share/python-wheels/"
      "*.egg-info/"
      ".installed.cfg"
      "*.egg"
      "MANIFEST"
      "*.manifest"
      "*.spec"
      "pip-log.txt"
      "pip-delete-this-directory.txt"
      "htmlcov/"
      ".tox/"
      ".nox/"
      ".coverage"
      ".coverage.*"
      ".cache"
      "nosetests.xml"
      "coverage.xml"
      "*.cover"
      "*.py,cover"
      ".hypothesis/"
      ".pytest_cache/"
      "*.mo"
      "*.pot"
      "*.log"
      "local_settings.py"
      "db.sqlite3"
      "db.sqlite3-journal"
      "instance/"
      ".webassets-cache"
      ".scrapy"
      "docs/_build/"
      "target/"
      ".ipynb_checkpoints"
      "profile_default/"
      "ipython_config.py"
      ".python-version"
      "__pypackages__/"
      "celerybeat-schedule"
      "celerybeat.pid"
      "*.sage.py"
      ".env"
      "env/"
      "venv/"
      "ENV/"
      "env.bak/"
      "venv.bak/"
      ".spyderproject"
      ".spyproject"
      ".ropeproject"
      "/site"
      ".mypy_cache/"
      ".dmypy.json"
      "dmypy.json"
      ".pyre/"

      # Claude Code
      "**/.claude/settings.local.json"
      "**/CLAUDE.local.md"
    ];
  };
}
