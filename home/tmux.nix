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

      ###########################################################
      # Keybindings
      ###########################################################

      # Unbind unused default keys (to avoid conflicts with other apps)
      unbind C-b
      unbind C-h
      unbind C-j
      unbind C-k
      unbind C-l

      # some useful <C-a> combinations
      bind R \
        source ~/.config/tmux/tmux.conf \; \
        display "Reloaded from ~/.config/tmux/tmux.conf"
      bind : command-prompt
      bind L clear-history
      bind b display "#{pane_width}x#{pane_height}"

      #
      # Session
      #

      # bind C-H switch-client -p
      # bind C-L switch-client -n
      bind C-p switch-client -p
      bind C-n switch-client -n
      # bind C-\; switch-client -l
      # bind C-' switch-client -l
      bind C-, switch-client -l

      # bind -n M-H switch-client -p
      # bind -n M-L switch-client -n
      # bind -n M-N switch-client -l
      bind -n M-P switch-client -p
      bind -n M-N switch-client -n
      bind -n M-, switch-client -l

      #
      # Window
      #

      # bind h previous-window
      # bind l next-window
      # bind n last-window
      bind p previous-window
      bind n next-window
      bind \' last-window

      # bind -n M-h previous-window
      # bind -n M-l next-window
      # bind -n M-n last-window
      bind -n M-p previous-window
      bind -n M-n next-window
      # bind -n M-\' last-window
      # bind -n M-S-\' last-window

      # swap window left and right
      bind C-j swap-window -t +1\; select-window -t +1
      bind C-k swap-window -t -1\; select-window -t -1
      bind -n M-J swap-window -t +1\; select-window -t +1
      bind -n M-K swap-window -t -1\; select-window -t -1

      #
      # Pane
      #

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R
      # bind -n M-\; select-pane -l
      # bind -n M-S-\; select-pane -l

      bind -n -T copy-mode-vi M-h select-pane -L
      bind -n -T copy-mode-vi M-j select-pane -D
      bind -n -T copy-mode-vi M-k select-pane -U
      bind -n -T copy-mode-vi M-l select-pane -R
      bind -n -T copy-mode-vi M-\; select-pane -l

      # bind enter next-layout
      bind C-o rotate-window

      bind -n M-x confirm-before -p "kill-pane #P? (y/n)" kill-pane
      bind -n M-X confirm-before -p "kill-window #W? (y/n)" kill-window

      # Split panes, vertical or horizontal
      # create pane/window on CWD
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind \\ split-window -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Resize pane (and then enter the resize mode)
      # We make the <, >, +, - key repeatable (with shift hold) by using "resize-pane" keytable
      bind > resize-pane -R 10 \; switch-client -T "resize-pane"
      bind < resize-pane -L 10 \; switch-client -T "resize-pane"
      bind -T "resize-pane" > resize-pane -R 5 \; switch-client -T "resize-pane"
      bind -T "resize-pane" < resize-pane -L 5 \; switch-client -T "resize-pane"

      bind + resize-pane -D 5  \; switch-client -T "resize-pane"
      bind - resize-pane -U 5  \; switch-client -T "resize-pane"
      bind -T "resize-pane" + resize-pane -D \; switch-client -T "resize-pane"
      # bind -T "resize-pane" = resize-pane -D \; switch-client -T "resize-pane"
      # bind -T "resize-pane" - resize-pane -U \; switch-client -T "resize-pane"
      # bind -T "resize-pane" _ resize-pane -U \; switch-client -T "resize-pane"

      # resize-pane mode: support h, j, k, l, and arrow keys
      bind -T "resize-pane" k resize-pane -U \; switch-client -T "resize-pane"
      bind -T "resize-pane" j resize-pane -D \; switch-client -T "resize-pane"
      bind -T "resize-pane" h resize-pane -L \; switch-client -T "resize-pane"
      bind -T "resize-pane" l resize-pane -R \; switch-client -T "resize-pane"

      bind -T "resize-pane" Up    resize-pane -U 5 \; switch-client -T "resize-pane"
      bind -T "resize-pane" Down  resize-pane -D 5 \; switch-client -T "resize-pane"
      bind -T "resize-pane" Left  resize-pane -L 5 \; switch-client -T "resize-pane"
      bind -T "resize-pane" Right resize-pane -R 5 \; switch-client -T "resize-pane"

      # force Vi mode
      # really you should export VISUAL or EDITOR environment variable, see manual
      set -g mode-keys vi
      set -g status-keys vi

      # Act like Vim
      # set-window-option -g mode-keys vi
      setw -g mode-keys vi

      # toggle synchronize-panes
      bind C-y set-window-option synchronize-panes\; display-message "synchronize-panes is now #{?pane_synchronized,on,off}"

      # Save buffer to a file
      bind P command-prompt -p 'save history to filename:' -I '~/tmux.history' 'capture-pane -S -32768 ; save-buffer %1 ; delete-buffer'

      # Copy-paste between the system and Tmux clipboard
      # REQUIRE: 'brew install xclip'
      bind -T copy-mode-vi y send-keys -X copy-pipe "xclip -sel clip -i"

      # Mouse copying behaviour
      # => Copy but do not clear the selection:
      bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-selection-no-clear

      ###########################################################
      # Configs
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
      setw -g pane-base-index 1

      # renumber windows sequentially after closing any of them
      set -g renumber-windows on

      # Align status menu to absolute center.
      set -g status-justify absolute-centre

      # Set status update interval to 5sec.
      set -g status-interval 5

      WEATHER='#(${pkgs.curl}/bin/curl -s wttr.in/Bucheon\?format\="%%c%%f%%60+%%h+%%p+%%u")'
      set -g status-right "$WEATHER #{prefix_highlight} | %a %Y-%m-%d %H:%M "

      set -g window-status-last-style 'underscore'
    '';
  };
}
