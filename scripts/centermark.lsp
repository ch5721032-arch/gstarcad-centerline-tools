;; centermark.lsp - Draw a center mark on a circle or arc
;; Command: CENMARK
;; Usage: pick a circle or arc; a small cross is drawn at its center
(defun c:CENMARK ( / en ed c r d )
  (setq en (car (entsel "\nPick a circle or arc: ")))
  (if en
    (progn
      (setq ed (entget en)
            c (cdr (assoc 10 ed))
            r (cdr (assoc 40 ed))
            d (* r 1.2))
      (command "_.LINE" (list (- (car c) d) (cadr c))
                         (list (+ (car c) d) (cadr c)) "")
      (command "_.LINE" (list (car c) (- (cadr c) d))
                         (list (car c) (+ (cadr c) d)) "")
      (princ "\nCenter mark drawn.")
    )
  )
  (princ)
)
