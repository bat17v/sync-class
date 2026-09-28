{
  description = "Минимальное окружение для изучения Elixir";

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
          pkgs.elixir
        ];

        shellHook = ''
          echo "Привет! Окружение Elixir готово к работе."
          elixir --version
        '';
      };
    };
}
