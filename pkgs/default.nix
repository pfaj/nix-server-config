{ pkgs }:
let
  callPackage = pkgs.lib.callPackageWith pkgs;
in
{
  bkqs = callPackage ./bkqs.nix { };
  colgarb = callPackage ./colgarb.nix { };
  editconf = callPackage ./editconf.nix { };
  intellijpatch = callPackage ./intellijpatch.nix { };
  marwaita-x = callPackage ./marwaita-x.nix { };
  mcmojave-cursors = callPackage ./mcmojave-cursors.nix { };
  nixos-update = callPackage ./nixos-update.nix { };
  rmshit = callPackage ./rmshit.nix { };
  sddm-chili = callPackage ./sddm-chili.nix { };
}
