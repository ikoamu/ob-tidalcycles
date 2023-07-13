;;; ob-tidalcycles.el --- org-babel functions for tidalcycles evaluation

;; Copyright (C) 2023 AOKI Shotaro

;; Author: AOKI Shotaro
;; Keywords: literate programming, reproducible research, tidalcycles
;; Homepage: https://github.com/ikoamu/ob-tidalcycles
;; Version: 0.1
;; Package-Requires: ((org "8.0") (tidal "0.0.1"))

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;; Exec tidalcycles in org-babel code blocks.

;;; Requirements:
;; You need to install tidalcycles to use this extension.

;;; Code:
(require 'ob)
(require 'tidal)

(add-to-list 'org-babel-tangle-lang-exts '("tidalcycles" . "tidal"))

(defun org-babel-execute:tidal (body params)
  "Execute a block of Tidal Cycles code with org-babel.
This function is called by `org-babel-execute-src-block'"
  (interactive)
  (let ((result (ignore-errors
		  (tidal-send-string "hush") t)))
    (unless result (tidal-start-haskell)))
  (tidal-send-string ":{")
  (tidal-send-string body)
  (tidal-send-string ":}")
  ;; result is always tidal>
  "tidal>")

(provide 'ob-tidalcycles)

;;; ob-tidalcycles.el ends here


