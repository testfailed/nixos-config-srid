# { pkgs, config, flake, ... }:

{
  programs.ruff = {
    enable = true; # ==: false

    settings = {
      line-length = 88; # ==: 88

      format = {
        docstring-code-format = true; # ==: false
        indent-style = "space"; # ==: "space"
        quote-style = "double"; # ==: "double"
      };

      lint = {
        ignore = [ ]; # ==: [ ]
        per-file-ignores = {
          "__init__.py" = [ "F401" ];

          # Ignore `D` rules everywhere except for the `src/` directory.
          "!src/**.py" = [ "D" ];
        }; # ==: { }
        # On top of the defaults (`E4`, E7`, `E9`, and `F`), enable flake8-bugbear (`B`) and flake8-quotes (`Q`).
        select = [ "E4" "E7" "E9" "F" "B" "Q" ]; # ==: [ "E4" "E7" "E9" "F" ]
      };
    };
  };
}
