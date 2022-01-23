;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Tibor Pilz"
      user-mail-address "tibor@pilz.berlin")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   Presentations streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 22)
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 32)
      doom-variable-pitch-font (font-spec :family "Open Sans" :size 22)
      doom-serif-font (font-spec :family "ETbb" :weight 'light))

(setq display-line-numbers-type 'relative)


(setq doom-theme 'doom-one)

;; Org-Mode
;; settings
(setq org-directory "~/org/"
  org-use-property-inheritance t
  org-log-done 'time
  org-list-allow-alphabetical t       ; a, A, a) A) list bullets
  org-catch-invisible-edits 'smart) ; don't treat lone _ / ^ as sub/superscripts, require _{} / ^{}


;; Roam setup
(setq org-roam-directory "~/Roam")
;; Packege configs

;; Prettier tables
(use-package! org-pretty-table
  :commands (org-pretty-table-mode global-org-pretty-table-mode))

;; Only show emphasis markers when editing
(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))




;; Remove indentation and headline stars
(after! org
  (setq org-startup-indented nil))

(use-package! org-starless)
(add-hook 'org-mode-hook 'org-starless-mode)

;; Julia babel language improvements
(use-package! ob-julia
  :commands org-babel-execute:julia
  :config
  (setq org-babel-julia-command-arguments
        `("--sysimage"
          ,(when-let ((img "~/.local/lib/julia.so")
                      (exists? (file-exists-p img)))
             (expand-file-name img))
          "--threads"
          ,(number-to-string (- (doom-system-cpus) 2))
          "--banner=no")))

;; HTTP requests via babel
(use-package! ob-http
  :commands org-babel-execute:http)

;; Non-Org import
(use-package! org-pandoc-import
  :after org)

;; OrgRoam visualization / webapp
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :commands org-roam-ui-open
  :hook (org-roam . org-roam-ui-mode)
  :config
  (require 'org-roam) ; in case autoloaded
  (defun org-roam-ui-open ()
    "Ensure the server is active, then open the roam graph."
    (interactive)
    (unless org-roam-ui-mode (org-roam-ui-mode 1))
    (browse-url-xdg-open (format "http://localhost:%d" org-roam-ui-port))))

;; Babel header args, see https://org-babel.readthedocs.io/en/latest/header-args/
(setq org-babel-default-header-args
  '((:session . "none")
     (:results . "replace")
     (:exports . "code")
     (:cache . "no")
     (:noeweb . "no")
     (:hlines . "no")
     (:tanble . "no")
     (:comments . "link")))

;; visual-line-mode messes with with plaintext (markdow, latex)
(remove-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'text-mode-hook #'auto-fill-mode)

;; Create an org buffer
(evil-define-command evil-buffer-org-new (count file)
  "creates a new ORG buffer replacing the current window, optionally
   editing a certain FILE"
  :repeat nil
  (interactive "P<f>")
  (if file
    (evil-edit file)
    (let ((buffer (generate-new-buffer "*new org*")))
      (set-window-buffer nil buffer)
      (with-current-buffer buffer
        (org-mode)))))

(map! :leader
  (:prefix "b"
    :desc "new empty ORG buffer" "o" #'evil-buffer-org-new))

;; Insert cdlatex enviornments and edit immediately
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(defadvice! org-edit-latex-env-after-insert ()
  :after #'org-cdlatex-environment-indent
  (org-edit-latex-environment))


;; LSP in org-babel src blocks
(cl-defmacro lsp-org-babel-enable (lang)
  "Support LANG in org source code block."
  (setq centaur-lsp 'lsp-mode)
  (cl-check-type lang stringp)
  (let* ((edit-pre (intern (format "org-babel-edit-prep:%s" lang)))
         (intern-pre (intern (format "lsp--%s" (symbol-name edit-pre)))))
    `(progn
       (defun ,intern-pre (info)
         (let ((file-name (->> info caddr (alist-get :file))))
           (unless file-name
             (setq file-name (make-temp-file "babel-lsp-")))
           (setq buffer-file-name file-name)
           (lsp-deferred)))
       (put ',intern-pre 'function-documentation
            (format "Enable lsp-mode in the buffer of org source block (%s)."
                    (upcase ,lang)))
       (if (fboundp ',edit-pre)
           (advice-add ',edit-pre :after ',intern-pre)
         (progn
           (defun ,edit-pre (info)
             (,intern-pre info))
           (put ',edit-pre 'function-documentation
                (format "Prepare local buffer environment for org source block (%s)."
                        (upcase ,lang))))))))
(defvar org-babel-lang-list
  '("go" "python" "ipython" "bash" "sh"))
(dolist (lang org-babel-lang-list)
  (eval `(lsp-org-babel-enable ,lang)))

;; View exported file
(map! :map org-mode-map
  :localleader
  :desc "View exported file" "v" #'org-view-output-file)

(defun org-view-output-file (&optional org-file-path)
  "Visit buffer open on the first output file (if any) found, using `org-view-output-file-extensions'"
  (interactive)
  (let* ((org-file-path (or org-file-path (buffer-file-name) ""))
         (dir (file-name-directory org-file-path))
         (basename (file-name-base org-file-path))
         (output-file nil))
    (dolist (ext org-view-output-file-extensions)
      (unless output-file
        (when (file-exists-p
               (concat dir basename "." ext))
          (setq output-file (concat dir basename "." ext)))))
    (if output-file
        (if (member (file-name-extension output-file) org-view-external-file-extensions)
            (browse-url-xdg-open output-file)
          (pop-to-buffer (or (find-buffer-visiting output-file)
                             (find-file-noselect output-file))))
      (message "No exported file found"))))

(defvar org-view-output-file-extensions '("pdf" "md" "rst" "txt" "tex" "html")
  "Search for output files with these extensions, in order, viewing the first that matches")
(defvar org-view-external-file-extensions '("html")
  "File formats that should be opened externally.")


;; Org-Mode visual improvements

;; mixed pitch & org-pretty-mode
(add-hook 'org-mode-hook #'+org-pretty-mode)

;; Font and size of Orgmode Headlines
;; Set font for Org headlines. Try different fonts, and use a sans serif family if all else fails
;; (custom-set-faces !
;;   '(outline-1 :font "ETbb" :weight extra-bold)
;;   '(outline-2 :font "ETbb" :weight bold)
;;   '(outline-3 :font "ETbb" :weight bold)
;;   '(outline-4 :font "ETbb" :weight semi-bold)
;;   '(outline-5 :weight semi-bold)
;;   '(outline-6 :weight semi-bold)
;;   '(outline-8 :weight semi-bold)
;;   '(outline-9 :weight semi-bold))

;; Show passed deadlines as error
(setq org-agenda-deadline-faces
      '((1.001 . error)
        (1.0 . org-warning)
        (0.5 . org-upcoming-deadline)
         (0.0 . org-upcoming-distant-deadline)))

;; Show quote blocks in italic
(setq org-fontify-quote-and-verse-blocks t)

;; defer font-lock for a more responsive editing experience TODO: Keep an eye out
(defun locally-defer-font-lock ()
  "Set jit-lock defer and stealth, when buffer is over a certain size."
  (when (> (buffer-size) 50000)
    (setq-local jit-lock-defer-time 0.05
                jit-lock-stealth-time 1)))

;; Symbols
(after! org-superstar
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "✤" "✜" "◆" "▶")
        org-superstar-prettify-item-bullets t ))

(setq org-ellipsis " ▾ "
      org-hide-leading-stars t
      org-priority-highest ?A
      org-priority-lowest ?E
      org-priority-faces
      '((?A . 'all-the-icons-red)
        (?B . 'all-the-icons-orange)
        (?C . 'all-the-icons-yellow)
        (?D . 'all-the-icons-green)
         (?E . 'all-the-icons-blue)))

;; Latex fragments
(setq org-highlight-latex-and-related '(native script entities))

;; Prevent org-block face for latex fragments, since they look weird
(require 'org-src)
(add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t)))

;; automatic latex rendering
(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))

;; Export headings up to five levels deep
(setq org-export-headline-levels 5)

;; possibility to add `:ignore:` tag to headings, so only the headings will be ignored for an export
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

;; use github markdown
(use-package! ox-gfm :after ox)

;; ;; Set heights for headlines
;;   (custom-theme-set-faces
;;     'user
;;     `(org-level-8        ((t (,@headline ,@variable-tuple))))
;;     `(org-level-7        ((t (,@headline ,@variable-tuple))))
;;     `(org-level-6        ((t (,@headline ,@variable-tuple))))
;;     `(org-level-5        ((t (,@headline ,@variable-tuple))))
;;     `(org-level-4        ((t (,@headline ,@variable-tuple :height 1.1))))
;;     `(org-level-3        ((t (,@headline ,@variable-tuple :height 1.25))))
;;     `(org-level-2        ((t (,@headline ,@variable-tuple :height 1.5))))
;;     `(org-level-1        ((t (,@headline ,@variable-tuple :height 1.75))))
;;     `(org-headline-done  ((t (,@headline ,@variable-tuple :strike-through t))))
;;     `(org-document-title ((t (,@headline ,@variable-tuple
;;                                :height 2.0 :underline nil))))))

;; Set different fonts for freeform text and codeblocks
;; (variable-pitch ((t (:family "ETbb" :height 180 :weight thin))))
;; (fixed-pitch ((t (:family "FiraCode Nerd Font" :height 160))))
;; fix vertical spacing in code blocks
;(org-indent ((t (:inherit (org-hide fixed-pitch)))))
;(org-indent ((t (:inherit (org-hide fixed-pitch)))))

;; Style DONE items
;; (org-fontify-done-headline t)
;; (org-done ((t (:foreground "PaleGreen"
;;               :strike-through t))))

;; (org-tags-column 0)

;; Set visual-line-mode so paraphraphs wrap nicely
;; (org-mode . visual-line-mode)
;; (org-mode . variable-pitch-mode)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
