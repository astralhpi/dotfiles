{}: {
  enable = true;
  userName = "Jake(Jaehak Song)";
  userEmail = "jake@heybit.io";
  aliases = {
    lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    permission-reset = "!git diff -p -R --no-ext-diff --no-color | grep -E \"^(diff|(old|new) mode)\" --color=never | git apply";
  };
  extraConfig = {
    core = {
      editor = "nvim";
    };
    "mergetool \"nvimdiff\"" = {
      cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" \"$MERGED\"";
    };
    merge = {
      tool = "nvimdiff";
    };
    mergetool = {
      prompt = true;
    };
    diff = {
      tool = "nvimdiff";
    };
    difftool = {
      prompt = false;
    };
    pull = {
      rebase = true;
    };
    push = {
      autoSetupRemote = true;
    };
    init = {
      defaultBranch = "main";
    };
    "delta \"delta-styles\"" = {
      syntax-theme = "Dracula";
      dark = true;
      side-by-side = true;
      navigate = true;
      keep-plus-minus-markers = true;
      hyperlinks = true;
      file-added-label = "[+]";
      file-copied-label = "[==]";
      file-modified-label = "[*]";
      file-removed-label = "[-]";
      file-renamed-label = "[->]";
      file-style = "omit";
      zero-style = "syntax";
      commit-decoration-style = "#11ce16 box";
      commit-style = "#ffd21a bold italic";
      hunk-header-decoration-style = "#1688f0 box ul";
      hunk-header-file-style = "#c63bee ul bold";
      hunk-header-line-number-style = "#ffd21a box bold";
      hunk-header-style = "file line-number syntax bold italic";
      line-numbers = true;
      line-numbers-left-format = "{nm:>1}|";
      line-numbers-left-style = "#1688f0";
      line-numbers-minus-style = "#ff0051 bold";
      line-numbers-plus-style = "#03e57f bold";
      line-numbers-right-format = "{np:>1}|";
      line-numbers-right-style = "#1688f0";
      line-numbers-zero-style = "#aaaaaa italic";
      minus-emph-style = "syntax bold #b80000";
      minus-style = "syntax #5d001e";
      plus-emph-style = "syntax bold #007800";
      plus-style = "syntax #004433";
      whitespace-error-style = "#280050";
    };
  };
  lfs = {
    enable = true;
  };
  delta = {
    enable = true;
    options = {
      dart = true;
      features = "delta-styles";
    };
  };
}

