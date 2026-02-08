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
  };
}
