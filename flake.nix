{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = with pkgs;
          mkShell {
            packages = [
              ruby
              flyctl
            ];

            # Keep gems installed in a subdirectory
            BUNDLE_PATH = "./vendor/bundle";

            # Development database
            DATABASE_URL = "sqlite://db/data.sqlite3";
        };
      });
}
