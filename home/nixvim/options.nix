{
  programs.nixvim = {
    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };

    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    opts = {
      # completeopt = "menuone,noselect"; # *: "menu,preview" /// set completion options.
      # foldexpr = ""; # set to "nvim_treesitter#foldexpr()" for treesitter based folding.
      # foldmethod = "manual"; # folding set to "expr" for treesitter based folding.
      # undodir = vim.fn.stdpath("cache") .. "/undo"
      autoindent = true; # Do clever autoindenting
      backup = false; # creates a backup file.
      cmdheight = 1; # _: 1 /// more space in the neovim command line for displaying messages.
      colorcolumn = "80"; # *: "" /// Column highlight
      conceallevel = 0; # so that `` is visible in markdown files.
      cursorcolumn = false; # Highlight the screen column of the cursor
      cursorline = true; # highlight the current line.
      encoding = "utf-8"; # the encoding displayed.
      expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
      fileencoding = "utf-8"; # File-content encoding for the current buffer
      foldlevel = 99; # Folds with a level higher than this number will be closed
      guifont = "monospace:h17"; # the font used in graphical neovim applications.
      hidden = true; # Keep closed buffer open in the background
      hlsearch = true; # highlight all matches on previous search pattern.
      ignorecase = true; # When the search query is lower-case, match both lower and upper-case patterns
      inccommand = "split"; # Search and replace: preview changes in quickfix list
      incsearch = true; # Incremental search: show match for partly typed search command
      laststatus = 3; # When to use a status line for the last window
      modeline = true; # Tags such as 'vim:ft=sh'
      modelines = 100; # Sets the type of modelines
      mouse = "a"; # Enable mouse control
      mousemodel = "extend"; # Mouse right-click extends the current selection
      number = true; # Display the absolute line number of the current line
      numberwidth = 2; # *: 4 /// set number column width to 2.
      pumheight = 10; # *: 0 /// pop up menu height.
      relativenumber = true; # Relative line numbers
      scrolloff = 8; # *: 0 /// start scrolling when the cursor is x lines away from the top/bottom.
      sessionoptions = "buffers,curdir,folds,globals,help,localoptions,skiprtp,resize,tabpages,terminal,winpos,winsize"; # recommended by 'rmagatti/auto-session'.
      # sessionoptions = "buffers,curdir,folds,help,localoptions,tabpages,terminal,winsize,winpos"; # recommended by 'rmagatti/auto-session'.
      # sessionoptions = "buffers,curdir,folds,help,localoptions,skiprtp,resize,tabpages,terminal,winpos,winsize"; # recommended by 'rmagatti/auto-session'.

      # sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"; # recommended by 'rmagatti/auto-session'.
      shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
      showmode = false; # Hide status messages like --- INSERT ---
      showtabline = 2; # *: 1 /// always show tabs.
      sidescroll = 1; # _: 1 /// scroll horizontally one column at a time.
      sidescrolloff = 8; # *: 0 /// start scrolling when the cursor is x columns away from the left/right.
      signcolumn = "yes"; # always show the sign column otherwise it would shift the text each time.
      smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper case characters
      smartindent = true; # *: false /// Do smart autoindenting when starting a new line.
      softtabstop = 2;
      spell = true; # Highlight spelling mistakes (local to window)
      spelllang = "en_us";
      splitbelow = true; # A new window is put below the current one
      splitright = true; # A new window is put right of the current one
      swapfile = true; # *: false /// creates a swapfile.
      tabstop = 4; # Number of spaces a <Tab> in the text stands for (local to buffer)
      termguicolors = true; # set term gui colors. (most terminals support this)
      textwidth = 0; # Maximum width of text that is being inserted.  A longer line will be broken after white space to get this width.
      timeoutlen = 300; # *: 1000 /// time to wait for a mapped sequence to complete (in milliseconds)
      title = true; # set the title of window to the value of the titlestring
      titlestring = "%<%F%=%l/%L - nvim"; # what the title of the window will be set to
      undofile = true; # enable persistent undo
      updatetime = 100; # faster completion
      winheight = 5; # *: 1 /// minimum window height
      winwidth = 30; # *: 1 /// minimum window width
      wrap = false; # Prevent text from wrapping
      writebackup = false; # if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited

      # NOTE: ORDER MATTERS
      # winminheight = 5; # *: 1 /// minimum window height
      # winminwidth = 30; # *: 1 /// minimum window width
    };
  };
}
