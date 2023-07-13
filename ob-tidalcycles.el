(require 'ob)

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

