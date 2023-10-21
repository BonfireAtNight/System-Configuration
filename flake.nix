{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.mySystem = {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };

    defaultPackage.x86_64-linux = self.nixosConfigurations.mySystem;
  };
}
