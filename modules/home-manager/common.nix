{
  inputs,
  pkgs,
  username,
  ...
}:
{
  imports = with inputs.self.homeManagerModules; [
    home
    shell

    programs.alacritty
    programs.direnv
    programs.neovim
    programs.tmux

  ];

  home.packages = with pkgs; [
    # custom scripts
    editconf
    rmshit # bypasses homemanager bug
    colgarb

  ];

  home.file.".config/background".source = ../../hosts/${username}/wallpaper.jpg;
}
