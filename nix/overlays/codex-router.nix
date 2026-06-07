final: _prev: {
  codex-router = final.buildNpmPackage rec {
    pname = "codex-router";
    version = "1.0.0";

    src = final.fetchFromGitHub {
      owner = "oli799";
      repo = "codex-router";
      rev = "1c7a3289196dbd8ef1f829b73bf5f417cbfe6761";
      hash = "sha256-DljHQFM8hLE3Hs+qGiV+wRf3Y8EqP6uDO4vPo6s7hJ8=";
    };

    npmDepsHash = "sha256-UFVFe/JN+u/fFHoi5LT2nrBUglZBsZeNBIGTPknDruI=";

    meta = with final.lib; {
      description = "Switch codex accounts without leaving your terminal";
      homepage = "https://github.com/oli799/codex-router";
      license = licenses.mit;
      maintainers = [ ];
      mainProgram = "codex-router";
    };
  };
}
