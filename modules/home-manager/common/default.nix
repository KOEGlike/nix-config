{
  outputs,
  userConfig,
  pkgs,
  ...
}:
{
  imports = [
    ../programs/aerospace
    ../programs/alacritty
    ../programs/albert
    ../programs/atuin
    ../programs/bat
    ../programs/brave
    ../programs/btop
    ../programs/fastfetch
    ../programs/fzf
    ../programs/git
    ../programs/go
    ../programs/gpg
    ../programs/k9s
    ../programs/krew
    ../programs/lazygit
    ../programs/neovim
    ../programs/obs-studio
    ../programs/saml2aws
    ../programs/starship
    ../programs/telegram
    ../programs/tmux
    ../programs/zsh
    ../programs/vscode
    ../scripts
    ../services/flatpak
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Home-Manager configuration for the user's home environment
  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${userConfig.name}" else "/home/${userConfig.name}";
  };

  # Ensure common packages are installed
  home.packages =
    with pkgs;
    [
      anki-bin
      awscli2
      dig
      du-dust
      eza
      fd
      jq
      kubectl
      lazydocker
      nh
      openconnect
      pipenv
      python3
      ripgrep
      terraform

      rustup
      rust-analyzer
      clippy
      cargo
      sqlx-cli
      cargo-leptos
      leptosfmt
      cargo-generate

      temurin-bin-21

      tailwindcss_4
      dart-sass

      openssl
      openssl.dev

      pkg-config

      gcc
      clang

      ldproxy

      config.boot.kernelPackages.xone
      prismlauncher

      kikit
      (kicad.override {
        addons = [
          pkgs.kicadAddons.kikit
          pkgs.kicadAddons.kikit-library
        ];
      })
      kikit
      freecad

      prusa-slicer

      discord
      slack
      signal-desktop

      figma-linux

      (blender.override { cudaSupport = true; })

      qdirstat

      davinci-resolve
      gimp3

      brave
      firefox

      libreoffice-qt

    ]
    ++ lib.optionals stdenv.isDarwin [
      colima
      docker
      hidden-bar
      mos
      raycast
    ]
    ++ lib.optionals (!stdenv.isDarwin) [
      tesseract
      unzip
      wl-clipboard
      appimage-run
      lutris
    ];

  # Catpuccin flavor and accent
  catppuccin = {
    flavor = "macchiato";
    accent = "lavender";
  };
}
