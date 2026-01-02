{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      
      ../../modules/nixos/core.nix
      ../../modules/nixos/desktop.nix
      ../../modules/nixos/gaming.nix
    ];

  home-manager.users.victru = {
    imports = [ 
      ../../modules/home/default.nix 
      ../../modules/home/terminal.nix
      ../../modules/home/coding.nix
    ];
  };

  # Specific config for my LG monitor, exports edid to the Kernel & GPU to force 75hz
  hardware.firmware = [
    (pkgs.runCommand "custom-edid" {} ''
      mkdir -p $out/lib/firmware/edid
      cp ${./edid.bin} $out/lib/firmware/edid/edid.bin
    '')
  ];

  boot.kernelParams = [ 
    "drm.edid_firmware=HDMI-A-1:edid/edid.bin"
    "video=HDMI-A-1:e"
  ];
  
  system.stateVersion = "25.11";
}