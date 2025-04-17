{
  description = "Example flake environment for build buildroot projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.${system}.default = (pkgs.buildFHSUserEnv {
      name = "buildroot";
      targetPkgs = pkgs: (with pkgs;
        [
          (lib.hiPrio gcc)
	  bash
	  dialog
          file
          gnumake
	  libxcrypt
          ncurses.dev
	  newt
          pkg-config
          unzip
          wget
          pkgsCross.aarch64-multiplatform.gccStdenv.cc
        ] ++ pkgs.linux.nativeBuildInputs);
    }).env;
  };
}
