(setq user-full-name "Tibor Pilz"
      user-mail-address "tibor@pilz.berlin")

(defun is-mac ()
  (string-equal system-type "darwin"))

(defun is-linux ()
  (string-equal system-type "gnu/linux"))

(defun is-workstation ()
  (string-equal (system-name) "archyMcArchstation"))

(setq font-scale-factor (if (is-workstation) 1.1 1.0))

(defun scale-font (size)
  (round (* size font-scale-factor)))

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size (scale-font 16) :weight 'light)
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size (scale-font 24))
      doom-variable-pitch-font (font-spec :family "Open Sans" :size (scale-font 16))
      doom-serif-font (font-spec :family "FreeSerif" :weight 'light))

(setq org-directory "~/org/")
(setq org-agenda-files (list org-directory))

(setq org-use-property-inheritance t)
(setq org-log-done 'time) ; Log time when task completes
(setq org-list-allow-alphabetical t)       ; a, A, a) A) list bullets)
(setq org-catch-invisible-edits 'smart) ; don't treat lone _ / ^ as sub/superscripts, require _{} / ^{})


(setq org-return-follows-link 1)
(setq calendar-week-start-day 1) ;; start on monday
(setq org-agenda-include-diary t)

(use-package! org-pretty-table
  :commands (org-pretty-table-mode global-org-pretty-table-mode))

(add-hook 'org-mode-hook #'+org-pretty-mode)

(setq org-agenda-deadline-faces
      '((1.001 . error)
        (1.0 . org-warning)
        (0.5 . org-upcoming-deadline)
        (0.0 . org-upcoming-distant-deadline)))

(setq org-fontify-quote-and-verse-blocks t)

(defun locally-defer-font-lock ()
  "Set jit-lock defer and stealth, when buffer is over a certain size."
  (when (> (buffer-size) 50000)
    (setq-local jit-lock-defer-time 0.05
                jit-lock-stealth-time 1)))

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

(use-package! ob-http
  :commands org-babel-execute:http)

(setq org-babel-default-header-args
      '((:session . "none")
        (:results . "replace")
        (:exports . "code")
        (:cache . "no")
        (:noeweb . "no")
        (:hlines . "no")
        (:tangle . "no")
        (:comments . "link")))

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
           (setq buffer-file-name fie)
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
  '("go" "python" "ipython" "bash" "sh" "ditaa"))
