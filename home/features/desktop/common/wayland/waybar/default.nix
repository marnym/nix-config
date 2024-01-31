let
  common = {
    "hyprland/workspaces" = {
      disable-scroll = true;
      show-special = true;
    };
    spacing = 15;
    tray.spacing = 10;
    clock = {
      interval = 5;
      format = "{:%H:%M:%S}";
    };
    network = {
      format-wifi = "{essid} ({signalStrength}%) ";
      format-ethernet = "{ipaddr}/{cidr} ";
      tooltip-format = "{ifname} via {gwaddr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "Disconnected ⚠";
      format-alt = "{ifname}: {ipaddr}/{cidr}";
      on-click = "";
    };
    "pulseaudio" = {
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
  };
in
{
  programs.waybar = {
    enable = true;
    settings = {
      timred = common // {
        layer = "top";
        position = "top";
        height = 30;
        output = "DP-3";
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [ "pulseaudio" "battery" "network" "clock" "tray" ];
      };
      thinkpad = common // {
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}%";
          format-plugged = "{capacity}%";
          format-alt = "{time} {icon}";
          format-full = "";
          format-icons = [ ];
        };
      };
    };

    style = /* css */ ''
      @define-color bg #1d2021;
      @define-color fg #d4be98;
      @define-color green #a9b665;

       * {
          border: none;
          border-radius: 0;
          font-family: BlexMono Nerd Font, Inter, Roboto, Helvetica, Arial, sans-serif;
          font-size: 16px;
          min-height: 0;
      }

      window#waybar {
          background: @bg;
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);
          color: @fg;
      }

      tooltip {
        background: rgba(43, 48, 59, 0.5);
        border: 1px solid rgba(100, 114, 125, 0.5);
      }

      tooltip label {
        color: @fg;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: @fg;
          border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #mode, #clock, #battery {
          padding: 0 10px;
      }

      #mode {
          background: #64727D;
          border-bottom: 3px solid white;
      }

      #clock {
          background-color: #64727D;
      }

      #battery {
          background-color: #ffffff;
          color: black;
      }

      #battery.charging {
          color: white;
          background-color: #26A65B;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: black;
          }
      }

      #battery.warning:not(.charging) {
          background: #f53c3c;
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: steps(12);
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }     

      #workspaces button {
        padding: 0 0.5em;
        margin: 0.25em;
      }

      #workspaces button.active {
        color: @green;
      }
    '';
  };
}
