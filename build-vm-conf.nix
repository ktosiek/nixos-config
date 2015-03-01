{ config, pkgs, ... }:
{
  imports = [
    ./configuration.nix
  ];

  users.extraUsers.tomek.password = "dummy";
  users.mutableUsers = false;
}