(dolist (lang org-babel-lang-list)
  (eval `(lsp-org-babel-enable ,lang)))

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

(use-package! ox-gfm :after ox)

(setq org-export-headline-levels 5)

;(require 'ox-extra)
;(ox-extras-activate '(ignore-headlines))

(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))

(setq org-highlight-latex-and-related '(native script entities))

;(use-package! org-re-reveal)

(setq org-roam-directory "~/org")

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
    (interactive    )
    (unless org-roam-ui-mode (org-roam-ui-mode 1))
    (browse-url-xdg-open (format "http://localhost:%d" org-roam-ui-port))))

(use-package! delve
  :after org-roam
  :bind
  (("<f12>" . delve))
  :config
  (setq delve-dashboard-tags '("Inbox" "Waiting" "Someday" "Reference" "Note" "Journal" "Event" "Task" "Text" "Code"))
  (add-hook #'delve-mode-hook #'delve-compact-view-mode)
  (delve-global-minor-mode))

(use-package! org-gcal
  :config
  (setq org-gcal-client-id "CLIENT_ID"
        org-gcal-client-secret "CLIENT_SECRET"
        org-gcal-fetch-file-alit '(("tbrpilz@googlemail.com" . "~/org/schedule.org"))))

(use-package! org-gtasks)
(org-gtasks-register-account :name "Personal"
                             :directory "~/org"
                             :client-id "CLIENT_ID"
                             :client-secret "CLIENT_SECRET")

(remove-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'text-mode-hook #'auto-fill-mode)

(require 'org-src)
(add-to-list 'org-src-block-faces '("latex" (:inherit default :extend t)))

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

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(defadvice! org-edit-latex-env-after-insert ()
  :after #'org-cdlatex-environment-indent
  (org-edit-latex-environment))

(add-hook! markdown-mode (auto-fill-mode -1))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil)
  ;; for proper first-time setup, `org-appear--set-elements'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-elements))

(use-package! jest-test-mode
  :commands jest-test-mode
  :hook (typescript-mode js-mode typescript-tsx-mode))

(use-package! vue-mode)

(use-package! svelte-mode
    :mode "\\.svelte\\'")

(use-package! nix-mode
  :mode "\\.nix\\'")

(add-hook! python-mode
  (advice-add 'python-pytest-file :before
              (lambda (&rest args)
                (setq-local python-pytest-executable
                            (executable-find "pytest")))))

(use-package! polymode)
(use-package! poly-markdown)

(setq copilot-node-executable
      (replace-regexp-in-string "\n" "" (shell-command-to-string ". $HOME/.zshrc; nvm which 16")))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("TAB" . 'copilot-accept-completion-by-word)
         :map company-active-map
         ("<backtab>" . 'copilot-accept-completion)
         :map company-mode-map
         ("<backtab>" . 'copilot-accept-completion)))

(setq dap-python-debugger 'debugpy)

;;;###autoload
(defun +debugger/clear ()
  "Clear the debugger configuration from the doom-store."
  (interactive)
  (doom-store-rem (doom-project-root) "+debugger"))

(setq debugger-start-copy (symbol-function '+debugger/start))

;;;###autoload
(defun +debugger/repeat (arg)
  "Start the debugger."
  (interactive)
  (funcall debugger-start-copy arg))

;;;###autoload
(defun +debugger/start (arg)
  "Launch a debugger session.
Launches the last used debugger, if one exists. Otherwise, you will be prompted
for what debugger to use. If the prefix ARG is set, prompt anyway."
  (interactive "P")
  (message arg)
  (+debugger--set-config (+debugger-completing-read))
  (+debugger/start-last))

(defun get-window-with-file-buffer ()
  "Get the window with a file buffer."
  (seq-find (lambda (window)
              (buffer-file-name (window-buffer window)))
            (window-list)))

(defun reset-file-window-buffer ()
  "Reset the file window's buffer."
  (let ((window (get-window-with-file-buffer)))
    (when window
      (set-window-buffer window (window-buffer window)))))

(defun add-reset-file-window-buffer-hook (&rest args)
  "Add the reset-file-window-buffer function to the window-configuration-change-hook."
  (add-hook 'window-configuration-change-hook 'reset-file-window-buffer))

(defun remove-reset-file-window-buffer-hook (&rest args)
    "Remove the reset-file-window-buffer function from the window-configuration-change-hook."
    (remove-hook 'window-configuration-change-hook 'reset-file-window-buffer))

(add-hook 'dap-mode-hook 'add-reset-file-window-buffer-hook)

(map! :leader
      (:prefix-map ("d" . "debugger")
       :desc "Debug" "d" #'dap-debug
       :desc "Next" "n" #'dap-next
       :desc "Step in" "i" #'dap-step-in
       :desc "Step out" "o" #'dap-step-out
       :desc "Continue" "c" #'dap-continue
       :desc "Restart" "r" #'dap-restart-frame
       :desc "Disconnect" "D" #'dap-disconnect
       :desc "Evaluate" "e" #'dap-eval
       :desc "Add Expression" "a" #'dap-ui-expressions-add
       (:prefix ("b" . "breakpoints")
        :desc "Toggle" "t" #'dap-breakpoint-toggle
        :desc "Add" "a" #'dap-breakpoint-add
        :desc "Delete" "d" #'dap-breakpoint-delete
        :desc "Set condition" "c" #'dap-breakpoint-condition
        :desc "Set log message" "m" #'dap-breakpoint-log-message
        :desc "Set hit condition" "h" #'dap-breakpoint-hit-condition)))

(use-package corfu
  :config
  (defun ++corfu-quit ()
    (interactive)
    (call-interactively 'corfu-quit)
    (evil-normal-state +1))
  (setq corfu-cycle t
        corfu-auto nil
        corfu-auto-prefix 1
        corfu-auto-delay 0.5
        corfu-seperator ?\s
        corfu-quit-at-boundary 'seperator
        corfu-quit-no-match t
        corfu-preview-current t
        corfu-echo-documentation nil
        corfu-scroll-margin nil)
  (map! :map global-map
        :nvi "C-SPC" #'completion-at-point)
  (map! :map corfu-map
        "C-j" #'corfu-next
        "C-k" #'corfu-previous
        "C-n" #'corfu-next
        "C-p" #'corfu-previous
        "enter" #'corfu-insert
        :nvi "<escape>" #'++corfu-quit
        :nvi "ESC" #'++corfu-quit)
  (global-corfu-mode +1)
  (global-company-mode -1)

  (add-hook! '(prog-mode-hook
               text-mode-hook)
    (corfu-doc-mode +1)
    (unless (display-graphic-p)
      (corfu-terminal-mode +1)
      (corfu-doc-termnal-mode +1))))

(use-package corfu-doc
  :after corfu
  :hook (corfu-mode . corfu-doc-mode)
  :general (:keymaps 'corfu-map
            ;; This is a manual toggle for the documentation popup.
            [remap corfu-show-documentation] #'corfu-doc-toggle ; Remap the default doc command
            ;; Scroll in the documentation window
            "M-n" #'corfu-doc-scroll-up
            "M-p" #'corfu-doc-scroll-down)
  :custom
  (corfu-doc-delay 0.5)
  (corfu-doc-max-width 80)
  (corfu-doc-max-height 40))

(use-package kind-icon
  :ensure t
  :after corfU
  :custom
  (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package! orderless
  :init
  (setq completion-styles '(orderless partial-completion basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package! lsp-mode
  :custom
  (lsp-completion-provider :none) ;; we use Corfu!
  :init
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))) ;; Configure orderless
  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion))

(use-package! cape
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-file)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  :config
  (setq cape-dabbrev-min-length 2
        cape-dabbrev-check-other-buffers 'some))

;; (advice-add #'corfu--make-frame :around
;;             (defun +corfu--make-frame-a (oldfun &rest args)
;;               (cl-letf (((symbol-function #'frame-parent)
;;                          (lambda (frame)
;;                            (or (frame-parameter frame 'parent-frame)
;;                                exwm-workspace--current))))
;;                 (apply oldfun args))
;;               (when exwm--connection
;;                 (set-frame-parameter corfu--frame 'parent-frame nil))))

;; (advice-add #'corfu--popup-redirect-focus :override
;;             (defun +corfu--popup-redirect-focus-a ()
;;               (redirect-frame-focus corfu--frame
;;                                     (or (frame-parent corfu--frame)
;;                                         exwm-workspace--current))))

;; (advice-add #'corfu-doc--make-frame :around
;;             (defun +corfu-doc--make-frame-a (oldfun &rest args)
;;               (cl-letf (((symbol-function #'frame-parent)
;;                          (lambda (frame)
;;                            (or (frame-parameter frame 'parent-frame)
;;                                exwm-workspace--current))))
;;                 (apply oldfun args))
;;               (when exwm--connection
;;                 (set-frame-parameter corfu-doc--frame 'parent-frame nil))))

;; (advice-add #'corfu-doc--redirect-focus :override
;;             (defun +corfu-doc--redirect-focus ()
;;               (redirect-frame-focus corfu-doc--frame
;;                                     (or (frame-parent corfu-doc--frame)
;;                                         exwm-workspace--current))))

;; (use-package vertico
;;   :straight (:files (:defaults "extensions/*"))
;;   :init
;;   (vertico-mode)

;; (use-package vertico-directory
;;   :after vertico
;;   :ensure nil
;;   :bind (:map vertico-map
;;               ("RET" . vertico-directory-enter)
;;               ("DEL" . vertico-directory-delete-char)
;;               ("M-dEL"' vertico-directory-delete-word))
;;   :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(setq doom-theme 'doom-opera)

;; (add-to-list 'load-path "~/Code/doom-nano-testing")
;; (require 'load-nano)
;; (setq doom-themes-treemacs-theme "doom-atom")

;; (use-package! nano-modeline
;;   :config
;;   (nano-modeline-mode 1))

(require 'all-the-icons)

(defvar func-suffixes '("faicon" "fileicon" "octicon" "material"))

;; loop over func-suffixes and generate all-the-icons-functions
(dolist (suffix func-suffixes)
  (let ((func-name (intern (concat "with-" suffix)))
        (call-name (intern (concat "all-the-icons-" suffix))))
    (eval `(defun ,func-name (icon str &optional height v-adjust)
      (s-concat (,call-name icon :v-adjust (or v-adjust 0) :height (or height 0)) " " str)))))

(defun with-mode-icon (mode str &optional height nospace face)
  (let* ((v-adjust (if (eq major-mode 'emacs-lisp-mode) 0.0 0.05))
         (args     `(:height ,(or height 1) :v-adjust ,v-adjust))
         (_         (when face
                      (lax-plist-put args :face face)))
         (icon     (apply #'all-the-icons-icon-for-mode mode args))
         (icon     (if (symbolp icon)
                       (apply #'all-the-icons-octicon "file-text" args)
                     icon)))
    (s-concat icon (if nospace "" " ") str)))

(defun get-key-description (key docstring)
  "Get the description for a key from the docstring."
  (when (string-match (format "\\(_%s_\\):[[:space:]]\\(\\(\\w+\\)\\([[:space:]]\\w+\\)*\\)" key) docstring)
    (match-string 2 docstring)))

(defun get-categories (docstring)
    "Get the categories from the docstring."
    (let ((lines (split-string docstring "\n")))
        (seq-filter (lambda (x) (not (string-blank-p x)))
                    (split-string (nth 1 lines) "\\^"))))

(defun split-row (row)
  "Split a row into a list of keys."
  (-slice (split-string (replace-regexp-in-string ":[^_]*\\(_\\|$\\)" "" row) "_") 1 -1))

(defun get-all-keys (docstring)
  "Get all keys from the docstring."
  (let ((lines (-slice (split-string docstring "\n") 3 -3)))
    (mapcan #'split-row lines)))

(defun get-category-offsets (categories docstring)
  "Get the category titles' offsets in the docstring."
  (let ((title-row (nth 1 (split-string docstring "\n"))))
    (mapcar (lambda (x) `(,x . ,(string-match x title-row))) categories)))

(defun get-comparer (offset)
  "Get a comparer function for a given number of blank characters."
  `(lambda (x y)
    (let ((x-diff (abs (- (cdr x) ,offset)))
          (y-diff (abs (- (cdr y) ,offset))))
      (< x-diff y-diff))))

(defun get-row-for-key (key docstring)
  "Get the row for a given key from the docstring."
  (let ((rows (split-string docstring "\n")))
    (seq-find (lambda (x) (member key (split-row x))) rows)))

(defun get-categories-for-key (key docstring)
  "Get the category for a key."
  (let* ((row (get-row-for-key key docstring))
         (categories (get-categories docstring))
         (category-offsets (get-category-offsets categories docstring))
         (key-offset (string-match (format "_%s_:" key) row))
         (comparer (get-comparer key-offset))
         (index (-elem-index (car (car (sort category-offsets comparer))) categories)))
    (nth index categories)))

(defun add-description (entry docstring)
  "Add the description to a single entry."
  (let* ((key (car entry))
         (func (nth 1 entry))
         (desc (get-key-description key docstring))
         (rest (-slice entry 2)))
    `(,key ,func ,desc)))

(defun preprocess-heads (heads docstring)
  "Preprocess the heads by checking whether their key is in the docstring and by adding the description."
  (let ((filtered-heads (seq-filter (lambda (x) (member (car x) (get-all-keys docstring))) heads)))
    (mapcar (lambda (x) (add-description x docstring)) filtered-heads)))

(defun associate-categories-with-heads (heads docstring)
  "Associate categories with heads."
  (mapcar (lambda (x) `(,x . ,(get-categories-for-key (car x) docstring))) heads))

(defun group-heads (category head-category-alist)
  "Group heads into a category."
  (let ((category-heads (mapcar #'car (seq-filter (lambda (x) (string= (cdr x) category)) head-category-alist))))
    `(,category ,category-heads)))

(defun get-category-header-alist (heads docstring)
  "Get an alist of categories and their head entries."
  (let* ((keys (get-all-keys docstring))
         (processed-heads (preprocess-heads heads docstring))
         (categories (get-categories docstring))
         (head-category-alist (associate-categories-with-heads processed-heads docstring))
         (grouped-heads (mapcan (lambda (x) (group-heads x head-category-alist)) categories)))
    grouped-heads))

(dap-hydra)
(hydra-keyboard-quit)

(eval `(pretty-hydra-define dap-hydra-pretty
         (:color amaranth :quit-key "q" :title (with-faicon "windows" "Dap" 1 -0.05))
         ,(get-category-header-alist dap-hydra/heads dap-hydra/docstring)))

(defun wjb/posframe-arghandler (buffer-or-name arg-name value)
  (let ((info '(:internal-border-width 2 :width 500 :height 48)))
    (or (plist-get info arg-name) value)))
(setq posframe-arghandler #'wjb/posframe-arghandler)

;; (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial)
;; (define-key ivy-minibuffer-map (kbd "<return>") 'ivy-alt-done)

(use-package! all-the-icons-ivy-rich
  :after counsel-projectile
  :init (all-the-icons-ivy-rich-mode +1)
  :config
  (setq all-the-icons-ivy-rich-icon-size 0.8))

(setq ivy-posframe-width 80)

(setq default-frame-alist
      (append (list
               '(vertical-scroll-bars . nil)
               '(internal-border-width . 24))))

(require 'exwm-config)
