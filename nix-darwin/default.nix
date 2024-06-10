{ self, config, ... }:
{
  # Configuration common to all macOS systems
  flake = {
    darwinModules = {
      my-home = {

        # home-manager configs
        home-manager.backupFileExtension = "before-home-manager";

        home-manager.users.${config.people.myself} = {
          imports = [ self.homeModules.common-darwin ];
        };
      };

      default.imports = [
        self.darwinModules_.home-manager
        self.darwinModules.my-home
        self.nixosModules.common
      ];
    };
  };
}
