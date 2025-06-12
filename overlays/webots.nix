{...}: {
  nixpkgs.overlays = [
    (final: prev:
      with prev; {
        webots = stdenv.mkDerivation rec {
          pname = "webots";
          version = "R2025a";
          src = fetchTarball {
            url = "https://github.com/cyberbotics/webots/releases/download/${version}/webots-${version}-x86-64.tar.bz2";
            sha256 = "sha256:1hc3nql31cln2m6w0ydc3b2yaxs0g6yxm93r7c7gxnccw3z2nw1n";
          };
          nativeBuildInputs = [autoPatchelfHook];
          autoPatchelfIgnoreMissingDeps = [
            "libQt6WlShellIntegration.so.6"
          ];
          buildInputs = [
            libgcc.lib
            wayland
            libglvnd
            cairo
            gdk-pixbuf
            glib
            gtk3
            # glu
            openexr # for libImath-2_5.so.25
            sndio
            krb5
            libGLU
            libgcrypt
            libgpg-error
            xorg.xcbutil
          ];
          installPhase = ''
            mkdir -p $out/opt/webots
            cp -r * $out/opt/webots
            mkdir -p $out/bin
            ln -s $out/opt/webots/webots $out/bin/webots
          '';
          meta = with lib; {
            platforms = platforms.linux;
          };
        };
      })
  ];
}
