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
        devShells.default = pkgs.mkShell {
          name = "nextjs-dev-shell";

          buildInputs = with pkgs; [
            nodejs_24
            nodePackages_latest.pnpm
            nodePackages_latest.vercel
            nodePackages_latest.prisma
            postgresql_15
            openssl
            prisma-engines  # ensures availability for shellHook
          ];

          shellHook = ''
            export PRISMA_QUERY_ENGINE_LIBRARY=${pkgs.prisma-engines}/lib/libquery_engine.node
            export PRISMA_QUERY_ENGINE_BINARY=${pkgs.prisma-engines}/bin/query-engine
            export PRISMA_SCHEMA_ENGINE_BINARY=${pkgs.prisma-engines}/bin/schema-engine
          '';
        };

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
