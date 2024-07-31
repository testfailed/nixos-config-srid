{ self, inputs, ... }:
{
  flake = {
    homeModules = {

      common = {
        home.stateVersion = "22.11";

        imports = [
          # # ./helix.nix
          # # ./nushell.nix
          # # ./powershell.nix
          # ./juspay.nix
          # ./just.nix
          # ./nix.nix
          # ./starship.nix
          # ./terminal.nix
          # ./zellij.nix

          ./_packages.nix
          ./xdg.nix

          inputs.nixvim.homeManagerModules.nixvim
          inputs.nix-index-database.hmModules.nix-index

          ./nixvim

          ./alacritty.nix
          ./bat.nix
          ./direnv.nix
          ./fzf.nix
          ./git.nix
          ./gnutools.nix
          ./nix-index.nix
          ./ripgrep.nix
          ./ssh.nix
          ./tmux.nix
          ./zoxide.nix
          ./zsh.nix
        ];
      };

      common-linux = {
        imports = [
          self.homeModules.common
          ./bash.nix
          ./vscode-server.nix
        ];
      };

      common-darwin = {
        imports = [
          self.homeModules.common
          # # ./_1password.nix
          # # ./bash.nix
          # # ./kitty.nix
          # ./himalaya.nix

          # TODO: impl
          # ./android.nix
        ];
      };

      # TODO: impl
      # common-android = {
      #   imports = [
      #     self.homeModules.common
      #   ];
      # };

    };
  };
}
