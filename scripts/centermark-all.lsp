;; centermark-all.lsp - Draw center marks on many circles and arcs
;; Command: CENMARKALL
(defun c:CENMARKALL ( / ss i en ed c r d )
  (setq ss (ssget '((0 . "CIRCLE,ARC"))))
  (if ss
    (progn
      (setq i 0)
      (repeat (sslength ss)
        (setq en (ssname ss i)
              ed (entget en)
              c (cdr (assoc 10 ed))
              r (cdr (assoc 40 ed))
              d (* r 1.2))
        (command "_.LINE" (list (- (car c) d) (cadr c))
                           (list (+ (car c) d) (cadr c)) "")
        (command "_.LINE" (list (car c) (- (cadr c) d))
                           (list (car c) (+ (cadr c) d)) "")
        (setq i (1+ i))
      )
      (princ (strcat "\nCenter marks drawn: " (itoa (sslength ss))))
    )
  )
  (princ)
)
