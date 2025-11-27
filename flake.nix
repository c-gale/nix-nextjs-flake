{
  description = "Run 'nix develop' to have a dev shell that has everything this project needs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    packages = flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = pkgs.buildEnv {
          name = "nextjs-env";
          paths = [
            pkgs.nodejs_24
            pkgs.nodePackages_latest.pnpm
            pkgs.nodePackages_latest.vercel
            pkgs.nodePackages_latest.prisma
            pkgs.postgresql_15
            pkgs.openssl
          ];
        };
    });

}