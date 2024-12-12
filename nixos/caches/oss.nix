{
  # nix.settings.trusted-public-keys = [
  #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  #   "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
  #   "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
  #   "om.cachix.org-1:ifal/RLZJKN4sbpScyPGqJ2+appCslzu7ZZF/C01f2Q="
  #   # "nammayatri.cachix.org-1:PiVlgB8hKyYwVtCAGpzTh2z9RsFPhIES6UKs0YB662I="
  #   # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  # ];

  # nix.settings.substituters = [
  #   "https://nix-community.cachix.org"
  #   "https://cache.nixos.org/"
  #   "https://cachix.cachix.org"
  #   "https://devenv.cachix.org"
  #   "https://om.cachix.org"
  #   # "https://nammayatri.cachix.org?priority=42"
  #   # "https://cache.garnix.io?priority=41"
  # ];

  nix.settings.substituters = [
    # "https://cache.nixos.org?priority=40"
    # "https://nix-community.cachix.org?priority=50"
    # "https://cachix.cachix.org?priority=60"
    # "https://devenv.cachix.org?priority=60"
    # # "https://cache.garnix.io?priority=61"
    # # "https://nammayatri.cachix.org?priority=62"

    "https://nix-community.cachix.org"
    "https://cachix.cachix.org"
    "https://devenv.cachix.org"
    "https://cache.nixos.org"
    # "https://cache.garnix.io"
    # "https://nammayatri.cachix.org"
  ];

  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    # "nammayatri.cachix.org-1:PiVlgB8hKyYwVtCAGpzTh2z9RsFPhIES6UKs0YB662I="
  ];
}
