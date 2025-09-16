{ config, pkgs, ... }: {
  services.network-manager-applet.enable = true;

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    style = ''
      window#waybar {
        background: transparent;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #window {
        margin-top: 6px;
        padding-left: 10px;
        padding-right: 20px;
        border-radius: 10px;
        transition: none;
        color: white;
        background: transparent;
      }

      #workspaces {
        margin-top: 6px;
        margin-left: 12px;
        margin-bottom: 0px;
        font-size: 20px;
        font-weight: 500;
        border-radius: 10px;
        background: #000000;
        transition: none;
        border: 2px solid #e3967b;
      }

      #workspaces button {
        transition: none;
        color: #e3967b;
        background: #000000;
        border-radius: 100px;
      }

      #workspaces button.active {
        color: #e3967b;
      }

      #workspaces button:hover {
        transition: none;
        box-shadow: inherit;
        text-shadow: inherit;
        color: #e0dd8b;
        border-color: #d65d0e;
      }

      #custom-launcher {
        font-size: 24px;
        margin-top: 6px;
        margin-left: 8px;
        padding-left: 10px;
        padding-right: 5px;
        border-radius: 10px;
        transition: none;
        color: #e3967b;
        background: #000000;
      }

      #network,
      #pulseaudio,
      #battery,
      #battery#bat2,
      #backlight,
      #clock,
      #memory,
      #cpu,
      #temperature.gpu,
      #temperature.cpu,
      #keyboard-state,
      #idle_inhibitor,
      #custom-suspend,
      #custom-poweroff,
      #custom-media,
      #tray,
      #custom-warp,
      #custom-wireguard {
        margin-top: 6px;
        margin-left: 8px;
        margin-bottom: 0px;
        padding-left: 10px;
        padding-right: 10px;
        border-radius: 10px;
        transition: none;
        background: #000000;
        border: 2px solid #e3967b;
      }

      #network,
      #backlight,
      #clock,
      #cpu,
      #temperature.gpu,
      #keyboard-state,
      #idle_inhibitor,
      #custom-poweroff,
      #custom-media,
      #tray,
      #custom-wireguard {
        color: #e3967b;
        border: 2px solid #e3967b;
      }

      #pulseaudio,
      #battery,
      #battery#bat2,
      #memory,
      #temperature.cpu,
      #custom-suspend,
      #custom-warp {
        color: #e3967b;
      }

      #mpris {
        margin-top: 6px;
        margin-bottom: 0px;
        padding-left: 10px;
        padding-right: 10px;
      }

      #battery.critical:not(.charging) {
        background-color: #000000;
        color: #161320;
        animation-name: blink;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
          background-color: #bf616a;
          color: #b5e8e0;
        }
      }

      #custom-warp.connected,
      #custom-warp.connecting,
      #custom-warp.disconnected,
      #custom-warp.error {
        background: #000000;
        color: #e3967b;
      }

      #custom-wireguard.connected,
      #custom-wireguard.connecting,
      #custom-wireguard.disconnected,
      #custom-wireguard.error {
        background: #000000;
        color: #e3967b;
      }

      * {
        border: none;
        border-radius: 20;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 16px;
        min-height: 20px;
      }
           
    '';

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 0;

        modules-left = [
          "custom/launcher"
          "pulseaudio"
          "idle_inhibitor"
          "custom/suspend"
          "custom/poweroff"
          "custom/warp"
          "custom/wireguard"
          "mpris"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "network"
          "memory"
          "cpu"
          "temperature#cpu"
          "temperature#gpu"
          "keyboard-state"
          "battery"
          "battery#bat2"
          "clock"
        ];

        "custom/launcher" = {
          format = " ";
          on-click = "sh ~/.config/rofi/launchers/type-2/launcher.sh";
          on-click-right = "killall rofi";
        };

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = true;
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
          active = "";
          sort-by-number = true;
        };

        "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 20;
          separate-outputs = true;
          rewrite = {
            "(.*) — Mozilla Firefox" = " $1";
          };
        };

        mpd = {
          format =
            "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
          format-disconnected = "Disconnected ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          unknown-tag = "N/A";
          interval = 2;

          consume-icons.on = " ";
          random-icons = {
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons.on = " ";
          single-icons.on = " 1 ";
          state-icons = {
            paused = "";
            playing = "";
          };

          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };

        "custom/poweroff" = {
          format = " ";
          on-click = "systemctl poweroff";
        };

        "custom/suspend" = {
          format = "";
          on-click = "systemctl suspend";
        };

        idle_inhibitor = {
          format = "{icon} ";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        tray.spacing = 10;

        clock = {
          tooltip-format =
            "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%H:%M}";
          format-alt = "{:%m-%d-%Y}";
          interval = 60;
        };

        cpu = {
          interval = 5;
          format = "{usage}% ";
          tooltip = false;
          max-length = 10;
          on-click = "kitty -- btop";
        };

        memory = {
          interval = 5;
          format = "{}% ";
          max-length = 10;
        };

        "temperature#cpu" = {
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 70;
          format = " {temperatureC}°C {icon}";
          format-icons = [ "" ];
        };

        "temperature#gpu" = {
          hwmon-path = "/sys/class/hwmon1/temp1_input";
          critical-threshold = 80;
          format = " {temperatureC}°C {icon}";
          format-icons = [ "" ];
        };

        battery = {
          states = {
            full = 100;
            good = 95;
            decent = 50;
            warning = 30;
            critical = 20;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{icon} {time}";
          format-time = "{H} h {M} min";
          format-icons = [ "" "" "" "" "" ];
        };

        "battery#bat2" = {
          bat = "BAT2";
        };

        network = {
          tooltip = false;
          format-wifi = "{essid} ";
          format-ethernet = "󰌗 {ipaddr}/{cidr}";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click = "nm-connection-editor";
        };

        pulseaudio = {
          tooltip = false;
          scroll-step = 5;
          format = "{icon} {volume}% {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰝟 {icon} {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        "custom/warp" =
          let
            warp-status = pkgs.writeShellScript "warp-status" ''
              #!/bin/bash
              status=$(${pkgs.cloudflare-warp}/bin/warp-cli status 2>/dev/null | grep "Status update:" | cut -d: -f2 | xargs)
              case "$status" in
                "Connected") echo '{"text": "󰖂 WARP", "class": "connected", "tooltip": "Warp VPN: Connected"}' ;;
                "Connecting") echo '{"text": "󰇘 WARP", "class": "connecting", "tooltip": "Warp VPN: Connecting..."}' ;;
                "Disconnected") echo '{"text": " WARP", "class": "disconnected", "tooltip": "Warp VPN: Disconnected"}' ;;
                *) echo '{"text": " WARP", "class": "error", "tooltip": "Warp VPN: Status unknown"}' ;;
              esac
            '';
            warp-toggle = pkgs.writeShellScript "warp-toggle" ''
              #!/bin/bash
              status=$(${pkgs.cloudflare-warp}/bin/warp-cli status 2>/dev/null | grep "Status update:" | cut -d: -f2 | xargs)
              case "$status" in
                "Connected") ${pkgs.cloudflare-warp}/bin/warp-cli disconnect ;;
                "Disconnected") ${pkgs.cloudflare-warp}/bin/warp-cli connect ;;
                "Connecting") ${pkgs.cloudflare-warp}/bin/warp-cli disconnect ;;
                *) ${pkgs.cloudflare-warp}/bin/warp-cli connect ;;
              esac
            '';
          in {
            return-type = "json";
            exec = "${warp-status}";
            on-click = "${warp-toggle}";
            interval = 5;
            tooltip = true;
          };

        "custom/wireguard" =
          let
            wg-status = pkgs.writeShellScript "wg-status" ''
              #!/bin/bash
              INTERFACE="wg0"
              if ip link show "$INTERFACE" &>/dev/null; then
                echo '{"text": "󰖂 WG", "class": "connected", "tooltip": "WireGuard: Connected"}'
              else
                echo '{"text": " WG", "class": "disconnected", "tooltip": "WireGuard: Disconnected"}'
              fi
            '';
            wg-toggle = pkgs.writeShellScript "wg-toggle" ''
              #!/bin/bash
              INTERFACE="wg0"
              if ip link show "$INTERFACE" &>/dev/null; then
                wg-quick down wg0
              else
                wg-quick up wg0
              fi
            '';
          in {
            return-type = "json";
            exec = "${wg-status}";
            on-click = "${wg-toggle}";
            interval = 5;
            tooltip = true;
          };

        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "";
            spotify = "";
            firefox = "";
          };
          status-icons = {
            paused = "";
            playing = "";
          };
          max-length = 30;
          on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
        };
      };
    };
  };
}
