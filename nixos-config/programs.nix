{ config, pkgs, inputs, ... }: {
  # ─────────────────────────────────────────────
  # User Packages
  home.packages = with pkgs; [
    # Essentials
    fastfetch brightnessctl waybar wl-clipboard hyprshot zed-editor networkmanagerapplet
    # Zen Browser
    inputs.zen-browser.packages."${system}".twilight
    # Archive Tools
    file-roller p7zip unrar unzip zip gzip bzip2 xz
    # Utilities
    ranger prismlauncher obs-studio vlc code-cursor claude-code
    pavucontrol playerctl light btop cloudflare-warp appflowy
    quartus-prime-lite qbittorrent libreoffice wireguard-tools
    tree gcc openjdk17 bottles
  ];

  # ─────────────────────────────────────────────
  # ZSH Configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      ".." = "cd ..";
      nairobi = "sudo nixos-rebuild switch && sudo ~/systemscripts/prune-generations.sh";
      rome = "sudo nixos-rebuild switch --rollback";
      oslo = "sudo nixos-rebuild switch";
    };

  initContent = ''
    export PATH=~/apps/spotify/bin:$PATH
  	PromptColor='%F{135}' 
  	UserColor='%F{213}'
  	RESET='%f'
  	PROMPT="''${UserColor}[''${LIME}%n@%m:%~''${PromptColor}]''${RESET}$ "

 	 # Keybindings
  	bindkey "\e[1;5C" forward-word
  	bindkey "\e[1;5D" backward-word

  	# System Info
  	fastfetch
 '';
 };

  # ─────────────────────────────────────────────
  # Kitty Terminal
  programs.kitty = {
    enable = true;
    font = {
      size = 14;
      name = "JetBrainsMono Nerd Font";
    };
    themeFile = "shadotheme";
    settings = {
      background_opacity = "1";
      confirm_os_window_close = 0;
    };
  };

  # ─────────────────────────────────────────────
  # Session Variables
  home.sessionVariables = {
    TERMINAL = "kitty";
    LM_LICENSE_FILE = "/home/mathew/questa_license.dat"; #license of quartus??
  };

  # ─────────────────────────────────────────────
  # Git Configuration
  programs.git = {
    enable = true;
    userName = "Mat-hew-24";
    userEmail = "amonline2005@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # ─────────────────────────────────────────────
  # Nix Helper (nh)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/mathew/nixos-config";
  };

  # ─────────────────────────────────────────────
  # Wallpaper Service
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [ "/home/mathew/Pictures/city.jpg" ];
      wallpaper = [ "eDP-1,/home/mathew/Pictures/city.jpg" ];
    };
  };

  # ─────────────────────────────────────────────
  # Clipboard Manager
  services.clipse.enable = true;
                       
  # ─────────────────────────────────────────────
  # Zed Editor
  programs.zed-editor.enable = true;

  # ─────────────────────────────────────────────
  # Dark Mode Settings
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # ─────────────────────────────────────────────
  # GTK Theme
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  #ricing
  # ─────────────────────────────────────────────

  #rofi
  # ───────────────────────────────────────────── 
  programs.rofi = {
    enable = true;
    theme = "~/.config/rofi/rofiriced.rasi";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = false;
      font = "JetBrainsMono Nerd Font 18";
    };
  };

  #dunst
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Terminus Bold 24";  # Slightly larger for retro style
        transparency = 12;                    # Slightly more transparency for softness
        frame_color = "#e3967b";              # Your original frame color retained
        separator_color = "frame";
        corner_radius = 0;                   # More rounded corners for a retro card look
        padding = 16;                        # Increased padding for spacious text
        horizontal_padding = 18;
        text_icon_padding = 8;                # More space between icon and text
        line_height = 1;                    # Improved line height for readability
        frame_width = 5;                      # Thicker frame for a solid bordered look
        icon_position = "left";
        word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        gap_size = 10;                       # More gap between notifications
        sort = "yes";
        indicate_hidden = "yes";
        show_indicators = "yes";
      };
      urgency_low = {
        background = "#171c85";               # Original dark blue
        foreground = "#e3967b";               # Original coral text
        frame_color = "#e3967b";              # Coral frame
        timeout = 6;                         # Slightly longer timeout for retro ease
      };
      urgency_normal = {
        background = "#0f124d";               # Original navy blue
        foreground = "#e3967b";               # Original coral text for contrast
        frame_color = "#e3967b";              # Coral frame border
        timeout = 9;                         # Increased for readability
      };
      urgency_critical = {
        background = "#e3967b";               # Coral background
        foreground = "#171c85";               # Reverse dark blue text for contrast
        frame_color = "#e3967b";              # Thick coral border
        timeout = 0;                        # Persistent
      };
    };
  };
  
  
  
  # ─────────────────────────────────────────────
  
}
