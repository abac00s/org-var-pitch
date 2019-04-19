;; Emacs plugin for mixed pitch fonts in Org Mode
;; Copyright (C) 2019  Adam Bac

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;; USAGE:

;; - put this file somewhere in your load-path
;; - load with:

;;   (require 'org-var-pitch)

;; - initialize with:

;;   (org-var-pitch-init)

;; - enable variable-pitch-mode in Org Mode, for example:

;;   (add-hook 'org-mode-hook #'variable-pitch-mode)

;; If you use company for autocompletion, results in the popup window may appear
;; to zig-zag. A workaround is to install and use company-box.


(require 'org)


(defgroup org-var-pitch nil
  "Org mode with mixed fixed and variable faces.")


(defcustom org-var-pitch-all-faces
  '(org-default
    org-hide
    org-level-1
    org-level-2
    org-level-3
    org-level-4
    org-level-5
    org-level-6
    org-level-7
    org-level-8
    org-special-keyword
    org-drawer
    org-property-value
    org-column
    org-column-title
    org-agenda-column-dateline
    org-warning
    org-archived
    org-link
    org-footnote
    org-ellipsis
    org-target
    org-date
    org-date-selected
    org-sexp-date
    org-tag
    org-list-dt
    org-todo
    org-done
    org-agenda-done
    org-headline-done
    org-priority
    org-checkbox
    org-checkbox-statistics-todo
    org-checkbox-statistics-done
    org-table
    org-formula
    org-code
    org-meta-line
    org-document-title
    org-document-info
    org-document-info-keyword
    org-block
    org-block-begin-line
    org-block-end-line
    org-verbatim
    org-quote
    org-verse
    org-clock-overlay
    org-agenda-structure
    org-agenda-date
    org-agenda-date-today
    org-agenda-clocking
    org-agenda-date-weekend
    org-scheduled
    org-scheduled-today
    org-agenda-dimmed-todo-face
    org-scheduled-previously
    org-upcoming-deadline
    org-agenda-restriction-lock
    org-agenda-filter-tags
    org-agenda-filter-regexp
    org-agenda-filter-category
    org-time-grid
    org-agenda-current-time
    org-agenda-diary
    org-agenda-calendar-event
    org-agenda-calendar-sexp
    org-latex-and-related
    org-macro
    org-tag-group
    org-mode-line-clock
    org-mode-line-clock-overrun)
  "List of all Org Mode faces."
  :type '((repeat face)))


(defcustom org-var-pitch-variable-pitch-faces
  '(org-level-1
    org-level-2
    org-level-3
    org-level-4
    org-level-5
    org-level-6
    org-level-7
    org-level-8
    org-link
    org-footnote
    org-list-dt
    org-document-title
    org-quote
    org-verse)
  "List of Org Mode faces intended to have variable pitch."
  :type '((repeat face)))


(defface org-var-pitch-fixed nil
  "Face inherited by Org Mode faces intended to have fixed pitch.")


(defun org-var-pitch-clone-face (src-face dest-face)
  "Copy all attributes from SRC-FACE to DEST-FACE."
  (apply #'set-face-attribute
         dest-face
         nil
         (custom-face-attributes-get src-face nil)))


(defun org-var-pitch-init (&optional fixed-face)
  "Set all faces in org-var-pitch-variable-faces to inherit from
variable-pitch and the rest of Org Mode faces to inherit from
org-var-pitch-fixed. Copy all the properties of FIXED-FACE to
org-var-pitch-fixed.

If FIXED-FACE is not provided or nil, copy the properties from
default face."

  (unless fixed-face
    (setq fixed-face 'default))

  (org-var-pitch-clone-face fixed-face 'org-var-pitch-fixed)

  (dolist (face org-var-pitch-all-faces)
    (set-face-attribute face nil :inherit 'org-var-pitch-fixed))

  (dolist (face org-var-pitch-variable-pitch-faces)
    (set-face-attribute face nil :inherit 'default)))


(provide 'org-var-pitch)
