let sources = import ./nix/sources.nix;
in
{ nixpkgs ? import ./nix/nixpkgs.nix { inherit sources ghcVer example; }, ghcVer ? "ghc8106", example ? false }:

let hpkgs = nixpkgs.haskell.packages."${ghcVer}";
in
{
  inherit (hpkgs) decsession;
}
