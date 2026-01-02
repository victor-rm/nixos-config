{ pkgs, ... }:

{
  # GPU driver
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.enableAllFirmware = true;
  boot.initrd.kernelModules = ["amdgpu"];

  # Games
  environment.systemPackages = with pkgs; [
    osu-lazer-bin
    prismlauncher
    waydroid-helper
  ];

  programs.steam.enable = true;

  # Waydroid
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };
}