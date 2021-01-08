;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

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





(setq user-full-name "John Doe"
      user-mail-address "john@doe.com"
      org-directory "~/.config/doom/org/")


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; some nice themes to consider:
;;   darker and higher contrast (neon blackboards):
;;     doom-gruvbox
;;     doom-tomorrow-night
;;   lighter and softer contrast (chalkboards):
;;     doom-opera
;;     doom-spacegray
;;   eyebleach:
;;     doom-nova
;;   favourites:
;;     doom-gruvbox
;;     doom-spacegray
;; A E S T H E T I C S
(setq doom-theme 'doom-spacegrey
      doom-font (font-spec :family "Hack" :size 13 :weight 'normal)
      doom-big-font (font-spec :family "Hack" :size 16 :weight 'semi-bold))


;; EDITOR
(setq display-line-numbers-type 'relative)
(setq-default
 indent-tabs-mode nil
 tab-width 2)


;; PLUGS
(after! company
  (setq company-idle-delay 0))
