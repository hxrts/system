with import <nixpkgs> {};

vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = ''
    syntax on               " enable syntax processing
    set number              " show line numbers
    set numberwidth=4
    set tabstop=2           " number of visual spaces per TAB
    set softtabstop=2       " number of spaces in tab when editing
    set showmatch           " highlight matching [{()}]
    set expandtab           " tabs are spaces
    set incsearch           " search as characters are entered
    set hlsearch            " highlight matches
    set wildmenu            " visual autocomplete for command menu
    set clipboard=unnamedplus
    highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE guifg=DarkGrey guibg=NONE
    filetype on
    filetype plugin indent on
    set backspace=indent,eol,start
  '';
  vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
  vimrcConfig.vam.pluginDictionaries = [
    { names = [
      "ctrlp"
      "ghcmod"
      "hoogle"
      "vim-stylish-haskell"
      "youcompleteme"
      "youcompleteme"
      "vim-css-color"
      "vim-orgmode"
      "vim-markdown"
      "vim-indent-guides"
      "purescript-vim"
      "gitgutter"
      "rainbow_parentheses"
      "vim-nix"
      "surround"
      "vim-addon-nix"
      "vim-trailing-whitespace"
      "vim-pandoc"
    ]; }
  ];
}
