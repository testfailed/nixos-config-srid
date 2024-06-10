{ pkgs, config, ... }:
{
  home.packages = [
    # Open tmux for current project.
    (pkgs.writeShellApplication {
      name = "pux";
      runtimeInputs = [ pkgs.tmux ];
      text = ''
        PRJ="''$(zoxide query -i)"
        echo "Launching tmux for ''$PRJ"
        set -x
        cd "''$PRJ" && \
          exec tmux -S "''$PRJ".tmux attach
      '';
    })
  ];

  programs.tmux = {
    enable = true;

    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    escapeTime = 0; # Stop tmux+escape craziness.
    newSession = true;
    secureSocket = false; # Force tmux to use /tmp for sockets (WSL2 compat)
    shortcut = "a";

    # TODO: conflicts with zsh-completions
    # tmuxinator = {
    #   enable = true; # *: false
    # };

    tmuxp = {
      enable = true; # *: false
    };

    plugins = with pkgs.tmuxPlugins; [
      # vim-tmux-navigator # NOTE: it cause <C-hjkl> not working on tmux.
      better-mouse-mode
      copycat
      open
      prefix-highlight
      sensible
      tmux-fzf # TODO: setup REF: <https://github.com/sainnhe/tmux-fzf>
      yank
      {
        plugin = power-theme;
        extraConfig = ''
           set -g @tmux_power_theme 'gold'
        '';
      }
      {
        plugin = resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          # TODO: it saves to '\\/Users/ssm/...'
          # set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
          set -g @resurrect-dir '${config.home.homeDirectory}/.cache/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'

          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '3' # minutes
        '';
      }
    ];

    # extraConfig = ''
    #   # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
    #   set -g default-terminal "xterm-256color"
    #   set -ga terminal-overrides ",*256col*:Tc"
    #   set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
    #   set-environment -g COLORTERM "truecolor"
    #
    #   # Mouse works as expected
    #   set-option -g mouse on
    #   # easy-to-remember split pane commands
    #   bind | split-window -h -c "#{pane_current_path}"
    #   bind - split-window -v -c "#{pane_current_path}"
    #   bind c new-window -c "#{pane_current_path}"
    # '';

    extraConfig = ''
      # Remove Vim mode delays
      set -g focus-events on

      # Enable full mouse support
      set -g mouse on

      # -----------------------------------------------------------------------------
      # Key bindings
      # -----------------------------------------------------------------------------

      # Unbind default keys
      unbind C-b

      unbind C-h
      unbind C-j
      unbind C-k
      unbind C-l

      # some useful <C-a> combinations
      # bind-key r source-file ~/.tmux.conf \; display "Reloaded from ~/.tmux.conf"
      bind-key : command-prompt
      bind-key L clear-history
      bind-key b display "#{pane_width}x#{pane_height}"

      bind-key C-l next-window
      bind-key C-h previous-window
      bind-key enter next-layout
      bind-key C-o rotate-window

      # Split panes, vertical or horizontal
      # create pane/window on CWD
      bind-key '"' split-window -c "#{pane_current_path}"
      bind-key % split-window -h -c "#{pane_current_path}"
      bind-key c new-window -c "#{pane_current_path}"
      bind-key C-x kill-pane

      # Resize pane (and then enter the resize mode)
      # We make the <, >, +, - key repeatable (with shift hold) by using "resize-pane" keytable
      bind-key > resize-pane -R 10 \; switch-client -T "resize-pane"
      bind-key < resize-pane -L 10 \; switch-client -T "resize-pane"
      bind-key -T "resize-pane" > resize-pane -R 5 \; switch-client -T "resize-pane"
      bind-key -T "resize-pane" < resize-pane -L 5 \; switch-client -T "resize-pane"

      bind-key + resize-pane -D 5  \; switch-client -T "resize-pane"
      bind-key - resize-pane -U 5  \; switch-client -T "resize-pane"
      bind-key -T "resize-pane" + resize-pane -D \; switch-client -T "resize-pane"
      # bind-key -T "resize-pane" = resize-pane -D \; switch-client -T "resize-pane"
      # bind-key -T "resize-pane" - resize-pane -U \; switch-client -T "resize-pane"
      # bind-key -T "resize-pane" _ resize-pane -U \; switch-client -T "resize-pane"

      # resize-pane mode: support h, j, k, l, and arrow keys
      bind-key -T "resize-pane" k resize-pane -U \; switch-client -T "resize-pane"
      bind-key -T "resize-pane" j resize-pane -D \; switch-client -T "resize-pane"
      bind-key -T "resize-pane" h resize-pane -L \; switch-client -T "resize-pane"
      bind-key -T "resize-pane" l resize-pane -R \; switch-client -T "resize-pane"

      bind-key -T "resize-pane" Up    resize-pane -U 5 \; switch-client -T "resize-pane"
      bind-key -T "resize-pane" Down  resize-pane -D 5 \; switch-client -T "resize-pane"
      bind-key -T "resize-pane" Left  resize-pane -L 5 \; switch-client -T "resize-pane"
      bind-key -T "resize-pane" Right resize-pane -R 5 \; switch-client -T "resize-pane"

      # force Vi mode
      # really you should export VISUAL or EDITOR environment variable, see manual
      set -g mode-keys vi
      set -g status-keys vi

      # Act like Vim
      set-window-option -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # bind-key -n M-h select-pane -L
      # bind-key -n M-j select-pane -D
      # bind-key -n M-k select-pane -U
      # bind-key -n M-l select-pane -R

      # toggle synchronize-panes
      bind-key C-y set-window-option synchronize-panes\; display-message "synchronize-panes is now #{?pane_synchronized,on,off}"

      # switch to last window
      bind-key n last-window

      # switch to last session
      bind-key C-n switch-client -l

      # swap window left and right
      bind-key C-j swap-window -t -1\; select-window -t -1
      bind-key C-k swap-window -t +1\; select-window -t +1

      # Save buffer to a file
      bind-key P command-prompt -p 'save history to filename:' -I '~/tmux.history' 'capture-pane -S -32768 ; save-buffer %1 ; delete-buffer'

      # Copy-paste between the system and Tmux clipboard
      # REQUIRE: 'brew install xclip'
      bind-key -T copy-mode-vi y send-keys -X copy-pipe "xclip -sel clip -i"

      # Mouse copying behaviour
      # => Copy but do not clear the selection:
      bind-key -T copy-mode-vi MouseDragEnd1Pane send -X copy-selection-no-clear

      ###########################################################
      # Configs                                                 #
      ###########################################################

      # True Color (24-bit) and italics with alacritty + tmux + vim (neovim)
      # REF: <https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6>
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      # set -g default-terminal "screen-256color"
      # set -g default-terminal "tmux-256color"

      # nvim compatibility
      set -sa terminal-overrides ',xterm-256color:RGB'

      # increase history size
      set -g history-limit 20000

      # start with mouse mode enabled
      set -g mouse on

      # reduce repeat-delay
      set -g repeat-time 300
      set -sg escape-time 0

      # REF: https://github.com/tmux-plugins/vim-tmux-focus-events
      set -g focus-events on

      # start window numbers at 1 to match keyboard order with tmux window order
      set -g base-index 1
      # set-window-option -g pane-base-index 1
      set -wg pane-base-index 1

      # renumber windows sequentially after closing any of them
      set -g renumber-windows on

      # Align status menu to absolute center.
      set -g status-justify absolute-centre

      # Set status update interval to 10sec.
      set -g status-interval 10

      WEATHER='#(curl -s wttr.in/Bucheon:Seoul:Incheon\?format\="%%l:+%%c%%20%%f%%60+%%t%%60+%%h+%%p+%%w+uv:%%u&period=10")'
      # set -g status-right "#{prefix_highlight} $WEATHER %a"
      set -g status-right "$WEATHER #{prefix_highlight} | %a %Y-%m-%d %H:%M"

      # soften status bar color from harsh green to light gray
      # set -g status-style bg='#555555',fg='#dddddd'

      set -g window-status-last-style 'underscore'

      #
      # TODO:
      #

      # Move around panes with vim-like bindings (h,j,k,l)
      bind-key -n M-k select-pane -U
      bind-key -n M-h select-pane -L
      bind-key -n M-j select-pane -D
      bind-key -n M-l select-pane -R

      # # Smart pane switching with awareness of Vim splits.
      # # This is copy paste from https://github.com/christoomey/vim-tmux-navigator
      # is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
      #   | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      # bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      # bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      # bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      # bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      # if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
      #   "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      # if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
      #   "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -n M-\\ select-pane -l

      bind-key -T copy-mode-vi 'M-h' select-pane -L
      bind-key -T copy-mode-vi 'M-j' select-pane -D
      bind-key -T copy-mode-vi 'M-k' select-pane -U
      bind-key -T copy-mode-vi 'M-l' select-pane -R
      bind-key -T copy-mode-vi 'M-\' select-pane -l
    '';
  };
}
