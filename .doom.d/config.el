;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;
;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.doom.d/lisp/")
(add-to-list 'load-path "~/.doom.d/lisp/apt-mode")

(load "narrow-indirect")
(load "apt-mode")(require 'url)

(defun download-file (&optional url download-dir download-name)
  (interactive)
  (let ((url (or url
                 (read-string "Enter download URL: "))))
    (let ((download-buffer (url-retrieve-synchronously url)))
      (save-excursion
        (set-buffer download-buffer)
        ;; we may have to trim the http response
        (goto-char (point-min))
        (re-search-forward "^$" nil 'move)
        (forward-char)
        (delete-region (point-min) (point))
        (write-file (concat (or download-dir
                                "~/Downloads/")
                            (or download-name
                                (car (last (split-string url "/" t))))))))))


(map! :leader :mode with-editor-mode
      :desc "finish editing" "cf" 'with-editor-finish)

(map! :leader
      :desc "Download a file" "d" 'download-file
      :desc "Open Eshell" "oe" 'eshell
      :desc "narrow to defun indirectly" "nd" 'ni-narrow-to-defun-indirect-other-window
      :desc "narrow to region indirectly" "nn" 'ni-narrow-to-region-indirect-other-window
      :desc "narrow to page indirectly" "np" 'ni-narrow-to-page-indirect-other-window
      :desc "apt update" "au" 'apt-update
      :desc "apt upgrade" "aU" 'apt-upgrade
      :desc "apt install" "ai" 'apt-install
      :desc "apt remove" "ar" 'apt-remove
      :desc "apt autoremove" "aa" 'apt-autoremove
      :desc "apt search" "as" 'apt-search
      :desc "eval last sexp" "el" 'eval-last-sexp
      :desc "eval and print last sexp" "ep" 'eval-print-last-sexp)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Hasklig" :size 24))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-solarized-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; unfucking ghci
(setenv "PATH" (concat (getenv "PATH") ":/usr/bin/ghci"))
(setq exec-path (append exec-path '("/usr/bin/ghci")))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
