{ self, inputs, ... }:
# { self, ... }:
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
          ./tmux.nix
          # ./zellij.nix
          ./bat.nix
          ./direnv.nix
          ./fzf.nix
          ./git.nix
          ./gnutools.nix
          ./neovim.nix
          ./nix.nix
          ./ripgrep.nix
          ./ssh.nix
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
