#lang racket
(require scheme/mpair)

;; Exercise 3.16.  Ben Bitdiddle decides to write a procedure to count the number
;; of pairs in any list structure. ``It's easy,'' he reasons. ``The number of pairs
;; in any structure is the number in the car plus the number in the cdr plus one
;; more to count the current pair.'' So Ben writes the following procedure:

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define (mlast-pair x)
  (if (null? (mcdr x))
      x
      (mlast-pair (mcdr x))))
;; Show that this procedure is not correct. In particular, draw box-and-pointer diagrams
;; representing list structures made up of exactly three pairs for which Ben's procedure
;; would return 3; return 4; return 7; never return at all.

(count-pairs (list 1 2 3))
(count-pairs (list 1 2 3 4))
(count-pairs (list 1 2 3 4 5 6 7))

(define (make-cycle x)
  (set-mcdr! (mlast-pair x) x)
  x)
(define loop (make-cycle (mlist 1 2 3 4)))

(count-pairs loop)