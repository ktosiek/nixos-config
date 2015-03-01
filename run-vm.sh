#!/usr/bin/env bash

DIR=$(cd $(dirname "$BASH_SOURCE") && pwd)

NIXOS_CONFIG=$DIR/build-vm-conf.nix nixos-rebuild build-vm &&
    ./result/bin/run-*-vm
