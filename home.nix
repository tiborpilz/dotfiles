{ config, pkgs, ...}:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

in {
  home.packages = with pkgs; [
    direnv
    git
    gnupg
    silver-searcher
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Tibor Pilz";
    userEmail = "tibor@pilz.berlin";
  };

  programs.firefox.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };

  programs.tmux = {
    enable = true;
  };

  home.file.".tmux.conf" = {
    source = ./tmux/.tmux.conf;
  };

  programs.neovim = {
    enable = true;
  };

  xdg.configFile.nvim = {
    source = ./neovim/.config/nvim;
    recursive = true;
  };
}
