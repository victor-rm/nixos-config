{ pkgs, inputs, ... }:

{
  # X11 and KDE Plasma
  services.xserver = {
    enable = true;
    # Force custom resolution on X11
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --newmode "2560x1080_RB" 221.75 2560 2608 2640 2688 1080 1083 1088 1100 +hsync -vsync
      ${pkgs.xorg.xrandr}/bin/xrandr --addmode HDMI-1 "2560x1080_RB"
      ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --mode "2560x1080_RB"
    '';
    xkb = { layout = "us"; variant = "intl"; };
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  console.useXkbConfig = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Programs 
  environment.systemPackages = with pkgs; [
    vesktop
    bitwarden-desktop
    vivaldi
    chromium
    obsidian
    youtube-music
    zapzap
    telegram-desktop
    spotify
    calibre
    kdePackages.kcalc
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    super-productivity
  ];
  
  programs.firefox.enable = true;

  services.printing.enable = true;

  # Fonts
  fonts = {
    fontDir.enable = true;
    
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans # Caracteres Japaneses/Chineses
      noto-fonts-color-emoji
      liberation_ttf
      inter
      nerd-fonts.jetbrains-mono 
      nerd-fonts.fira-code
      maple-mono.truetype
      maple-mono.NF-unhinted
      maple-mono.NF-CN-unhinted
    ];

    # Define: System-wide Fonts
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" "Liberation Serif" ];
        sansSerif = [ "Noto Sans" "Inter" ];
        monospace = [ "Maple Mono NF" "JetBrainsMono Nerd Font" ]; 
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}