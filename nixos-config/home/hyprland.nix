{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # --- General settings ---
      general = {
        border_size = 5;
        "col.active_border" = "rgba(e3967bff) rgba(2222ccff) 90deg";
      };

      monitor = "eDP-1,preferred,auto,1";

      # --- Key bindings ---
      bind = [
        # Window Management
        "SUPER, Q, killactive"
        "SUPER SHIFT, F, fullscreen"
        "SUPER, SPACE, togglefloating"

        # Launch Applications
        "SUPER, Return, exec, kitty"
        "SUPER, B, exec, zen"
        "SUPER, Z, exec, zeditor"
        "SUPER, E, exec, thunar"

        # Focus Windows
        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        # Move Windows
        "SUPER SHIFT, h, movewindow, l"
        "SUPER SHIFT, l, movewindow, r"
        "SUPER SHIFT, k, movewindow, u"
        "SUPER SHIFT, j, movewindow, d"
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"

        # Workspaces (1–10)
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        # Move to Workspace
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        # Scroll Workspaces
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"

        # App launcher
        "SUPER, D, exec, rofi -show drun"
        "SUPER SHIFT, D, exec, rofi -show run"

        # Clipboard Clipse
        "SUPER, V, exec, kitty --class clipse -e clipse"

        # Screenshots
        "SUPER, PRINT, exec, hyprshot -m output"
        "SUPER SHIFT, PRINT, exec, hyprshot -m region"
      ];

      # Mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      # Keybindings that repeat on hold
      bindel = [
        # Volume Control
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Brightness Control
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      # Workspace names
      workspace = [
        "1, name:1"
        "2, name:2"
        "3, name:3"
        "4, name:4"
        "5, name:5"
        "6, name:6"
        "7, name:7"
        "8, name:8"
        "9, name:9"
        "10, name:10"
      ];

      # Animations
      #border angle =>> animated border
      animations = {
 		 enabled = true;
  		 bezier = "defaultBezier, 0.4, 1, 0.2, 1.05";
         animation = [
         	"windows, 1, 7, defaultBezier, popin 50%"
         	"windowsOut, 1, 7, default, popin 80%"
         	"border, 1, 10, default"
         	"fade, 1, 7, default"
            "workspaces, 1, 6, defaultBezier"
         ];
  	 };
    };

    # Extra raw config
    extraConfig = ''
      # Exec-once programs
      exec-once = ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target
      exec-once = hyprlock &
  
      # Clipboard window config
      windowrule = float, class:^(clipse)$
      windowrule = size 622 652, class:^(clipse)$
      windowrule = stayfocused, class:^(clipse)$

      # Network manager gui
      windowrule = float, class:^(nm-connection-editor)$

      # Touchpad inverse scrolling
      input {
        touchpad {
          natural_scroll = true;
        }
      }
    '';
  };

  # Cursor theme
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;

    hyprcursor = {
      enable = true;
      size = config.home.pointerCursor.size;
    };

    x11.enable = true;
  };

  xdg.enable = true;
}
