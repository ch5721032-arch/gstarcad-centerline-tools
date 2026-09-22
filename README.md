# GstarCAD Centerline Tools

Draw center marks on circles and arcs, and centerlines between two parallel lines, with one pick each.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Center marks and centrelines are small details that make drawings look professional and keep dimensions honest. These helpers place a cross on any circle or arc in one pick, do the same for a whole selection at once, and draw a centerline exactly between two parallel lines.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/centermark.lsp` | ;; centermark.lsp - Draw a center mark on a circle or arc
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
 |
| `scripts/centerline-2lines.lsp` | ;; centerline-2lines.lsp - Draw a centerline between two parallel lines
;; Command: CENLINE2
;; Usage: pick the two lines of a wall, road or detail
(defun c:CENLINE2 ( / e1 e2 d1 d2 p1a p1b p2a p2b sa sb ea eb m1 m2 )
  (setq e1 (car (entsel "\nPick the first line: "))
        e2 (car (entsel "\nPick the second line: ")))
  (if (and e1 e2)
    (progn
      (setq d1 (entget e1) d2 (entget e2)
            p1a (cdr (assoc 10 d1)) p1b (cdr (assoc 11 d1))
            p2a (cdr (assoc 10 d2)) p2b (cdr (assoc 11 d2)))
      (if (<= (+ (distance p1a p2a) (distance p1b p2b))
              (+ (distance p1a p2b) (distance p1b p2a)))
        (setq sa p1a sb p2a ea p1b eb p2b)
        (setq sa p1a sb p2b ea p1b eb p2a)
      )
      (setq m1 (list (/ (+ (car sa) (car sb)) 2.0)
                     (/ (+ (cadr sa) (cadr sb)) 2.0) 0.0)
            m2 (list (/ (+ (car ea) (car eb)) 2.0)
                     (/ (+ (cadr ea) (cadr eb)) 2.0) 0.0))
      (command "_.LINE" m1 m2 "")
      (princ "\nCenterline drawn.")
    )
  )
  (princ)
)
 |
| `scripts/centermark-all.lsp` | ;; centermark-all.lsp - Draw center marks on many circles and arcs
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
