# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Include essential packages globally.
  environment.systemPackages = with pkgs; [
    coreutils
    git
    vim
    curl
    wget
  ];

  # Create a user.
  users.users.kai = {
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
