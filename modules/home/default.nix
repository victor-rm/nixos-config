{ pkgs, inputs, ... }:

{
  home.username = "victru";
  home.homeDirectory = "/home/victru";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "codium";
    BROWSER = "zen"; 
  };

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  services.syncthing = {
    enable = true;
  };
}