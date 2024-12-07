# { pkgs, ... }:

{
  # home.packages = with pkgs; [
  # ];

  # TODO: Symlink to external bin not working

  # home.file.".local/bin/code".text = ''
  #   modulespath="";modelName="";isUsingNixConf="";officialNestedNixMergedBuildMainPathInsertAnot=TrueHomeIAddSequenceByConflictFolder_ResultsFieldSelectedOptionsComboMechanismCommandOrderModelRecombinant```
  # '';

  # home.file.".local/bin/code".text = ''
  #   #!/bin/sh
  #   # exec "${pkgs.vscode}/bin/code" "$@"
  #   exec "/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron" "$@"
  # '';
}
