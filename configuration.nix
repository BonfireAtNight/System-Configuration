# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Omit the previous configuration...

  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    # Flakes use Git to pull dependencies from data sources 
    coreutils
    git
    vim
    wget
    curl
  ];
  # Set default editor to vim
  environment.variables.EDITOR = "vim";

  # Create a user.
  users.users.johndoe = {
    isNormalUser = true;
    home = "/home/kai";
    description = "Kai";
  };

  # Use Home Manager to manage the user's dotfiles.
  imports = [
    <home-manager/nixos>
  ];

  home.file.".config/nixpkgs/config.nix" = {
    source = ./home.nix;
    text = ''
      { home.username }:
      {
        programs.home-manager.enable = true;
      };
    '';
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };
}