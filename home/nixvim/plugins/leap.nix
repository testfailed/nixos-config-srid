{
  programs.nixvim = {
    plugins.leap = {
      enable = true; # *: false

      # addDefaultMappings = true;
      # caseSensitive = false;
      # # equivalenceClasses = [
      # #   " \t\r\n"
      # #   ")]}>"
      # #   "([{<"
      # #   [
      # #     "\""
      # #     "'"
      # #     "`"
      # #   ]
      # # ];
      # extraOptions = { };
      # highlightUnlabeledPhaseOneTargets = false;
      # maxHighlightedTraversalTargets = 10;
      # # substituteChars = { # *: { }
      # #   "\r" = "¬";
      # # };
      #
      # specialKeys = {
      #   multiAccept = "<enter>";
      #   multiRevert = "<backspace>";
      #   nextGroup = "<space>";
      #   nextTarget = "<enter>";
      #   prevGroup = "<backspace>"; # *: "<tab>"
      #   prevTarget = "<backspace>"; # *: "<tab>"
      # };
    };
  };
}
