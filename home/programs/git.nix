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
      safe = {
        directory = [
          "/mnt/work/personal/Obsidian Vault"
          "/mnt/work/study/Projects/PSDs/MacaulayTreeHouse"
        ];
      };
    };
    
    # signing = {
    #   key = "GPG_KEY_ID";
    #   signByDefault = true;
    # };
  };
}
