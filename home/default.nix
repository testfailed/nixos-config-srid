{ self, inputs, ... }:
{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "22.11";
        imports = [
          ./_packages.nix
          ./xdg.nix

          inputs.nixvim.homeManagerModules.nixvim
          inputs.nix-index-database.hmModules.nix-index
          # # ./helix.nix
          # # ./nushell.nix
          # # ./powershell.nix
          # ./_1password.nix
          # ./juspay.nix
          # ./just.nix
          # ./starship.nix
          # ./terminal.nix
          # ./zellij.nix
          ./alacritty.nix
          ./bat.nix
          ./direnv.nix
          ./fzf.nix
          ./git.nix
          ./gnutools.nix
          ./nix.nix
          ./nix-index.nix
          # ./nixvim/default.nix
          ./nixvim
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
          # # ./bash.nix
          # # ./kitty.nix
          # ./himalaya.nix
        ];
      };
    };
  };
}
