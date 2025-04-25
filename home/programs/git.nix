{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "rahul gotrekiya";
    userEmail = "121397381+RahulGotrekiya@users.noreply.github.com";
    
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = false;
      push.autoSetupRemote = true;
      core.editor = "nvim";
    };
    
    # signing = {
    #   key = "GPG_KEY_ID";
    #   signByDefault = true;
    # };
  };
}
