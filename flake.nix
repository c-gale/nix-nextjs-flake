{
  description = "Next.js development environment flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildEnv {
          name = "nextjs-env";
          paths = [
            pkgs.nodejs_24
            pkgs.nodePackages_latest.pnpm
            pkgs.nodePackages_latest.vercel
            pkgs.nodePackages_latest.prisma
            pkgs.postgresql_15
            pkgs.openssl
            pkgs.prisma-engines
          ];
        };

      });
}
