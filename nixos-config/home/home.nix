{ config, pkgs, inputs, ... }:

{
	imports = [
		./hyprland.nix
		./programs.nix
		./waybar.nix
		./fonts.nix
	];

	home.username = "mathew";
	home.homeDirectory = "/home/mathew";
    programs.home-manager.enable = true;
	home.stateVersion = "25.05";
}
