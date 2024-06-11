{ pkgs, ... }:
let
  # fontFamily = "MesloLGS NF";
  fontFamily = "JetBrainsMono Nerd Font";
in
{
  programs.alacritty = {
    enable = true; # *: false


    # Alacritty Configuration
    # REF: <https://alacritty.org/config-alacritty.html>
    settings = {
      # import = [
      #   "~/.config/alacritty/base16-dark.toml",
      #   "~/.config/alacritty/keybindings.toml",
      # ]

      shell = {
        # program = "zsh";
        program = "${pkgs.zsh}/bin/zsh";
        # args = ["-i" "-l"];
        args = [ "-l" ];
      };

      working_directory = "None";
      live_config_reload = true;

      env = {
        TERM = "xterm-256color";
      };

      window = {
        dimensions = {
          columns = 0;
          lines = 0;
        };
        position = {
          x = 0;
          y = 0;
        };
        padding = {
          x = 0;
          y = 0;
        };
        dynamic_padding = true;

        decorations = "Full";
        opacity = 1.0;
        blur = false; # NOTE: works on macOS/KDE Wayland
        startup_mode = "Maximized";
        title = "Terminal";
        dynamic_title = true;
        decorations_theme_variant = "Dark";
        resize_increments = false;
        option_as_alt = "OnlyLeft"; # NOTE: macOS only
      };


      font = {
        normal = {
          family = fontFamily;
          style = "Regular";
        };

        bold = {
          family = fontFamily;
          style = "Bold";
        };

        italic = {
          family = fontFamily;
          style = "Italic";
        };

        bold_italic = {
          family = fontFamily;
          style = "Bold Italic";
        };

        # size = lib.mkMerge [
        #   (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
        #   (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 10)
        # ];
        size = 10.0;
      };

      colors = {
        primary = {
          background = "0x1f2528";
          foreground = "0xc0c5ce";
        };

        normal = {
          black = "0x1f2528";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xc0c5ce";
        };

        bright = {
          black = "0x65737e";
          red = "0xec5f67";
          green = "0x99c794";
          yellow = "0xfac863";
          blue = "0x6699cc";
          magenta = "0xc594c5";
          cyan = "0x5fb3b3";
          white = "0xd8dee9";
        };
      };

      cursor = {
        style = "Block";
        unfocused_hollow = true;
        thickness = 0.15;
      };

    };
  };
}
