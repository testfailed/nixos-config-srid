{ lib, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    zsh-completions
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;

    # syntaxHighlighting = {
    #   enable = true;
    #   highlighters = [
    #     "main"
    #     "brackets"
    #     # "pattern"
    #     # "regexp"
    #     "cursor"
    #     "root"
    #   ];
    # };

    # autocd = null;
    autosuggestion = {
      enable = true; # *: false
      highlight = "fg=8"; # *: null
    };
    # cdpath = [ "~/.local/share/src" ];
    completionInit = "autoload -U compinit && compinit";
    defaultKeymap = "viins"; # *: null
    enableCompletion = true;
    enableVteIntegration = true; # *: false

    history = {
      extended = true; # *: false
      ignoreAllDups = true; # *: false
      ignorePatterns = [
        "rm *"
        "pkill *"
      ];
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history"; # *: "$HOME/.zsh_history" if state version ≥ 20.03,
      share = true;
      size = 100000; # *: 10000
    };

    historySubstringSearch = {
      enable = true; # *: false

      searchDownKey = [ "^N" ]; # *: ["^[[B"] | $terminfo[kcud1]
      searchUpKey = [ "^P" ]; # *: ["^[[A"] | $terminfo[kcuu1]
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./_file;
        file = "p10k.zsh";
      }
      {
        name = "magic-enter";
        src = pkgs.fetchFromGitHub {
          owner = "zshzoo";
          repo = "magic-enter";
          rev = "b5a7d0a55abab268ebd94969e2df6ea867fa2cd5";
          sha256 = "sha256-3g9upBzGipbL5E2cjUG10rrahQdcmdvUx/ufmmdyzso=";
        };
      }
      # {
      #   name = "vi-mode";
      #   src = pkgs.zsh-vi-mode;
      #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      # }
    ];

    # envExtra = ''
    #   export PATH=/etc/profiles/per-user/$USER/bin:/nix/var/nix/profiles/system/sw/bin:/usr/local/bin:$PATH
    #
    #   # Because, adding it in .ssh/config is not enough.
    #   # cf. https://developer.1password.com/docs/ssh/get-started#step-4-configure-your-ssh-or-git-client
    #   export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    # '';

    shellGlobalAliases = {
      UUID = "$(uuidgen | tr -d \\n)";
      XC = "| xc";

      L = "| $PAGER";
      LG = "| $PAGER_BOTTOM";

      BH = "| $BAT_LANG_HELP";
      BSH = "| $BAT_LANG_SH";
      HH = "| bat -l=help";
      HL = "| bat -p -l=help";

      BL = "| $BAT_PAGER";
      BLG = "| $BAT_PAGER_BOTTOM";
      BLH = "| $BAT_PAGER_LANG_HELP";
      BLSH = "| $BAT_PAGER_LANG_SH";

      # G = "| grep";
      G = "| grp";
      GH = "| grph";
      GHL = "| grphl";
      GL = "| grpl";

      ST = "| gsort";
      STH = "| gsort -h";
      STHR = "| gsort -hr";
      STR = "| gsort -r";
    };

    initExtraFirst = ''
      # if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
      #   . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      #   . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      # fi

      [[ ! $(command -v nix) && -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]] \
        && . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
      [[ ! $(command -v nix) && -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] \
        && . "$HOME/.nix-profile/etc/profile.d/nix.sh"

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      setopt prompt_subst

      setopt histignorespace
      # export HISTIGNORE="pwd:ls:cd"

      export EDITOR="nvim"
      export VISUAL="nvim"

      ############################################################
      # GNU command shims for compatibility
      ############################################################

      export TDPP_EZA_DEFAULT_OPTS="-1l -F --color=always --icons=auto --git --group-directories-first -hm"
      export TDPP_GREP_DEFAULT_OPTS="--color=always"
      # export TDPP_LS_DEFAULT_OPTS="-Fhv --color=always --group-directories-first"
      # export TDPP_LS_DEFAULT_OPTS="-lh -F"
      export TDPP_LS_DEFAULT_OPTS="-lhv -F --color=always --group-directories-first"

      export TDPP_GNU_AWK_APP='gawk'
      export TDPP_GNU_CAT_APP='gcat'
      export TDPP_GNU_ECHO_APP='gecho'
      export TDPP_GNU_DATE_APP='gdate'
      export TDPP_GNU_GREP_APP='grep'
      export TDPP_GNU_LS_APP='gls'
      export TDPP_GNU_XARGS_APP='xargs'

      export TDPP_GNU_AWK="''${TDPP_GNU_AWK_APP}"                             # TODO: replace with this command variable
      export TDPP_GNU_CAT="''${TDPP_GNU_CAT_APP}"                             # TODO: replace with this command variable
      export TDPP_GNU_ECHO="''${TDPP_GNU_ECHO_APP}"                           # TODO: replace with this command variable
      export TDPP_GNU_DATE="''${TDPP_GNU_DATE_APP}"                           # TODO: replace with this command variable
      export TDPP_GNU_GREP="''${TDPP_GNU_GREP_APP} ''${TDPP_GREP_DEFAULT_OPTS}" # TODO: replace with this command variable
      export TDPP_GNU_LS="''${TDPP_GNU_LS_APP} ''${TDPP_LS_DEFAULT_OPTS}"       # TODO: replace with this command variable
      export TDPP_GNU_XARGS="''${TDPP_GNU_XARGS_APP}"                         # TODO: replace with this command variable

      ############################################################
      # Text Colors on Terminal
      # REF: <https://stackoverflow.com/a/28938235/12453442>
      ############################################################

      # LS_COLORS
      export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

      # Reset
      export TDPP_COLOR_OFF='\033[0m' # Text Reset

      # Regular Colors
      export TDPP_COLOR_BLACK='\033[0;30m'  # Black
      export TDPP_COLOR_RED='\033[0;31m'    # Red
      export TDPP_COLOR_GREEN='\033[0;32m'  # Green
      export TDPP_COLOR_YELLOW='\033[0;33m' # Yellow
      export TDPP_COLOR_BLUE='\033[0;34m'   # Blue
      export TDPP_COLOR_PURPLE='\033[0;35m' # Purple
      export TDPP_COLOR_CYAN='\033[0;36m'   # Cyan
      export TDPP_COLOR_WHITE='\033[0;37m'  # White

      # Bold
      export TDPP_COLOR_B_BLACK='\033[1;30m'  # Black
      export TDPP_COLOR_B_RED='\033[1;31m'    # Red
      export TDPP_COLOR_B_GREEN='\033[1;32m'  # Green
      export TDPP_COLOR_B_YELLOW='\033[1;33m' # Yellow
      export TDPP_COLOR_B_BLUE='\033[1;34m'   # Blue
      export TDPP_COLOR_B_PURPLE='\033[1;35m' # Purple
      export TDPP_COLOR_B_CYAN='\033[1;36m'   # Cyan
      export TDPP_COLOR_B_WHITE='\033[1;37m'  # White

      # Underline
      export TDPP_COLOR_U_BLACK='\033[4;30m'  # Black
      export TDPP_COLOR_U_RED='\033[4;31m'    # Red
      export TDPP_COLOR_U_GREEN='\033[4;32m'  # Green
      export TDPP_COLOR_U_YELLOW='\033[4;33m' # Yellow
      export TDPP_COLOR_U_BLUE='\033[4;34m'   # Blue
      export TDPP_COLOR_U_PURPLE='\033[4;35m' # Purple
      export TDPP_COLOR_U_CYAN='\033[4;36m'   # Cyan
      export TDPP_COLOR_U_WHITE='\033[4;37m'  # White

      # Background
      export TDPP_COLOR_ON_BLACK='\033[40m'  # Black
      export TDPP_COLOR_ON_RED='\033[41m'    # Red
      export TDPP_COLOR_ON_GREEN='\033[42m'  # Green
      export TDPP_COLOR_ON_YELLOW='\033[43m' # Yellow
      export TDPP_COLOR_ON_BLUE='\033[44m'   # Blue
      export TDPP_COLOR_ON_PURPLE='\033[45m' # Purple
      export TDPP_COLOR_ON_CYAN='\033[46m'   # Cyan
      export TDPP_COLOR_ON_WHITE='\033[47m'  # White

      # High Intensity
      export TDPP_COLOR_I_BLACK='\033[0;90m'  # Black
      export TDPP_COLOR_I_RED='\033[0;91m'    # Red
      export TDPP_COLOR_I_GREEN='\033[0;92m'  # Green
      export TDPP_COLOR_I_YELLOW='\033[0;93m' # Yellow
      export TDPP_COLOR_I_BLUE='\033[0;94m'   # Blue
      export TDPP_COLOR_I_PURPLE='\033[0;95m' # Purple
      export TDPP_COLOR_I_CYAN='\033[0;96m'   # Cyan
      export TDPP_COLOR_I_WHITE='\033[0;97m'  # White

      # Bold High Intensity
      export TDPP_COLOR_B_I_BLACK='\033[1;90m'  # Black
      export TDPP_COLOR_B_I_RED='\033[1;91m'    # Red
      export TDPP_COLOR_B_I_GREEN='\033[1;92m'  # Green
      export TDPP_COLOR_B_I_YELLOW='\033[1;93m' # Yellow
      export TDPP_COLOR_B_I_BLUE='\033[1;94m'   # Blue
      export TDPP_COLOR_B_I_PURPLE='\033[1;95m' # Purple
      export TDPP_COLOR_B_I_CYAN='\033[1;96m'   # Cyan
      export TDPP_COLOR_B_I_WHITE='\033[1;97m'  # White

      # High Intensity backgrounds
      export TDPP_COLOR_ON_I_BLACK='\033[0;100m'  # Black
      export TDPP_COLOR_ON_I_RED='\033[0;101m'    # Red
      export TDPP_COLOR_ON_I_GREEN='\033[0;102m'  # Green
      export TDPP_COLOR_ON_I_YELLOW='\033[0;103m' # Yellow
      export TDPP_COLOR_ON_I_BLUE='\033[0;104m'   # Blue
      export TDPP_COLOR_ON_I_PURPLE='\033[0;105m' # Purple
      export TDPP_COLOR_ON_I_CYAN='\033[0;106m'   # Cyan
      export TDPP_COLOR_ON_I_WHITE='\033[0;107m'  # White

      export TDPP_COLOR_LOADED='true'

      ############################################################
      # Define initial environment variables
      ############################################################

      export TDPP_USER_USERNAME='clvswft03'

      export TDPP_PROJECT_NAME='tdpp'
      export TDPP_HOME="''${HOME}/.''${TDPP_PROJECT_NAME}"

      # TDPP_BIN_PATH

      export TDPP_BIN_PATH="''${TDPP_HOME}/bin"

      # TDPP_LIB

      export TDPP_LIB_PATH="''${TDPP_HOME}/lib"

      # TDPP_LIB_SH

      export TDPP_LIB_SH_ALIASES_FILENAME_BASE="aliases"
      export TDPP_LIB_SH_ENV_FILENAME_BASE="env"
      export TDPP_LIB_SH_FUNCTIONS_FILENAME_BASE="functions"

      # TDPP_LIB_SH
      export TDPP_LIB_SH_FILENAME_EXT="sh"
      export TDPP_LIB_SH_PATH="''${TDPP_LIB_PATH}/sh"
      export TDPP_LIB_SH_ALIASES_PATH="''${TDPP_LIB_SH_PATH}/''${TDPP_LIB_SH_ALIASES_FILENAME_BASE}.''${TDPP_LIB_SH_FILENAME_EXT}"
      export TDPP_LIB_SH_ENV_PATH="''${TDPP_LIB_SH_PATH}/''${TDPP_LIB_SH_ENV_FILENAME_BASE}.''${TDPP_LIB_SH_FILENAME_EXT}"
      export TDPP_LIB_SH_FUNCTIONS_PATH="''${TDPP_LIB_SH_PATH}/''${TDPP_LIB_SH_FUNCTIONS_FILENAME_BASE}.''${TDPP_LIB_SH_FILENAME_EXT}"

      # TDPP_LIB_SH_BASH
      export TDPP_LIB_SH_BASH_FILENAME_EXT="bash"
      export TDPP_LIB_SH_BASH_PATH="''${TDPP_LIB_SH_PATH}/bash"
      export TDPP_LIB_SH_BASH_ALIASES_PATH="''${TDPP_LIB_SH_BASH_PATH}/''${TDPP_LIB_SH_ALIASES_FILENAME_BASE}.''${TDPP_LIB_SH_BASH_FILENAME_EXT}"
      export TDPP_LIB_SH_BASH_ENV_PATH="''${TDPP_LIB_SH_BASH_PATH}/''${TDPP_LIB_SH_ENV_FILENAME_BASE}.''${TDPP_LIB_SH_BASH_FILENAME_EXT}"
      export TDPP_LIB_SH_BASH_FUNCTIONS_PATH="''${TDPP_LIB_SH_BASH_PATH}/''${TDPP_LIB_SH_FUNCTIONS_FILENAME_BASE}.''${TDPP_LIB_SH_BASH_FILENAME_EXT}"

      # TDPP_LIB_SH_SH
      export TDPP_LIB_SH_SH_PATH="''${TDPP_LIB_SH_PATH}/sh"
      export TDPP_LIB_SH_SH_ALIASES_PATH="''${TDPP_LIB_SH_SH_PATH}/''${TDPP_LIB_SH_ALIASES_FILENAME_BASE}.''${TDPP_LIB_SH_FILENAME_EXT}"
      export TDPP_LIB_SH_SH_ENV_PATH="''${TDPP_LIB_SH_SH_PATH}/''${TDPP_LIB_SH_ENV_FILENAME_BASE}.''${TDPP_LIB_SH_FILENAME_EXT}"
      export TDPP_LIB_SH_SH_FUNCTIONS_PATH="''${TDPP_LIB_SH_SH_PATH}/''${TDPP_LIB_SH_FUNCTIONS_FILENAME_BASE}.''${TDPP_LIB_SH_FILENAME_EXT}"

      # TDPP_LIB_SH_ZSH
      export TDPP_LIB_SH_ZSH_FILENAME_EXT="zsh"
      export TDPP_LIB_SH_ZSH_PATH="''${TDPP_LIB_SH_PATH}/zsh"
      export TDPP_LIB_SH_ZSH_COMPLETION_PATH="''${TDPP_LIB_SH_ZSH_PATH}/completion"
      export TDPP_LIB_SH_ZSH_ALIASES_PATH="''${TDPP_LIB_SH_ZSH_PATH}/''${TDPP_LIB_SH_ALIASES_FILENAME_BASE}.''${TDPP_LIB_SH_ZSH_FILENAME_EXT}"
      export TDPP_LIB_SH_ZSH_ENV_PATH="''${TDPP_LIB_SH_ZSH_PATH}/''${TDPP_LIB_SH_ENV_FILENAME_BASE}.''${TDPP_LIB_SH_ZSH_FILENAME_EXT}"
      export TDPP_LIB_SH_ZSH_FUNCTIONS_PATH="''${TDPP_LIB_SH_ZSH_PATH}/''${TDPP_LIB_SH_FUNCTIONS_FILENAME_BASE}.''${TDPP_LIB_SH_ZSH_FILENAME_EXT}"

      # TDPP_LIB_VIM

      export TDPP_LIB_VIM_INIT_FILENAME_BASE="init"
      export TDPP_LIB_VIM_KEYMAPPINGS_FILENAME_BASE="keymappings"

      # TDPP_LIB_VIM
      export TDPP_LIB_VIM_FILENAME_EXT="vim"
      export TDPP_LIB_VIM_PATH="''${TDPP_LIB_PATH}/vim"
      export TDPP_LIB_VIM_INIT_PATH="''${TDPP_LIB_VIM_PATH}/''${TDPP_LIB_VIM_INIT_FILENAME_BASE}.''${TDPP_LIB_VIM_FILENAME_EXT}"
      export TDPP_LIB_VIM_KEYMAPPINGS_PATH="''${TDPP_LIB_VIM_PATH}/''${TDPP_LIB_VIM_KEYMAPPINGS_FILENAME_BASE}.''${TDPP_LIB_VIM_FILENAME_EXT}"

      ############################################################
      # Log Config Variables
      ############################################################

      export TDPP_CONST_UNDEFINED="__UNDEFINED__"

      # Value Types

      export TDPP_TYPE_LOG_LEVEL_DEBUG=''${TDPP_TYPE_LOG_LEVEL_DEBUG:-2}
      export TDPP_TYPE_LOG_LEVEL_ERROR=''${TDPP_TYPE_LOG_LEVEL_ERROR:-5}
      export TDPP_TYPE_LOG_LEVEL_INFO=''${TDPP_TYPE_LOG_LEVEL_INFO:-3}
      export TDPP_TYPE_LOG_LEVEL_OFF=''${TDPP_TYPE_LOG_LEVEL_OFF:-100}
      export TDPP_TYPE_LOG_LEVEL_TRACE=''${TDPP_TYPE_LOG_LEVEL_TRACE:-1}
      export TDPP_TYPE_LOG_LEVEL_WARN=''${TDPP_TYPE_LOG_LEVEL_WARN:-4}

      # export TDPP_TYPE_LOG_LEVEL_DEFAULT=''${TDPP_TYPE_LOG_LEVEL_OFF}
      # export TDPP_TYPE_LOG_LEVEL_DEFAULT=''${TDPP_TYPE_LOG_LEVEL_ERROR}
      # export TDPP_TYPE_LOG_LEVEL_DEFAULT=''${TDPP_TYPE_LOG_LEVEL_WARN}
      export TDPP_TYPE_LOG_LEVEL_DEFAULT=''${TDPP_TYPE_LOG_LEVEL_INFO}
      # export TDPP_TYPE_LOG_LEVEL_DEFAULT=''${TDPP_TYPE_LOG_LEVEL_DEBUG}
      # export TDPP_TYPE_LOG_LEVEL_DEFAULT=''${TDPP_TYPE_LOG_LEVEL_TRACE}

      # Current Values

      # TODO: load values from external config file
      export TDPP_LOG_LEVEL=''${TDPP_LOG_LEVEL:-$TDPP_TYPE_LOG_LEVEL_DEFAULT}

      ############################################################
      # Zsh Common Environment Variables
      ############################################################

      # REF: https://github.com/ricbra/zsh-config/blob/master/zshrc

      # Common ENV variables
      export LANG='en_US.UTF-8'
      export LC_ALL='en_US.UTF-8'
      export TZ='Asia/Seoul'

      export VIM_EDITOR='nvim'
      export GIT_EDITOR='nvim'
      export VISUAL='nvim'

      # Preferred editor for local and remote sessions
      if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='nvim'
      else
        export EDITOR='nvim'
      fi

      # key timeout (used in vi-mode)
      export KEYTIMEOUT=15

      export TDPP_SHELL_NAME='zsh'
      # TODO: macOS compatibility issue
      # export SHELL="/usr/bin/''${TDPP_SHELL_NAME}"
      export SHELL="/bin/''${TDPP_SHELL_NAME}"

      # Not to share history across tmux sessions/windows/panes
      # REF: https://github.com/ohmyzsh/ohmyzsh/issues/2537
      unsetopt inc_append_history
      unsetopt share_history

      # dotglob lets glob match dotfiles
      setopt dotglob

      # Remove superfluous blanks from each command line being added to the history
      # list
      setopt histreduceblanks

      # Remove command lines from the history list when the first character on the
      # line is a space, or when one of the expanded aliases contains a leading space
      setopt histignorespace

      # Do not enter command lines into the history list if they are duplicates of the
      # previous event.
      setopt histignorealldups

      # Switching directories for lazy people
      setopt autocd

      # See: http://zsh.sourceforge.net/Intro/intro_6.html
      setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups

      # Don't kill background jobs when I logout
      setopt nohup

      # See: http://zsh.sourceforge.net/Intro/intro_2.html
      setopt extendedglob

      # Do not require a leading "." in a filename to be matched explicitly
      # setopt globdots

      # Use vi key bindings in ZSH
      setopt vi

      # Causes field splitting to be performed on unquoted parameter expansions
      setopt shwordsplit

      # Automatically use menu completion after the second consecutive request for
      # completion
      setopt automenu

      # If the argument to a cd command (or an implied cd with the AUTO_CD option set)
      # is not a directory, and does not begin with a slash, try to expand the
      # expression as if it were preceded by a "~"
      setopt cdablevars

      # Try to make the completion list smaller (occupying less lines) by printing
      # the matches in columns with different widths
      # setopt listpacked

      # Don't show types in completion lists
      setopt nolisttypes

      # If a completion is performed with the cursor within a word, and a full
      # completion is inserted, the cursor is moved to the end of the word
      setopt alwaystoend

      # Try to correct the spelling of commands
      # setopt correct

      # https://github.com/robbyrussell/oh-my-zsh/issues/449
      setopt no_nomatch

      # Disable annoying confirm
      setopt rmstarsilent

      #
      # Pager
      #

      export PAGER_ARG='less'
      export PAGER_ARG_BOTTOM="$PAGER_ARG +G"
      export PAGER="$PAGER_ARG -FR"
      export PAGER_BOTTOM="$PAGER_ARG_BOTTOM -FR"

      export BAT_PAGER_APP='bat'

      # export BAT_PIPE="$BAT_PAGER_APP --paging=never"
      export BAT_PIPE="$BAT_PAGER_APP --paging=auto"
      # NOTE: not working as expected.
      export BAT_PIPE_PLAIN="$BAT_PIPE --plain"

      export BAT_LANG_HELP="$BAT_PIPE -l help"
      export BAT_LANG_MAN="$BAT_PIPE -l man"
      export BAT_LANG_SH="$BAT_PIPE -l sh"

      # export BAT_PAGER="$BAT_PAGER_APP --pager='$PAGER_ARG'"
      export BAT_PAGER_BOTTOM="$BAT_PAGER_APP --pager='$PAGER_ARG_BOTTOM'"

      export BAT_PAGER_PLAIN="$BAT_PAGER_APP --plain --pager='$PAGER_ARG'"
      # NOTE: PAGER_ARG_BOTTOM is not working properly as a bat pager.
      export BAT_PAGER_PLAIN_BOTTOM="$BAT_PAGER_APP --plain --pager='$PAGER_ARG'"

      export BAT_PAGER_LANG_HELP="$BAT_PAGER_PLAIN -l help"
      export BAT_PAGER_LANG_MAN="$BAT_PAGER_PLAIN -l man"
      export BAT_PAGER_LANG_SH="$BAT_PAGER_PLAIN -l sh"

      export MANPAGER="sh -c 'col -bx | bat -l man -p'"
      export MANROFFOPT='-c'

      function batdiff() {
          git diff --name-only --relative --diff-filter=d | xargs bat --diff
      }

      alias bathelp='bat --plain --language=help'
      function help() {
          "$@" --help 2>&1 | bathelp
      }

      # eza
      export TIME_STYLE='long-iso'

      export MAIL="''${HOME}/Maildir"

      ############################################################
      # Global Aliases and Functions
      ############################################################

      # alias -g "L"='| $PAGER'
      # alias -g "LG"='| $PAGER_BOTTOM'
      #
      # alias -g "BH"='| $BAT_LANG_HELP'
      # alias -g "BSH"='| $BAT_LANG_SH'
      # alias -g "HH"='| bat -l=help'
      # alias -g "HL"='| bat -p -l=help'
      #
      # # alias -g "LL"='| $BATS_PAGER'
      # # alias -g "LLG"='| $BATS_PAGER_BOTTOM'
      #
      # alias -g "BLH"='| $BAT_PAGER_LANG_HELP'
      # alias -g "BLSH"='| $BAT_PAGER_LANG_SH'

      alias grp='_grp'
      function _grp() {
        # local -r args=$(_esc "''${@}")
        # _tdpp_p_func_full "$(_tdpp_p_func_name)" "args"

        # _pxed eval "''${TDPP_GNU_GREP} -P ''${args:-\"\"}"

        _pxed eval "''${TDPP_GNU_GREP} -P ''${@:-\"\"}"
      }

      # alias grph='_grph'
      # function _grph() {
      #   local -r default="$2"
      #   local -r keyword="''${1:-$default}"
      #   _tdpp_p_func_full "$(_tdpp_p_func_name)" "keyword" "default"

      #   _pxed eval "grp \"$keyword|$\""
      # }

      # alias grphl='_grphl'
      # function _grphl() {
      #   _pfunc "''${funcstack[1]}"
      #   _pxed eval "grph ''${*} L"
      # }

      # alias grpl='_grp__p__L'
      # function _grp__p__L() {
      #   _pfunc "''${funcstack[1]}"
      #   _pxed eval "grp ''${*} L"
      # }

      # alias -g "G"='| grp'
      # alias -g "GH"='| grph'
      # alias -g "GHL"='| grphl'
      # alias -g "GL"='| grpl'
      #
      # alias -g 'XC'='| xc'
      #
      # TDPP_AL_CMD_SORT="ST"
      # TDPP_AL_BIN_SORT='gsort'
      # alias -g "''${TDPP_AL_CMD_SORT}"='| ''${TDPP_AL_BIN_SORT}'
      # alias -g "''${TDPP_AL_CMD_SORT}H"='| ''${TDPP_AL_BIN_SORT} -h'
      # alias -g "''${TDPP_AL_CMD_SORT}HR"='| ''${TDPP_AL_BIN_SORT} -hr'
      # alias -g "''${TDPP_AL_CMD_SORT}R"='| ''${TDPP_AL_BIN_SORT} -r'

      ############################################################
      # Aliases
      ############################################################

      # nix shortcuts
      function xsh() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Ripgrep alias
      alias rgs=rg -p --glob '!node_modules/*' $@

      ############################################################
      # ALIAS: g*: *
      ############################################################

      ############################################################
      # ALIAS: g*: git (START)
      ############################################################

      alias g='git'

      alias gver='git --version'
      alias ghl='_ghlc'

      alias ghlc='_ghlc'
      function _ghlc() { _tdpp_pipe_help g c "" "$*"; }
      alias ghll='_ghll'
      function _ghll() { _tdpp_pipe_help g l "" "$*"; }
      alias ghls='_ghls'
      function _ghls() { _tdpp_pipe_help g s "" "$*"; }

      # ALIAS: ga: 'git add'
      alias ga='git add'
      alias gaa='git add .'
      alias gai='git add -i'

      # ALIAS: gb: 'git branch'
      alias gb='git branch'
      alias gbd='git branch -d'
      alias gbm='git branch -m'
      alias gbu='git branch -u'
      alias gbuo='git branch -u origin'
      alias gbuoc='git branch -u origin/$(git branch --show-current)'
      alias gbv='git branch -v'
      alias gbvv='git branch -vv'

      # ALIAS: gc: 'git commit --verbose'
      alias gc='git commit --verbose'
      alias gca_='git commit --verbose --amend'
      alias gcm='git commit --verbose -m'
      alias gcnv_='git commit --verbose --no-verify'
      alias gcnvm_='git commit --verbose --no-verify -m'

      # ALIAS: gcl: 'git clone'
      alias gcl='git clone'
      alias gclr='git clone --recurse-submodules'

      # ALIAS: gcnf: 'git config'
      alias gcnf='git config'
      alias gcnfg='git config --global'

      # ALIAS: gco: 'git checkout'
      alias gco='git checkout'
      alias gcob='git checkout -b'
      alias gcod='git checkout $(git_develop_branch)'
      alias gcom='git checkout $(git_main_branch)'
      alias gcoo='git checkout --ours'
      alias gcot='git checkout --theirs'

      # ALIAS: gd: 'git diff'
      alias gd='git diff'
      alias gdca='git diff --cached'
      alias gds='git diff --stat'
      alias gdsl='git diff --stat HEAD~'
      alias gdst='git diff --stat --staged'

      # alias gd='_gd'
      # # TODO: get <opts> and <paths> separately.
      # function _gd() {
      # 	local -r paths="''${*}"
      # 	_tdpp_p_func_full "$(_tdpp_p_func_name)" "paths"
      # 	_pxed eval "git diff -- $(_tdpp_p_pathspec_patterns exclude git diff) ''${paths}"
      # }
      #
      # alias gdca='_gdca'
      # function _gdca() {
      # 	local -r paths="''${*}"
      # 	_tdpp_p_func_full "$(_tdpp_p_func_name)" "paths"
      # 	_pxed eval "git diff --cached -- $(_tdpp_p_pathspec_patterns exclude git diff) ''${paths}"
      # }
      #
      # alias gde='git diff -- ''${LA_FILES_ALL} ":!*.lock"'

      # ALIAS: gf: 'git fetch'
      alias gf='git fetch'
      alias gfa='git fetch --all --jobs=10'
      alias gfap='git fetch --all --jobs=10 --prune'

      # ALIAS: gl: 'git log --graph --decorate --abbrev-commit'
      alias gl='git log --graph --decorate --abbrev-commit'
      alias gla="gl --all --tags --branches --remotes --perl-regexp --author='^((?!Renovate Bot|dependabot).*)$'"
      alias glp='gl -p'
      alias gls='gl --stat'
      alias glsa='gla --stat'
      alias glsp='gls -p'
      alias glspa='glaa -p'

      # ALIAS: gm: 'git merge'
      alias gm='git merge'
      alias gma='git merge --abort'
      alias gmc='git merge --continue'
      alias gmd='git merge $(git_develop_branch)'
      alias gmm='git merge $(git_main_branch)'
      alias gmod='gm ''${TDPP_GIT_REMOTE_ORIGIN}/$(git_develop_branch)'
      alias gmom='gm ''${TDPP_GIT_REMOTE_ORIGIN}/$(git_main_branch)'

      # ALIAS: gp: 'git push'
      alias gp='git push'
      alias gpa='git push --all'
      alias gpd_='git push --delete'
      alias gpdo_='gpd_ ''${TDPP_GIT_REMOTE_ORIGIN}'
      alias gpf_='git push --force-with-lease'
      alias gpnv_='git push --no-verify'
      alias gpo='git push ''${TDPP_GIT_REMOTE_ORIGIN}'
      alias gpt='git push --tags'
      alias gpta='git push --tags --all'
      alias gpu='git push -u'
      alias gpuo='git push -u ''${TDPP_GIT_REMOTE_ORIGIN}'
      alias gpuoc='git push -u ''${TDPP_GIT_REMOTE_ORIGIN} $(git_current_branch)'

      # ALIAS: gpl: 'git pull'
      alias gpl='git pull'

      # ALIAS: gr: 'git remote'
      alias gr='git remote'
      alias gra='git remote add'
      alias grmv='git remote remove'
      alias grrm='git remote remove'
      alias grrmo='git remote remove ''${TDPP_GIT_REMOTE_ORIGIN}'
      alias grrmu='git remote remove ''${TDPP_GIT_REMOTE_UPSTREAM}'
      alias grset='git remote set-url'
      alias grseto='git remote set-url ''${TDPP_GIT_REMOTE_ORIGIN}'
      alias grsetp='git remote set-url --push'
      alias grsetpud='git remote set-url --push ''${TDPP_GIT_REMOTE_UPSTREAM} ''${TDPP_GIT_REMOTE_URL_DISABLED} && git remote -vv'
      alias grsetu='git remote set-url ''${TDPP_GIT_REMOTE_UPSTREAM}'
      alias grsh='git remote set-head'
      alias grsha='git remote set-head --auto'
      alias grshao='git remote set-head --auto ''${TDPP_GIT_REMOTE_ORIGIN}'
      alias grshd='git remote set-head --delete'
      alias grshdo='git remote set-head --delete ''${TDPP_GIT_REMOTE_ORIGIN}'
      alias grv='git remote -v'
      alias grvv='git remote -vv'

      # ALIAS: grb: 'git rebase'
      alias grb='git rebase'
      alias grbi='git rebase -i'
      alias grbod='git rebase ''${TDPP_GIT_REMOTE_ORIGIN}/$(git_develop_branch)'
      alias grbom='git rebase ''${TDPP_GIT_REMOTE_ORIGIN}/$(git_main_branch)'

      # ALIAS: grh: 'git reset'
      alias grh_='git reset'
      alias grhh_='git reset --hard'
      alias grhhl_='git reset --hard HEAD~'
      alias grhho_='grhh ''${TDPP_GIT_REMOTE_ORIGIN}'
      alias grhhod_='grhh ''${TDPP_GIT_REMOTE_ORIGIN}/$(git_develop_branch)'
      alias grhhoh_='git reset --hard ORIG_HEAD' # NOTE: for undoing rebase mistake
      alias grhhom_='grhh ''${TDPP_GIT_REMOTE_ORIGIN}/$(git_main_branch)'
      alias grhk_='git reset --keep'
      alias grhl_='git reset HEAD~'
      alias grhom_='grh ''${TDPP_GIT_REMOTE_ORIGIN}/$(git_main_branch)'
      alias grhs_='git reset --soft'

      # ALIAS: grm: 'git rm'
      alias grm='git rm'
      alias grma='git rm --all'
      alias grmc='git rm --cached'
      alias grmca='git rm --cached .'
      alias grmcaa='grmca && gaa'
      alias grmcr='git rm --cached -r'

      # ALIAS: grs: 'git restore'
      alias grs='g rs'
      alias grss='g rss'
      alias grssd='g rss $(git_develop_branch)'
      alias grssm='g rss $(git_main_branch)'
      alias grsta='grst ''${LA_FILES_ALL}'

      # ALIAS: gsm: 'git submodule'
      alias gsm='g sm'
      alias gsma='g sma'
      alias gsmhh='g smhh'
      alias gsmhl='g smhl'
      alias gsmj='g smj'
      alias gsmu='g smu'

      # ALIAS: gst: 'git status'
      alias gst='git status'

      # ALIAS: gsts: 'git stash'
      alias gstap_='g stap'
      alias gstk='g stk'
      alias gstkm='g stkm'
      alias gstkt='g stkm "''${TDPP_GIT_COMMIT_MSG_TEMP}"'
      alias gstkw='g stkm "''${TDPP_GIT_COMMIT_MSG_WIP}"'
      alias gstl='g stl'
      alias gstp_='g stp'
      alias gsts='g sts'
      alias gstu_='g stu'

      # ALIAS: gt: 'git tag'
      alias gt='g t'
      alias gtd='g td'
      alias gtdf_='g tdf'
      # alias gtdf_='gt -D'

      alias gtdo='gtd ''${TDPP_GIT_REMOTE_ORIGIN}'
      alias gtdo_='gtd_ ''${TDPP_GIT_REMOTE_ORIGIN}'

      # ALIAS: gui: 'git update'-index
      alias gui='g ui'

      ############################################################
      # ALIAS: h: *
      ############################################################

      # ALIAS: h: history
      alias hc='h -d'
      alias hdup='h --duplicates'
      alias hhh='h --help'
      alias hhl='hhh BLH'
      alias hi='h -i'
      alias hn='h -n'
      alias hs='h --session'
      alias hsys='h '
      alias hver='h --version'

      ############################################################
      # ALIAS: j: *
      ############################################################

      # ALIAS: j: z (zoxide)
      # alias j='z'
      alias jf='j .config'
      alias jfc='j chez'
      alias jfx='j nix'

      # ALIAS: jc: zoxide (zoxide)
      alias jc='zoxide'
      ## ALIAS: jcs: zoxide query
      alias jcs='jc query'
      ## ALIAS: jl: zoxide query -ls
      alias jl='jcs -ls'
      alias jlc='jl G "$(pwd)\$"'
      alias jlr='jl G "$(pwd)"'

      ############################################################
      # ALIAS: l: *
      ############################################################

      alias l='eza -1lhm -F --color=auto --icons=auto --git --group-directories-first'

      # pnpm is a javascript package manager
      alias pn=pnpm
      alias pnx=pnpx

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'

      ############################################################
      # Plugin Settings
      ############################################################

      #
      # docker
      #

      zstyle ":completion:*:*:docker:*" option-stacking yes
      zstyle ":completion:*:*:docker-*:*" option-stacking yes

      # Enable BuildKit
      export DOCKER_BUILDKIT=1
      export COMPOSE_DOCKER_CLI_BUILD=1

      #
      # fzf
      #

      # Set to fzf installation directory path
      export FZF_BASE="$TDPP_HOMEBREW_BIN_PATH/fzf" \
        || export FZF_BASE="$ASDF_DIR/shims/fzf" \
        || export FZF_BASE="/usr/bin/fzf" \
        || export FZF_BASE="/bin/fzf"

      # Default command to use when input is tty
      export FZF_DEFAULT_COMMAND="fd --type f"

      # # Use the CLI ripgrep to respect ignore files (like '.gitignore'),
      # # display hidden files, and exclude the '.git' directory.
      # export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

      # # Interactive ripgrep integration
      # INITIAL_QUERY=""
      # RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
      # FZF_DEFAULT_COMMAND="$RG_PREFIX \"$INITIAL_QUERY\"" \
      #   fzf --bind "change:reload:$RG_PREFIX {q} || true" \
      #       --ansi --disabled --query "$INITIAL_QUERY" \
      #       --height=50% --layout=reverse

      # REF: https://www.mankier.com/1/fzf#Key/Event_Bindings
      export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --ansi"
      # export FZF_DEFAULT_OPTS="--height=60% --layout=reverse --border --ansi --inline-info --bind=alt-j:down,alt-k:up,ctrl-d:half-page-down,ctrl-u:half-page-up"

      # Uncomment the following line to disable fuzzy completion
      export DISABLE_FZF_AUTO_COMPLETION="false"

      # Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
      export DISABLE_FZF_KEY_BINDINGS="false"

      # # WRKA: disable fzf at fuzzy file completion
      # zstyle ":completion:*" matcher-list ""

      export FZF_TMUX=1
      export FZF_TMUX_OPTS="--height=80%"

      # Use ~~ as the trigger sequence instead of the default **
      export FZF_COMPLETION_TRIGGER='~~'

      # Options to fzf command
      # export FZF_COMPLETION_OPTS='--height=100% --border --info=inline'
      export FZF_COMPLETION_OPTS='--height=100% --border --info=inline --tiebreak=chunk'

      # Use fd (https://github.com/sharkdp/fd) instead of the default find
      # command for listing path candidates.
      # - The first argument to the function ($1) is the base path to start traversal
      # - See the source code (completion.{bash,zsh}) for the details.
      _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
      }

      # Use fd to generate the list for directory completion
      _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
      }

      # NOTE: (EXPERIMENTAL)
      # Advanced customization of fzf options via _fzf_comprun function
      #
      # - The first argument to the function is the name of the command.
      # - You should make sure to pass the rest of the arguments to fzf.
      _fzf_comprun() {
        local command=$1
        shift
        case "$command" in
          # cd|ls)        fzf "$@" --preview 'tree -C {} | head -200' ;;
          cd|ls)        fzf "$@" --preview 'bat --style=numbers --color=always --line-range :500 {}' ;;
          export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
          ssh)          fzf "$@" --preview 'dig {}' ;;
          *)            fzf "$@" ;;
        esac
      }

      # # usage: _fzf_setup_completion path|dir|var|alias|host COMMANDS...
      # _fzf_setup_completion path ag git kubectl
      # _fzf_setup_completion dir tree

      # Custom fuzzy completion for "doge" command
      #   e.g. doge **<TAB>
      function _fzf_complete_doge() {
        _fzf_complete --multi --reverse --prompt="doge> " -- "$@" < <(
          echo very
          echo wow
          echo such
          echo doge
        )
      }

      #
      # magic-enter
      #

      export MAGIC_ENTER_GIT_COMMAND=''${MAGIC_ENTER_GIT_COMMAND:-'git status -sb .'}
      export MAGIC_ENTER_OTHER_COMMAND=''${MAGIC_ENTER_OTHER_COMMAND:-'eza -1lhm -F --color=auto --icons=auto --git --group-directories-first -a'}

      # magic-enter alternative
      # REF: <https://github.com/zshzoo/magic-enter>
      # TODO: Error on shell init => /Users/ssm/.zshrc:819: not an identifier: git status -sb .
      # zstyle -s ':zshzoo:magic-enter' command 'ls -laFh .'
      # zstyle -s ':zshzoo:magic-enter' git-command 'git status -sb .'
      # zstyle -s ':zshzoo:magic-enter' command "$MAGIC_ENTER_OTHER_COMMAND"
      # zstyle -s ':zshzoo:magic-enter' git-command "$MAGIC_ENTER_GIT_COMMAND"

      function magic-enter-cmd {
        if command git rev-parse --is-inside-work-tree &>/dev/null; then
          echo "git status -sb ."
          # echo "$MAGIC_ENTER_GIT_COMMAND"
        else
          # echo "ls -laFh ."
          echo "$MAGIC_ENTER_OTHER_COMMAND"
        fi
      }

      #
      # zsh-autosuggestions
      #

      # # TODO: never suggest anything 140 characters or longer on MOSH
      # # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
      # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999999"
      # # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

      # ZSH_AUTOSUGGEST_STRATEGY=(history completion)

      # ZSH_AUTOSUGGEST_COMPLETION_IGNORE="?(#c140,)"
      # ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c140,)"
      # # ZSH_AUTOSUGGEST_HISTORY_IGNORE="t rc*"

      ############################################################
      # Keybindings
      ############################################################

      bindkey -M vicmd "^[k" up-history
      bindkey -M viins "^[k" up-history
      bindkey -M vicmd "^[j" down-history
      bindkey -M viins "^[j" down-history

      #
      # Keybindings for zsh-autosuggestions
      #

      bindkey -M vicmd "^L" autosuggest-accept
      bindkey -M viins "^L" autosuggest-accept

      #
      # Keybindings for zsh-history-substring-search
      #

      bindkey -M vicmd "^K" history-beginning-search-backward
      bindkey -M viins "^K" history-beginning-search-backward
      bindkey -M vicmd "^J" history-beginning-search-forward
      bindkey -M viins "^J" history-beginning-search-forward

      bindkey -M vicmd "^N" history-substring-search-up
      bindkey -M viins "^N" history-substring-search-up
      bindkey -M vicmd "^P" history-substring-search-down
      bindkey -M viins "^P" history-substring-search-down

      bindkey -M vicmd "^[l" forward-word
      bindkey -M viins "^[l" forward-word
      bindkey -M vicmd "^[h" backward-word
      bindkey -M viins "^[h" backward-word

      # HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=
      # HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=
      # HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS=
      # HISTORY_SUBSTRING_SEARCH_FUZZY=
      # HISTORY_SUBSTRING_SEARCH_PREFIXED=
      HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
      # HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_TIMEOUT=

      # #
      # # vi-mode
      # # TODO: above keybindings now working on viins after loading zsh-vi-mode!
      # #
      #
      # typeset -g VI_MODE_RESET_PROMPT_ON_MODE_CHANGE='true'
      # typeset -g VI_MODE_SET_CURSOR='true'
      #
      # export MODE_INDICATOR="%B%F{red}<%b<<%f"
      # export INSERT_MODE_INDICATOR="%F{yellow}+%f"

      #
      # Keybindings for vi-mode
      #

      bindkey -M vicmd "vv" edit-command-line

      bindkey -M vicmd "H" beginning-of-line
      bindkey -M vicmd "L" end-of-line

      # fix with vi mode delete doesn't work
      # REF: <https://vi.stackexchange.com/a/31672/34771>
      bindkey "^H" backward-delete-char
      bindkey "^?" backward-delete-char

      ############################################################
      # Autoloads and Completions                                #
      ############################################################

      zstyle ':compinstall' filename "$HOME/.zshrc"

      #
      # zstyle ':completion:*'
      #
      zstyle ':completion:*' completer _expand _complete _ignored
      zstyle ':completion:*' expand prefix suffix
      zstyle ':completion:*' file-patterns '*(-/):directories:directories %p:other-files'
      zstyle ':completion:*' ignore-parents 'parent pwd directory'
      zstyle ':completion:*' ignore-patterns '^\..$'
      zstyle ':completion:*' insert-unambiguous false
      zstyle ':completion:*' list-dirs-first true
      zstyle ':completion:*' list-suffixes true
      zstyle ':completion:*' max-errors 2
      zstyle ':completion:*' rehash true
      zstyle ':completion::complete:*' gain-privileges 1

      fpath=(
          "''${TDPP_LIB_SH_ZSH_COMPLETION_PATH}"
          "''${HOME}/.zfunc"
          ''${fpath}
      )
    '';
  };
}
