# ~/nixpkgs/overlays/spotify.nix
self: super: {

  mySpotify = super.stdenv.mkDerivation {
    pname = "spotify-custom";
    version = "1.0";

    # Download official Spotify .deb package
    src = super.fetchurl {
      url = "https://repository.spotify.com/pool/non-free/s/spotify-client/spotify-client_1.2.72.488.g2f46f0c0-32_amd64.deb";
      sha256 = "0mrx8w8gkgfrlqn17x8h9gy6l1z1p7yvm6v2rzx3nwwxx3yv3k9w"; # replace with actual sha256
    };

    nativeBuildInputs = [ super.ar ];  # needed to extract .deb
    buildInputs = [ super.libc ];

    # Extract .deb contents
    unpackPhase = ''
      mkdir -p $out
      dpkg -x $src $out
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp -r $out/usr/* $out/
      # Symlink spotify executable
      ln -s $out/bin/spotify $out/spotify
    '';

    # Wrap the executable to load custom Spicetify themes
    shellHook = ''
      export SPICETIFY_CONFIG="$HOME/.config/spicetify"
      export SPOTIFY_PATH="$out/spotify"
      export PATH="$out/bin:$PATH"
    '';
  };
}
