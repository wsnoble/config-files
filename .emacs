; Deal with making backspace (^H) delete backwards and M-? be help
;(define-key global-map "\e?" 'help-for-help)
;(define-key help-map   "\e?" 'help-for-help)
;(define-key global-map "\^H" 'delete-backward-char)
;(define-key esc-map    "\^H" 'delete-backward-word)
;(normal-erase-is-backspace-mode 1)
(global-set-key "\C-h"  'backward-delete-char-untabify) 

;;; Get rid of the splash screen at startup.
(setq inhibit-splash-screen 1)

;; Above doesn't seem to work.  Try this Python hook from
;; http://stackoverflow.com/questions/4251159/set-python-indent-to-2-spaces-in-emacs-23
;; (add-hook 'python-mode-hook
;;           (function (lambda ()
;;                       (setq indent-tabs-mode nil
;;                             tab-width 2
;;                             python-indent 2))))

;;; Put a line number in the status line.
(setq line-number-mode 1)

(setq indent-tabs-mode nil)

;;; Set the text mode to auto-fill.
(defun foo () (auto-fill-mode 1))
(setq text-mode-hook 'foo)
(setq bibtex-mode-hook 'foo)

;;; Make .txt files go to text mode.
(or (assoc "\\.txt$" auto-mode-alist)
        (setq auto-mode-alist (cons '("\\.txt$" . text-mode) auto-mode-alist)))

;;; Make .tex files go to tex mode.
(or (assoc "\\.tex$" auto-mode-alist)
        (setq auto-mode-alist (cons '("\\.tex$" . latex-mode) auto-mode-alist)))

;;; Make a list of tags tables.
(setq tags-table-list
      '("~/proj/crux/trunk/src/TAGS"))

;;; Enable some useful commands.
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'eval-expression 'disabled nil)

;;; Prevent extraneous tabs.
(setq-default indent-tabs-mode nil)

;;; Set up a key to split vertically
(global-set-key "5" 'split-window-horizontally)

;;; Set up a key to truncate lines.
(global-set-key "6" 'toggle-truncate-lines)

;;; Set up a debugger key.
(global-set-key "7" 'gdb)

;;; Set up a repeat key.
(global-set-key "8" 'repeat-complex-command)

;;; Set up a compilation key.
(global-set-key "9" 'compile)

;;; Scroll one line at a time.
(setq scroll-step 1)
 
(require 'font-lock)
(add-hook 'find-file-hooks 'turn-on-font-lock)

;; fontification font-lock.el
(cond ((fboundp 'global-font-lock-mode)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ))

;;; Allow HTML mode.
(load-library "sgml-mode")

;; auto-add coloration to modes that support it
(require 'font-lock)
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode t))
(setq font-lock-make-faces t)
(setq font-lock-maximum-decoration t)

;; you can set the X11 frame title to be different, e.g. to show the
;; full path of the file you're working on, which is nice; others may
;; like the hostname in the title bar...
(setq frame-title-format "Emacs: %b %+%+ %f")

;; menu bar wastes space for some people, but not others
;; (menu-bar-mode -1) THIS IS OK ON MACOS

;; allows easy & nifty perl comment control...
(setq perl-tab-to-comment t)

;; use unified diff output style for CVS diff's, mainly
(setq diff-command "diff -u")
(setq diff-switches "-u")

;; no annoying scratch message, as you get the intro message regardless
(setq initial-scratch-message nil)

;; show more info by default in mode line
(setq column-number-mode t)

(add-to-list 'load-path "~/.emacs.d/modes/")
(require 'snakemake-mode)

;; default to text-mode (as opposed to Lisp)
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Always end a file with a newline
;;(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; allow lisp eval thingy
(put 'eval-expression 'disabled nil)

;; Give each buffer a unique name.
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-after-kill-buffer-p t)

;; From Michael Hoffman 21 October 2011
;; Press C-x C-. to turn on visual-line-mode and variable-pitch-mode
;;  and turn off auto-fill-mode.
(defun visual-line-no-auto-fill-mode ()
  (interactive)
  (visual-line-mode)
  (turn-off-auto-fill))

(defun visual-line-variable-pitch-mode ()
  (interactive)
  (visual-line-mode)
  (variable-pitch-mode)
  (turn-off-auto-fill))

(define-key ctl-x-map [?\C-.] 'visual-line-variable-pitch-mode) 

;; Enable editing of markdown files.
(add-to-list 'load-path "/net/noble/vol1/home/noble/.emacs-modes")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Backup files under version control.
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Backup.html
;; I do this so running scripts get backed up.
(setq vc-make-backup-files t)

(setq sentence-end-double-space nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(font-use-system-font t)
 '(line-number-mode 1)
 '(warning-suppress-types '((comp))))

;;; Enable decompression of files.
;;; This should happen near the end, as it modifies auto-mode-alist.
(require 'jka-compr)
(jka-compr-install)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 240 :width normal :foundry "nil" :family "Menlo")))))
