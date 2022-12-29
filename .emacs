(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auctex js2-mode json-mode python vlf sql-indent magit magit-annex magit-filenotify magit-find-file magit-gerrit magit-gh-pulls magit-gitflow magit-imerge magit-org-todos magit-popup magit-stgit magit-svn magit-tbdiff magit-todos magit-topgit magithub format-sql browse-kill-ring markdown-mode csharp-mode desktop+ flymake latex-extra latex-math-preview latex-unicode-math-mode list-unicode-display math-symbol-lists php-mode session web-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/visual-basic-mode.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/csharp-mode.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/latex-pretty-symbols.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/tex-site.el"))
;(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/ESS/lisp/ess-site.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/latex-pretty-symbols.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/guid.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/sunrise-commander.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/sunrise-x-tree.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/sunrise-x-buttons.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/sunrise-x-loop.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/sunrise-x-modeline.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/visual-basic-mode.el"))
(mapc 'load (file-expand-wildcards "~/.emacs.d/site-lisp/xah-math-input.el"))

;; Set larger value for garbage collection (see https://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/)
(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 80000000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

;; Set tab for all files to 4 spaces (see https://stackoverflow.com/questions/69934/set-4-space-indent-in-emacs-in-text-mode)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; TABS for C
(setq-default c-indent-tabs-mode t     ; Pressing TAB should cause indentation
                c-indent-level 4         ; A TAB is equivilent to four spaces
                c-argdecl-indent 0       ; Do not indent argument decl's extra
                c-tab-always-indent t
                backward-delete-function nil) ; DO NOT expand tabs when deleting
  (c-add-style "my-c-style" '((c-continued-statement-offset 4))) ; If a statement continues on the next line, indent the continuation by 4
  (defun my-c-mode-hook ()
    (c-set-style "my-c-style")
    (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
    (c-set-offset 'inline-open '+)
    (c-set-offset 'block-open '+)
    (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
    (c-set-offset 'case-label '+))       ; indent case labels by c-indent-level, too
(require 'csharp-mode)
(defun my-csharp-mode-fn ()
  "function that runs when csharp-mode is initialized for a buffer."
  (setq default-tab-width 4)
  ; Set indentation level to 4 spaces (instead of 2)
  (setq c-basic-offset 4)
  ; Set the extra indentation before a substatement (e.g. the opening brace in
  ; the consequent block of an if statement) to 0 (instead of '+)
  (c-set-offset 'substatement-open 0)
  (setq-default c-basic-offset 4)
)
(add-hook  'csharp-mode-hook 'my-csharp-mode-fn t)
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
(require 'visual-basic-mode)
(setq auto-mode-alist
      (append '(("\\.vb$" . csharp-mode)) auto-mode-alist))
 
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-cy" '(lambda ()
                         (interactive)
                         (popup-menu 'yank-menu)))
(put 'upcase-region 'disabled nil)
;; Always use spaces instead of tabs
(setq-default indent-tabs-mode nil)
 
(defun FindNextDbl ()
  "move to next doubled word, ignoring <...> tags" (interactive)
  (re-search-forward "\\<\\([z-z]+\\)\\([\\n \\t]\\|<[^>]+>\\)+\\1\\?"))
 
(define-key global-map "\C-x\C-d" 'FindNextDbl)
 
;; Search all open buffers
(defun my-multi-occur-in-matching-buffers (regexp &optional allbufs)
  "Show all lines matching REGEXP in all buffers."
  (interactive (occur-read-primary-args))
  (multi-occur-in-matching-buffers ".*" regexp))
(global-set-key (kbd "M-s /") 'my-multi-occur-in-matching-buffers)
 
(setq x-select-enable-clipboard t)
 
(setq auto-mode-alist
  (append
   ;; File name (within directory) starts with a dot.
   '(("/\\.[^/]*\\'" . fundamental-mode)
     ;; File name has no dot.
     ("/[^\\./]*\\'" . fundamental-mode)
     ;; File name ends in ‘.cs’.    
     ("\\.cs$" . csharp-mode)
     ;; File name ends in ‘.vb’.
     ("\\.vb$" . visual-basic-mode)
     ;; File name ends in ‘.txt’.    
     ("\\.txt$" . python-mode)
     ;; File name ends in ‘.sql’.    
     ("\\.sql$" . sql-mode)
     ;; File name ends in ‘.xaml’.    
     ("\\.xaml$" . xml-mode)         
     ;; File name ends in ‘.C’.
     ("\\.C\\'" . c++-mode))
   auto-mode-alist))
 
;; Copy list of all open buffers to clipboard: see http://stackoverflow.com/questions/10537265/emacs-save-current-buffer-list-to-a-text-file
(defun copy-open-files ()
  "Add paths to all open files to kill ring"
  (interactive)
  (kill-new (mapconcat 'identity
                       (delq nil (mapcar 'buffer-file-name (buffer-list)))
                       "\n"))
  (message "List of files copied to kill ring"))
 
;; save my desktop
(desktop-save-mode 1)
 
;; auto-reload modified files
(global-auto-revert-mode t)
 
;; put save files in back dir (see http://www.emacswiki.org/emacs/BackupDirectory)
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
 
;; move to window based on arrow keys
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
 
;; incremental completion
(require 'helm-config)
(helm-mode 1)
 
;; http://stackoverflow.com/questions/275842/is-there-a-repeat-last-command-in-emacs
(defun describe-last-function()
  (interactive)
  (describe-function last-command))
 
;; get path of present buffer, see http://stackoverflow.com/questions/3669511/the-function-to-show-current-files-full-path-in-mini-buffer
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
 
(global-set-key [C-f1] 'show-file-name) ; Or any other key you want
 
;; generate guids
(require 'guid)
 
;; Enable UTF-8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
 
;; show full path (see https://stackoverflow.com/questions/3669511/the-function-to-show-current-files-full-path-in-mini-buffer)
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name))
)
(global-set-key "\C-cz" 'show-file-name)
 
;; For a complete list of xah math symbols, call xah-math-input-list-math-symbols
;; http://ergoemacs.org/emacs/xmsi-math-symbols-input.html
;; To start it, call xah-math-input-mode, then, for example, type info and hit <Shift>-<Space>
(require 'xah-math-input)
(puthash "floral" "❦" xah-math-input-abrvs)
 
;; ;; See https://stackoverflow.com/questions/16270105/why-are-some-unicode-characters-invisible-in-emacs and https://github.com/rolandwalker/list-utils/issues/2
;; (require 'list-utils)
 
;; (list-utils-flatten '(1 2 (3 4 (5 6 7))))
;; ;; '(1 2 3 4 5 6 7)
 
;; (list-utils-depth '(1 2 (3 4 (5 6 7))))
;; ;; 3
 
;; (let ((cyclic-list '(1 2 3 4 5 6 7)))
;;   (nconc cyclic-list (cdr cyclic-list))
;;   (list-utils-make-linear-inplace cyclic-list))
;; ;; '(1 2 3 4 5 6 7)
 
;; (list-utils-cyclic-p '(1 2 3))
;; ;; nil
 
;; (list-utils-plist-del '(:one 1 :two 2 :three 3) :two)
;; ;; '(:one 1 :three 3)
 
;; ;;
 
;; (require 'ucs-utils)
 
;; (ucs-utils-char "Middle Dot"         ; character to return
;;                 ?.                   ; fallback if unavailable
;;                 'char-displayable-p) ; test for character to pass
 
;; (ucs-utils-first-existing-char '("White Bullet"
;;                                  "Bullet Operator"
;;                                  "Circled Bullet"
;;                                  "Middle Dot"
;;                                  ?.) 'cdp)
 
;; (ucs-utils-string "Horizontal Ellipsis" '[["..."]])
 
;; ;;
 
;; (require 'font-utils)
;; (font-utils-exists-p "Courier")
 
;; ;;
 
;; (require 'unicode-fonts)
;; (unicode-fonts-setup)
(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(comint-completion-addsuffix t)
'(comint-completion-autolist t)
'(comint-input-ignoredups t)
'(comint-move-point-for-output t)
'(comint-scroll-show-maximum-output t)
'(comint-scroll-to-bottom-on-input t)
'(package-selected-packages (quote (auctex magit)))
'(safe-local-variable-values
   (quote
    ((require-final-newline . t)
     (mangle-whitespace . t))))
'(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
)
 
;; Get TeX mode working with emacs (see http://piotrkazmierczak.com/2010/emacs-as-the-ultimate-latex-editor/)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
;(setq TeX-PDF-mode t) ;Enable this line if you want TeX mode enabled by default for all documents
;Do this for section preview: C-c C-p C-s;
;Do this for automatic formatting of a section: C-c C-q C-s;
 
;Check the syntax of TeX on the fly
(require 'flymake)
 
(defun flymake-get-tex-args (file-name)
(list "pdflatex"
(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))
 
(add-hook 'LaTeX-mode-hook 'flymake-mode)
 
;Folder sections of your document using C-c C-o C-l and use C-C C-o C-a to see the whole document again
(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))
 
(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else
 
;Use RefTex to manage references or to create a table of contents
(require 'tex-site)
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
 
(setq LaTeX-eqnarray-label "eq"
LaTeX-equation-label "eq"
LaTeX-figure-label "fig"
LaTeX-table-label "tab"
LaTeX-myChapter-label "chap"
TeX-auto-save t
TeX-newline-function 'reindent-then-newline-and-indent
TeX-parse-self t
TeX-style-path
'("style/" "auto/"
"~/site-lisp/auctex/style/"
"/var/lib/auctex/emacs21/"
"~/site-lisp/auctex/style/")
LaTeX-section-hook
'(LaTeX-section-heading
LaTeX-section-title
LaTeX-section-toc
LaTeX-section-section
LaTeX-section-label))
 
;; PHP: See http://sachachua.com/blog/2008/07/emacs-and-php-tutorial-php-mode/
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))
 
;; Octave/matlab
(setq auto-mode-alist
      (cons
       '("\\.m$" . octave-mode)
       auto-mode-alist))
 
;; See http://web-mode.org/
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))   
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp?\\'" . web-mode))
 
;; See https://bitbucket.org/mortiferus/latex-pretty-symbols.el
(require 'latex-pretty-symbols)
 
;; Statistics/R; type M-x ess-mode to put in R mode, or
;; Type M-x ess-r-set-evaluation-env to open command-line interpreter
;; Type M-x ess-tracebug to toggle debugging
;;(load "ess-site")
;;(require 'ess-site)       
 
;; Load all files in subdirs (see https://www.emacswiki.org/emacs/DotEmacsModular)
(defun recursive-subdirs (directory &optional withroot)
  "Return a unsorted list of names of directories in DIRECTORY recursively.
If WITHROOT is non-nil, also DIRECTORY will be include."
  (let (subdirs)
    (dolist (element (directory-files-and-attributes directory nil nil nil))
      (let* ((path (car element))
             (isdir (car (cdr element)))
             (ignore (or (string= path ".") (string= path ".."))))
        (if (and (eq isdir t) (not ignore))
            (let ((dir (concat directory "/" path)))
              (setq subdirs (append (cons dir subdirs)
                                    (recursive-subdirs dir)))))))
    (if (not (eq withroot nil))
        (add-to-list 'subdirs directory))
   subdirs))
 
;; Prevent garbage collection while loading files (let ...):   
;;let ((gc-cons-threshold most-positive-fixnum))
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.cs$" nil))
;;       (find-file file)))
 
  ;; (dolist (dir (recursive-subdirs "/home/rmoore/DevProjects/first-app/" t))
  ;;    (dolist (file (directory-files dir t "\.php$" nil))
  ;;      (find-file file)))

  ;; (dolist (dir (recursive-subdirs "/home/rmoore/DevProjects/first-app/" t))
  ;;    (dolist (file (directory-files dir t "\.json$" nil))
  ;;      (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.xaml$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.bat$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.csproj$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.sln$" nil))
;;       (find-file file)))   
  
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.resx$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.settings$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.config$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.tt$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.edmx$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.diagram$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/src/EAM/sam" t))
;;     (dolist (file (directory-files dir t "\.targets$" nil))
;;       (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.targets$" nil))
;;      (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;     (dolist (file (directory-files dir t "\.cs$" nil))
;;       (find-file file)))         
                 
 ;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.sql$" nil))
;;      (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.xaml$" nil))
;;      (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.bat$" nil))
;;      (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.csproj$" nil))
;;      (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.sln$" nil))
;;      (find-file file)))   
  
 ;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.resx$" nil))
;;      (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.settings$" nil))
;;      (find-file file)))
 
 ;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.config$" nil))
;;      (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.tt$" nil))
;;      (find-file file)))
 
 ;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.edmx$" nil))
;;      (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.diagram$" nil))
;;      (find-file file)))
 
;; (dolist (dir (recursive-subdirs "C:/src/EAM/branches/TAM_Roger" t))
;;    (dolist (file (directory-files dir t "\.targets$" nil))
;;      (find-file file)))          
                 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SD1/logs" t))
;;     (dolist (file (directory-files dir t "\.log$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SD1/logs" t))
;;     (dolist (file (directory-files dir t "\.txt$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SD1/EAM/moo0220" t))
;;     (dolist (file (directory-files dir t "\.xml$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SD2/logs" t))
;;     (dolist (file (directory-files dir t "\.log$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SD2/logs" t))
;;     (dolist (file (directory-files dir t "\.txt$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SD2/EAM/moo0220" t))
;;     (dolist (file (directory-files dir t "\.xml$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SQ1/logs" t))
;;     (dolist (file (directory-files dir t "\.log$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SQ1/logs" t))
;;     (dolist (file (directory-files dir t "\.txt$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SQ1/EAM/moo0220" t))
;;     (dolist (file (directory-files dir t "\.xml$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SQ2/logs" t))
;;     (dolist (file (directory-files dir t "\.log$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SQ2/logs" t))
;;     (dolist (file (directory-files dir t "\.txt$" nil))
;;       (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "//2YHRR32/c$/Users/moo0220/AppData/Roaming/StructuresInspection-SQ2/EAM/moo0220" t))
;;     (dolist (file (directory-files dir t "\.xml$" nil))
;;       (find-file file)))
 
  ;;(dolist (dir (recursive-subdirs "C:/Users/psalm/GDrive/Documents/QII/Notes" t))
  ;;  (dolist (file (directory-files dir t "\.txt$" nil))
  ;;    (find-file file)))
 
  ;; (dolist (dir (recursive-subdirs "C:/Workspace" t))
  ;;   (dolist (file (directory-files dir t "\.txt$" nil))
  ;;     (find-file file)))

;;    (dolist (file (directory-files dir t "\.java$" nil)) 
;;     (find-file file)))
 
;;  (dolist (dir (recursive-subdirs "C:/Workspace" t))
;;    (dolist (file (directory-files dir t "\.sql$" nil))
;;      (find-file file)))
 
;;)
 
;; Show the specific character difference in files (see https://emacs.stackexchange.com/questions/7362/how-to-show-a-diff-between-two-buffers-with-character-level-diffs)
(setq-default ediff-forward-word-function 'forward-char)
 
;; See https://stackoverflow.com/questions/7038146/how-can-i-compare-two-files-similar-to-vims-vimdiff/7038210   
(setq ediff-split-window-function 'split-window-horizontally)
   
;; See http://jblevins.org/projects/markdown-mode/       
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
 
(autoload 'gfm-mode "gfm-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
 
(autoload 'visual-basic-mode "visual-basic-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.vbs\\'" . visual-basic-mode))
 
;; See https://github.com/browse-kill-ring/browse-kill-ring
(require 'browse-kill-ring)
 
;; http://pragmaticemacs.com/emacs/automatically-copy-text-selected-with-the-mouse/
(setq mouse-drag-copy-region t)
 
;; see https://stackoverflow.com/questions/3417438/closing-all-other-buffers-in-emacs   
(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (remove-if-not 'buffer-file-name (buffer-list)))))
 
;; ====================
;; insert date and time (see https://stackoverflow.com/questions/251908/how-can-i-insert-current-date-and-time-into-a-file-using-emacs)
 
(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")
 
(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")
 
(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert "==========\n")
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
       (insert "\n")
       )
 
(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
       (insert "\n")
       )
 
(global-set-key "\C-c\C-d" 'insert-current-date-time)
(global-set-key "\C-c\C-t" 'insert-current-time)
 
;; Setup shells (see https://snarfed.org/why_i_dont_run_shells_inside_emacs)
 
 
; interpret and use ansi color codes in shell output windows
(ansi-color-for-comint-mode-on)
 
; make completion buffers disappear after 3 seconds.
(add-hook 'completion-setup-hook
  (lambda () (run-at-time 3 nil
    (lambda () (delete-windows-on "*Completions*")))))
 
;; run a few shells.
(shell "*shell5*")
(shell "*shell6*")
(shell "*shell7*")
(shell "*shell8*")
 
; C-5, 6, 7 to switch to shells
(global-set-key [(control \5)]
  (lambda () (interactive) (switch-to-buffer "*shell5*")))
(global-set-key [(control \6)]
  (lambda () (interactive) (switch-to-buffer "*shell6*")))
(global-set-key [(control \7)]
  (lambda () (interactive) (switch-to-buffer "*shell7*")))
(global-set-key [(control \8)]
  (lambda () (interactive) (switch-to-buffer "*shell8*")))
 
 
; https://emacswiki.org/emacs/Sunrise_Commander
(require 'sunrise-commander)
(require 'sunrise-x-tree)
(require 'sunrise-x-buttons)
(require 'sunrise-x-loop) ; Prefix with C-u to run on another thread, such as large file copy
(require 'sunrise-x-modeline)
 
; Pop-open eshell at current buffer: http://www.howardism.org/Technical/Emacs/eshell-fun.html
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))
 
    (insert (concat "ls"))
    (eshell-send-input)))
 
(global-set-key (kbd "C-!") 'eshell-here)
 
 
(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))
 
;; Move to recycle bin: see http://www.johndcook.com/blog/emacs_windows/
(setq delete-by-moving-to-trash t) 
 
;; Display column number by default: see http://www.johndcook.com/blog/emacs_windows/
(setq column-number-mode t)
 
;; Open git bash as shell if on Windows (see https://stackoverflow.com/questions/16676750/windows-emacs-git-bash-and-shell-command)
(if (equal system-type 'windows-nt)
    (progn (setq explicit-shell-file-name
                 "C:/Program Files/Git/bin/sh.exe")
           (setq shell-file-name "bash")
           (setq explicit-sh.exe-args '("--login" "-i"))
           (setenv "SHELL" shell-file-name)
           (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)))
 
;; See answer at https://emacs.stackexchange.com/questions/13214/automatically-formatting-sql-code
(eval-after-load "sql"
  '(load-library "sql-indent"))
 
(require 'browse-url)
;; (browse-url "http://google.com/")
;; For .org, press "C-c |"  (see https://stackoverflow.com/questions/1241581/emacs-import-a-csv-into-org-mode)
(find-file "~/site-lisp/ESS/etc/TODO.org")
(global-set-key (kbd "C-x r") 'browse-kill-ring) ; Ctrl+x r
 
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))
 
(add-hook 'text-mode-hook 'remove-dos-eol) 
 
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(global-set-key (kbd "C-x g") 'magit-status)
