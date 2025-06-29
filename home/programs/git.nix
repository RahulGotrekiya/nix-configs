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
          "/mnt/work/study/material/Courses/00 Practice/JavaScript/complete-javascript-course-master/js-small-projects"
        ];
      };
    };
    
    # signing = {
    #   key = "GPG_KEY_ID";
    #   signByDefault = true;
    # };
  };
}
