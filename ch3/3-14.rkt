#lang racket
(require scheme/mpair)

;; Exercise 3.14. 
;; What would be printed as the values of v and w ?
(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (mcdr x)))
          (set-mcdr! x y)
          (loop temp x))))
  (loop x '()))

(define v (mlist 'a 'b 'c 'd))
(define w (mystery v))

;; this function in practice reverses the list
;; the null character is still at the end after the reversal, and not at the start.
w
v
;; v = (a) *this happens as we are actually mutating the list with set-mcdr! 
;; this is a side effect of (mystery x)

;; w = (d c b a `()) *this is the list in reverse with the null character on the end.