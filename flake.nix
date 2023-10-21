{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.mySystem = {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };

    # Instead of `mySystem` you can use any name you want
    # Make sure to change it in all relevant places (including other files)
    defaultPackage.x86_64-linux = self.nixosConfigurations.mySystem;
  };
}
