{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "Fira Code";
    };
    settings = {
      background_opacity = "0.91";
    };
  };


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;    
    syntaxHighlighting.enable = true; 

    shellAliases = {
      # Useful shortcuts
      ll = "eza -l --icons --git -a";
      lt = "eza --tree --level=2 --long --icons --git";
      cat = "bat";
      grep = "rg";

      # System shortcuts
      rebuild = "sudo nixos-rebuild switch --flake .#nixos-b550m"; 
      gc = "git commit -m";
      gs = "git status";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      add_newline = true;
      
      format = "$hostname$username$directory$git_branch$git_status$fill$lua$python$jobs$cmd_duration$line_break$character";

      character = {
        success_symbol = "[➜](bold green)";
      };

      package = {
        disabled = true;
      };

      hostname = {
        ssh_only = false;
        format = "[NixOS]($style) ";
        style = "blue bold";
        trim_at = ".";
        disabled = false;
      };

      username = {
        style_user = "blue bold";
        style_root = "red bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };
    };
  };



  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    eza
    bat
    ripgrep
    fd
    btop
    zip
    unzip
    jq
    fzf
    fastfetch
  ];
}