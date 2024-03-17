{ pkgs, ... }:
let
  nix-snowflake = ./nix-snowflake.svg;
in
{
  xdg.configFile."waybar/rose-pine-moon.css".source = ./rose-pine-moon.css;

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        output = [ "DP-3" "eDP-1" ];
        position = "top";
        height = 40;
        modules-left = [
          "custom/logo"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "custom/spotify" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "clock"
          "tray"
        ];
        margin = "5";
        spacing = 10;
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-full = "";
          format-icons = [ "" "" "" "" "" ];
        };
        clock = {
          format = "{:%H:%M:%S}";
          tooltip-format = "<big>{:%d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          interval = 5;
        };
        "custom/logo" = {
          format = "  ";
          tooltip = false;
        };
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          disable-scroll = true;
          format = "{icon}";
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
            spotify = "";
          };
          persistent-workspaces = {
            "*" = 10;
          };
          show-special = true;
        };
        "hyprland/window" = {
          format = "{}";
          rewrite = {
            "(.*) — Mozilla Firefox" = " $1";
          };
        };
        "custom/spotify" = {
          format = "{icon} {}";
          format-icons = "";
          on-click = "playerctl -p spotify play-pause";
          on-scroll-up = "playerctl -p spotify next";
          on-scroll-down = "playerctl -p spotify previous";
          return-type = "json";
          exec = "${pkgs.waybar-spotify}/bin/waybar-spotify";
          exec-if = "pgrep spotify";
          escape = true;
        };
        network = {
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
          format-ethernet = "{ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-wifi = "{essid} ({signalStrength}%) ";
          on-click = "";
          tooltip-format = "{ifname} via {gwaddr} ";
        };
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
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
        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };

    style = /* css */ ''
      @import "./rose-pine-moon.css";

      @define-color bg0 #1d2021;
      @define-color bg #282828;
      @define-color bg2 #32302f;
      @define-color bg3 #504945;
      @define-color bg-light #a89984;
      @define-color fg #d4be98;
      @define-color red #ea6962;
      @define-color orange #e78a4e;
      @define-color yellow #d8a657;
      @define-color green #a9b665;
      @define-color aqua #89b482;
      @define-color blue #7daea3;
      @define-color purple #d3869b;
      @define-color grey #928374;

      * {
        border: none;
        border-radius: 15px;
        font-family: "Maple Mono NF", "Hack Nerd Font", Inter, Roboto, Helvetica, Arial, sans-serif;
        font-size: 20px;
        min-height: 0;
      }

      window#waybar {
        background-color: @base;
        color: @text;
      }

      tooltip {
        background: @base;
        border-radius: 4px;
        border-width: 2px;
        border-style: solid;
        border-color: @overlay;
      }

      tooltip label {
        color: @fg;
      }

      #mode,
      #clock,
      #battery {
        padding: 0 10px;
      }

      #mode {
        background: #64727D;
        border-bottom: 3px solid white;
      }

      #clock {
        color: @gold;
        margin: 3px 0;
        border-radius: .5em;
      }

      #battery {
        margin: 3px 0;
      }

      #battery.charging {
        color: @pine;
      }

      #battery.warning:not(.charging) {
        color: @gold;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      .modules-left {
        padding-left: 10px;
      }

      .modules-right {
        padding-right: 10px;
      }

      #workspaces {
        margin: 5px 0;
      }

      #workspaces button {
        padding: 5px;
        color: @highlightMed;
        margin-right: 5px;
      }

      #workspaces button.active {
        color: @text;
      }

      #workspaces button.focused {
        color: @subtle;
        background: @love;
        border-radius: 8px;
      }

      #workspaces button.urgent {
        color: @base;
        background-color: @love;
        border-radius: 8px;
      }

      #workspaces button:hover {
        background-color: @highlightLow;
        color: @text;
        border-radius: 8px;
      }

      #window {
        border-radius: 8px;
        margin-left: 8px;
      }

      #custom-logo {
        background-image: url('${nix-snowflake}');
        background-position: center;
        background-repeat: no-repeat;
        background-size: contain;
      }

      #custom-spotify {
        color: @text;
      }

      #custom-spotify.playing {
        color: @pine;
      }

      #pulseaudio {
        color: @foam;
      }

      #network {
        color: @iris;
      }
    '';
  };
}
