(package! ob-julia :recipe (:host github :repo "nico202/ob-julia"))

(package! org-present)

(unpin! org-roam)
(package! org-roam-ui)
(package! websocket :pin "fda4455333309545c0787a79d73c19ddbeb57980") ; dependency of `org-roam-ui'

(package! jest-test-mode)

(package! vue-mode)

(package! svelte-mode)

(package! poetry)

(package! blamer)

(package! doom-themes)

(package! grayscale-theme)

(package! lambda-themes :recipe (:host github :repo "lambda-emacs/lambda-themes"))

(package! tao-theme)

(package! lambda-line :recipe (:host github :repo "lambda-emacs/lambda-line"))

(package! pretty-hydra)

(package! which-key-posframe)

(package! all-the-icons-ivy-rich)

;; (package! treemacs-all-the-icons)

(package! exwm)

(package! dap-mode)

;; Orgmode

;; Tables
(package! org-pretty-table
  :recipe (:host github :repo "Fuco1/org-pretty-table") :pin
  "87772a9469d91770f87bfa788580fca69b9e697a")

;; Only show emphasis markers when editing them
(package! org-appear :recipe (:host github :repo "awth13/org-appear")
  :pin "148aa124901ae598f69320e3dcada6325cdc2cf0")

;; Remove heading starts
(package! org-starless :recipe (:host github :repo "TonCherAmi/org-starless"))

;; Padding for org mode
(package! org-padding :recipe (:host github :repo "TonCherAmi/org-padding"))

;; View and manage heading structure
(package! org-ol-tree :recipe (:host github :repo "Townk/org-ol-tree")
  :pin "207c748aa5fea8626be619e8c55bdb1c16118c25")

;; Citations
(package! org-ref :pin "3ca9beb744621f007d932deb8a4197467012c23a")

;; HTTP requests via babel
(package! ob-http :pin "b1428ea2a63bcb510e7382a1bf5fe82b19c104a7")

;; graph view
(package! org-graph-view :recipe (:host github :repo "alphapapa/org-graph-view")
  :pin "13314338d70d2c19511efccc491bed3ca0758170")

;; Import non-org via pandoc
(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))

;; OrgRoam visualization / webapp

;; automatic latex rendering
(package! org-fragtog :pin "479e0a1c3610dfe918d89a5f5a92c8aec37f131d")

;; Match emacs theme for Latex document
(package! ox-chameleon :recipe (:host github :repo "tecosaur/ox-chameleon"))

;; export github markdown
(package! ox-gfm :pin "99f93011b069e02b37c9660b8fcb45dab086a07f")

;; Google Calendar integration
(package! org-gcal :recipe (:host github :repo "kidd/org-gcal.el"))

;; Google Tasks integration
(package! org-gtasks :recipe (:host github :repo "JulienMasson/org-gtasks"))

;; K8s
(package! k8s-mode)

;; Copilot
(package! jsonrpc)
(package! copilot
  :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))

;; Multiple major modes in one buffer
(package! polymode)
(package! poly-markdown)
