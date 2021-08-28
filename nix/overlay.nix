{ ghcVer, example, sources }:
self: super:
let inherit (super.haskell.lib) dontCheck;
in {
  haskell = super.haskell // {
    packages = super.haskell.packages // {
      "${ghcVer}" = super.haskell.packages."${ghcVer}".override {
        overrides = hself: hsuper: {
          decsession = hsuper.callCabal2nix "decsession" ../. { };
        };
      };
    };
  };
}

