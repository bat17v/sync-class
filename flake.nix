{
  description = "Elixir + Postgres environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.beamPackages.elixir_1_18
          pkgs.postgresql_16
          pkgs.inotify-tools

          (pkgs.writeShellScriptBin "pg-start" ''
            export PGDATA="$PWD/.direnv/db"
            if [ ! -d "$PGDATA" ]; then
              initdb --auth=trust -U postgres
              echo "unix_socket_directories = '$PWD/.direnv'" >> "$PGDATA/postgresql.conf"
            fi
            pg_ctl -l "$PGDATA/server.log" -o "-k $PWD/.direnv" start
          '')

          (pkgs.writeShellScriptBin "pg-stop" ''
            export PGDATA="$PWD/.direnv/db"
            pg_ctl stop
          '')
        ];

        shellHook = ''
          export PGDATA = "$PWD/.direnv/db"

          echo "Hello! Environment prepared!"
        '';
      };
    };
}
