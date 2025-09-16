# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #enable flakes and nixf-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

 #------- bootloader
 # Use the GRUB 2 boot loader
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = false; # <-- disable this
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.default = 0;  # 0 = newest generation
  boot.loader.grub.timeout = 10;  # optional, 2 sec menu timeout
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.extraGrubInstallArgs = [ "--bootloader-id=GRUB" ];

  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev";# or "nodev" for efi only
  boot.loader.grub.configurationLimit = 3;
  #systemd-boot
  boot.loader.systemd-boot.enable = false;

  boot.loader.efi.canTouchEfiVariables = true;    # <-- keep this
 #-------

   
  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  #enable all firmware with unfree license
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.cpu.amd.updateMicrocode = true;
  nixpkgs.config.allowUnfree = true;

  # Graphics drivers for different systems
  hardware.graphics.enable = true;
  hardware.nvidia.open = true; #open = false for older GTX 10xx series and below
  services.xserver.videoDrivers = [ "intel" "amdgpu" "radeon" "nouveau" "nvidia" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  hardware.bluetooth.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  #zsh
  programs.zsh.enable = true;
  

  # Enable sound - pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  #users
  users.users.mathew = {
    isNormalUser = true;
    description = "Mathew";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  #ventoy
  nixpkgs.config.permittedInsecurePackages = [
      "ventoy-1.1.05"
  ];

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  #File manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Display manager with autologin
  services = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    cloudflare-warp.enable = true;
  };

  # Autologin
  services.displayManager.autoLogin = {
	enable = true;
	user = "mathew";
  };
  services.displayManager.defaultSession = "hyprland";

 programs.firefox.enable = true;


  #packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    foot
    micro
    gedit
    vscode
    zapzap
    dunst
    go
    lua
    neofetch
    quartus-prime-lite
    docker
    gimp3
    ventoy
    dunst
    rofi-wayland
    grim
    imagemagick 
    slurp
    hyprpaper 
    swappy
    wl-clipboard
    cliphist
    hyprlock 
    hyprpicker
    mpvpaper
    neovim
	sl
	blueman
	spicetify-cli
	spotify
  ];

  fonts.fontconfig.enable = true;

  #Flatpak applications
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo'';
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
