;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

;; For easier python handling
(package! poetry)

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

;; Julia babel language improvements
(package! ob-julia :recipe (:host github :repo "nico202/ob-julia"))

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
(unpin! org-roam)
(package! org-roam-ui)

(package! websocket :pin "fda4455333309545c0787a79d73c19ddbeb57980") ; dependency of `org-roam-ui'

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

;; Jest-Test-Mode
(package! jest-test-mode)

;; Vue-Mode
(package! vue-mode)
