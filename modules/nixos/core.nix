{ pkgs, config, ... }:

{
  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."net.ipv4.ip_forward" = 1;
    kernelModules = [ "ntsync" ];
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 7;
        extraEntries = ''
          menuentry "EndeavourOS (SSD 240gb)" {
          search --set=root --fs-uuid 0D33-7BA0

          chainloader /EFI/endeavouros/grubx64.efi
          }
          menuentry "BIOS / UEFI Firmware Settings" {
            fwsetup
          }
        '';
      };
    };
  };

  # Network and Locale
  networking.hostName = "nixos-b550m";
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  services.blueman.enable = true;
  time.timeZone = "America/Fortaleza";
  i18n.defaultLocale = "pt_BR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # User definition
  users.users.victru = {
    isNormalUser = true;
    description = "Victor";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  
  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Essential system packages (root) 
  environment.systemPackages = with pkgs; [
    vim wget git htop usbutils
  ];
  environment.variables.EDITOR = "vim";
}