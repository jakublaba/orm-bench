{
  description = "ORM benchmark environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShells = {
      "${system}" = {
        default = pkgs.mkShell {
          packages = [
            pkgs.postgresql
            pkgs.gzip
          ];

          shellHook = ''
            export PGDATA=$PWD/pgdata
            export PGHOST="/tmp/pgsocket-$USER-orm-bench"
            export PGPORT=5433
            export PGDATABASE=default
            export PGUSER=$(whoami)
            export JDBC_URL="jdbc:postgresql://localhost:5433/bench"

            # initialize pgdata
            if [ ! -d "$PGDATA" ]; then
              mkdir -p "$PGDATA"
              initdb -D "$PGDATA"
            fi

            # ensure socket dir exists
            mkdir -p "$PGHOST"
          '';
        };
      };
    };
  };
}
