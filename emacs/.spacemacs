;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation nil
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '((
      python
      ;python
      auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t)
     (haskell         :variables
                      haskell-completion-backend 'ghc-mod)
     asciidoc
     bibtex
     chrome
     clojure
     common-lisp
     colors
     docker
     ess
     emacs-lisp
     emoji
     git
     github
     html
     helm
     javascript
     latex
     markdown
     nginx
     nlinum
     org
     nixos
     ;pandoc
     pdf-tools
     purescript
     ;python
     ranger
     rust
     (shell :variables
            shell-default-height 33
            shell-default-position 'bottom
            shell-default-full-span nil)
     slack
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     sql
     syntax-checking
     theming
     tmux
     (version-control :variables
                       version-control-global-margin t)
     vimscript
     yaml)
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(all-the-icons
                                      exec-path-from-shell
                                      evil-mc
                                      fringe-helper
                                      solaire-mode
                                      company-math
                                      (stylus-mode :location
                                                   (recipe :fetcher
                                                    github :repo "vladh/stylus-mode")))
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   ;dotspacemacs-excluded-packages '(exec-path-from-shell)
   dotspacemacs-install-packages 'used-but-keep-unused))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.

;  (setq configuration-layer-elpa-archives '(("melpa"     . "http://melpa.org/packages/")
;                                            ("marmalade" . "http://marmalade-repo.org/packages/")
;                                            ("org"       . "http://orgmode.org/elpa/")
;                                            ("gnu"       . "http://elpa.gnu.org/packages/")))

                                           ; ("gnu"   . "elpa.zilongshanren.com/gnu/")))
  (setq-default
   dotspacemacs-elpa-https nil
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner nil
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists nil
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(doom-one)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Iosevka"
                               :size 24
                               :weight regular
                               ; :width normal
                               :powerline-scale 1.2)
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header t
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar nil
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   ;dotspacemacs-fullscreen-at-startup t
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native t
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
Called immediately after `dotspacemacs/init', before layer configuration
executes and packages are loaded."
  (setq exec-path-from-shell-arguments '("-l"))
  (add-to-list 'exec-path "~/.cabal/bin/")
  )

(defun dotspacemacs/user-config ()

  ;;--------
  ;; startup
  ;;--------

  (setq inhibit-startup-screen t)
  (setq inhibit-startup-message t)
  (when (string= "*scratch*" (buffer-name))
    (spacemacs/switch-to-scratch-buffer))

  ;;--
  ;; UI
  ;;---

  ;; hide stationary cursor
  (setq make-pointer-invisible t)

  ;; powerline
  (setq powerline-default-separator 'nil)

  ;; doom settings
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)

  ;; neotree
  (setq neo-theme 'icons)
  (doom-themes-neotree-config)
  (setq neo-banner-message nil)
  (setq neo-mode-line-type 'none)

  (with-eval-after-load 'neotree
    (defun neotree-fix-popup ()
      "Ensure the fringe settings are maintained on popup restore."
      (neo-global--when-window
       (doom--neotree-no-fringes)))
    (add-hook 'doom-popup-mode-hook #'neotree-fix-popup))

  ;; doom org mode
  (doom-themes-org-config)

  ;; native border "consumes" fringe pixel on right-most splits `window-divider' doesn't
  (setq-default window-divider-default-places t
                window-divider-default-bottom-width 0
                window-divider-default-right-width 1)
  (add-hook 'doom-init-ui-hook #'window-divider-mode)

  ;; code-folding overlays with fringe indicators
  (setq hs-set-up-overlay
    (lambda (ov)
      (when (eq 'code (overlay-get ov 'hs))
        (when (featurep 'vimish-fold)
          (overlay-put
           ov 'before-string
           (propertize "…" 'display
                       (list vimish-fold-indication-mode
                             'empty-line
                             'vimish-fold-fringe))))
        (overlay-put
         ov 'display (propertize "  [...]  " 'face '+doom-folded-face)))))

  ;(with-eval-after-load 'flycheck
  ;  (require 'fringe-helper)
  ;  ;; because git-gutter is in the left fringe
  ;  (setq flycheck-indication-mode 'right-fringe)
  ;  ;; A non-descript, left-pointing arrow
  ;  (fringe-helper-define 'flycheck-fringe-bitmap-double-arrow 'center
  ;    "...X...."
  ;    "..XX...."
  ;    ".XXX...."
  ;    "XXXX...."
  ;    ".XXX...."
  ;    "..XX...."
  ;    "...X...."))

  ;; diff indicators in the fringe
  (with-eval-after-load 'git-gutter-fringe
    (require 'fringe-helper)
    ;; places the git gutter outside margins
    (setq-default fringes-outside-margins t)
    ;; thin fringe bitmaps
    (fringe-helper-define 'git-gutter-fr:added '(center repeated)
      "XXX.....")
    (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
      "XXX.....")
    (fringe-helper-define 'git-gutter-fr:deleted 'bottom
      "X......."
      "XX......"
      "XXX....."
      "XXXX...."))

  ;; brighten buffers (that represent real files)
  (add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)
  ;; To enable solaire-mode unconditionally for certain modes:
  (add-hook 'ediff-prepare-buffer-hook #'solaire-mode)
  ;; ...if you use auto-revert-mode:
  (add-hook 'after-revert-hook #'turn-on-solaire-mode)
  ;; highlight the minibuffer when it is activated:
  (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)
  (solaire-mode-swap-bg)

  ;; theme modifications
  ;(custom-theme-set-faces
  ; 'doom-one
  ; '(font-lock-comment-face ((t (:foreground "#DFAF8F"))))
  ; '(font-lock-comment-delimiter-face ((t (:foreground "#DFAF8F")))))

  (setq rainbow-mode t)

  ;;--------
  ;; unicode
  ;;--------

  (global-company-mode)

  ;;-----------------
  ;; default behavior
  ;;-----------------

  (recentf-mode 1)
  (run-at-time (current-time) 300 'recentf-save-list)

  (setq x-select-enable-clipboard t)
  (setq vc-follow-symlinks t)

  ;; multiple cursors
  (global-evil-mc-mode  1)

  ;;---------
  ;; snippets
  ;;---------

  ;(setq yas-snippet-dirs
  ;      '("~/.emacs.d/snippets"))

  (yas-global-mode)

  ;;------------
  ;; programming
  ;;------------

  ;; clojure
  (setq clojure-enable-fancify-symbols t)
  (setq explicit-shell-file-name "/bin/bash")
  (setq neo-smart-open t)
  (setq cider-repl-use-pretty-printing t)

  ;; javascript
  (setq js-indent-level 2)
  (setq-default indent-tabs-mode nil)

  ;; spacing
  (defun my-setup-indent (n)
    ;; web development
    (setq coffee-tab-width n) ; coffeescript
    (setq javascript-indent-level n) ; javascript-mode
    (setq js-indent-level n) ; js-mode
    (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
    (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
    (setq web-mode-css-indent-offset n) ; web-mode, css in html file
    (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
    (setq css-indent-offset n) ; css-mode
    )

  (my-setup-indent 2)

  ;;--------
  ;; haskell
  ;;--------

  (setq haskell-process-wrapper-function
        (lambda (args) (apply 'nix-shell-command (nix-current-sandbox) args)))

  ;;----
  ;; nix
  ;;----

  (require 'package)

  ;; makes unpure packages archives unavailable
  (setq package-archives nil)

  (setq package-enable-at-startup nil)
  (package-initialize)


  ;;------------
  ;; keybindings
  ;;------------

  (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)

  (define-key evil-motion-state-map (kbd "C-h") #'evil-window-left)
  (define-key evil-motion-state-map (kbd "C-j") #'evil-window-down)
  (define-key evil-motion-state-map (kbd "C-k") #'evil-window-up)
  (define-key evil-motion-state-map (kbd "C-l") #'evil-window-right)

  (add-hook 'term-load-hook
    (lambda ()
      (define-key term-raw-map (kbd "C-S-h") 'windmove-left)
      (define-key term-raw-map (kbd "C-S-j") 'windmove-down)
      (define-key term-raw-map (kbd "C-S-k") 'windmove-up)
      (define-key term-raw-map (kbd "C-S-l") 'windmove-right)
      `term-char-mode
      ))

  (spacemacs/set-leader-keys
    "bd" 'kill-buffer-and-window)


  ;;-------
  ;; python
  ;;-------

  ;(eval-after-load 'python `(evil-define-key 'normal python-mode-map [f5] 'python-shell-send-buffer))

  ;;----
  ;; tex
  ;;----

  (remove-hook 'text-mode-hook 'turn-on-auto-fill)
  (add-hook 'LaTeX-mode-hook
            'spacemacs/toggle-auto-fill-mode-off
            'append)

  (add-hook 'LaTeX-mode-hook
            'toggle-word-wrap
            'append)
  ;;----
  ;; ess
  ;;----

  (add-hook 'ess-mode-hook
            (lambda ()
              (define-key ess-extra-map (kbd "C-S-h") 'windmove-left)
              (define-key ess-extra-map (kbd "C-S-j") 'windmove-down)
              (define-key ess-extra-map (kbd "C-S-k") 'windmove-up)
              (define-key ess-extra-map (kbd "C-S-l") 'windmove-right)
              `term-char-mode
              ))
  (setq ess-smart-S-assign-key ":")
  (ess-toggle-S-assign nil)
  (ess-toggle-S-assign nil)
  (ess-toggle-underscore nil) ; leave underscore key alone!

  (add-hook 'ess-help-mode-hook
            (lambda ()
              (define-key ess-extra-map (kbd "C-h") #'evil-window-left)
              (define-key ess-extra-map (kbd "C-j") #'evil-window-down)
              (define-key ess-extra-map (kbd "C-k") #'evil-window-up)
              (define-key ess-extra-map (kbd "C-l") #'evil-window-right)
              `term-char-mode
              ))

  ;;-----
  ;; keys
  ;;-----

  (load-file "/home/hxrts/system/keys/keys.el")

)
;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-flycheck-mode t)
 '(package-selected-packages
   (quote
    (org-mime auctex-latexmk toml-mode racer flycheck-rust cargo rust-mode stylus-mode web-beautify livid-mode skewer-mode simple-httpd js2-refactor js2-mode js-doc company-tern tern coffee-mode company-math math-symbol-lists ranger ess-smart-equals ess-R-data-view ctable ess julia-mode company-quickhelp nix-mode helm-nixos-options company-nixos-options nixos-options helm-ext slack emojify circe oauth2 websocket rainbow-mode rainbow-identifiers color-identifiers-mode solaire-mode yapfify yaml-mode web-mode vimrc-mode tagedit sql-indent slime-company slime slim-mode scss-mode sass-mode reveal-in-osx-finder pyvenv pytest pyenv-mode py-isort pug-mode psci purescript-mode psc-ide pip-requirements pbcopy pandoc-mode ox-pandoc osx-trash osx-dictionary org-ref pdf-tools key-chord ivy nlinum-relative nlinum nginx-mode magit-gh-pulls live-py-mode less-css-mode launchctl intero hy-mode dash-functional hlint-refactor hindent helm-pydoc helm-hoogle helm-css-scss helm-bibtex parsebib haskell-snippets haml-mode gmail-message-mode ham-mode html-to-markdown github-search github-clone github-browse-file gist gh marshal logito pcache ht flymd flycheck-haskell emoji-cheat-sheet-plus emmet-mode edit-server dockerfile-mode docker json-mode tablist docker-tramp json-snatcher json-reformat dactyl-mode cython-mode company-web web-completion-data company-ghci company-ghc ghc haskell-mode company-emoji company-cabal company-auctex company-anaconda common-lisp-snippets cmm-mode clojure-snippets clj-refactor inflections edn multiple-cursors paredit peg cider-eval-sexp-fu cider seq queue clojure-mode biblio biblio-core auctex anaconda-mode pythonic adoc-mode markup-faces xterm-color unfill smeargle shell-pop orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-download mwim multi-term mmm-mode markdown-toc markdown-mode magit-gitflow htmlize helm-gitignore helm-company helm-c-yasnippet gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck evil-magit magit magit-popup git-commit with-editor eshell-z eshell-prompt-extras esh-help diff-hl company-statistics company auto-yasnippet yasnippet auto-dictionary ac-ispell auto-complete ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async org-plus-contrib evil-unimpaired f s dash))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company-quickhelp nix-mode helm-nixos-options company-nixos-options nixos-options helm-ext slack emojify circe oauth2 websocket rainbow-mode rainbow-identifiers color-identifiers-mode solaire-mode yapfify yaml-mode web-mode vimrc-mode tagedit sql-indent slime-company slime slim-mode scss-mode sass-mode reveal-in-osx-finder pyvenv pytest pyenv-mode py-isort pug-mode psci purescript-mode psc-ide pip-requirements pbcopy pandoc-mode ox-pandoc osx-trash osx-dictionary org-ref pdf-tools key-chord ivy nlinum-relative nlinum nginx-mode magit-gh-pulls live-py-mode less-css-mode launchctl intero hy-mode dash-functional hlint-refactor hindent helm-pydoc helm-hoogle helm-css-scss helm-bibtex parsebib haskell-snippets haml-mode gmail-message-mode ham-mode html-to-markdown github-search github-clone github-browse-file gist gh marshal logito pcache ht flymd flycheck-haskell emoji-cheat-sheet-plus emmet-mode edit-server dockerfile-mode docker json-mode tablist docker-tramp json-snatcher json-reformat dactyl-mode cython-mode company-web web-completion-data company-ghci company-ghc ghc haskell-mode company-emoji company-cabal company-auctex company-anaconda common-lisp-snippets cmm-mode clojure-snippets clj-refactor inflections edn multiple-cursors paredit peg cider-eval-sexp-fu cider seq queue clojure-mode biblio biblio-core auctex anaconda-mode pythonic adoc-mode markup-faces xterm-color unfill smeargle shell-pop orgit org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-download mwim multi-term mmm-mode markdown-toc markdown-mode magit-gitflow htmlize helm-gitignore helm-company helm-c-yasnippet gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gh-md fuzzy flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip flycheck evil-magit magit magit-popup git-commit with-editor eshell-z eshell-prompt-extras esh-help diff-hl company-statistics company auto-yasnippet yasnippet auto-dictionary ac-ispell auto-complete ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async org-plus-contrib evil-unimpaired f s dash))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
