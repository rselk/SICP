#lang racket

;; Exercise 3.13.  Consider the following make-cycle procedure, which uses
;; the last-pair procedure defined in exercise 3.12:

;; (define (make-cycle x)
;;  (set-cdr! (last-pair x) x)
;;  x)

;; (define z (make-cycle (list 'a 'b 'c)))
;; What happens if we try to compute (last-pair z)?

(require scheme/mpair)

(define (mlast-pair x)
  (if (null? (mcdr x))
      x
      (mlast-pair (mcdr x))))

(define (make-cycle x)
  (set-mcdr! (mlast-pair x) x)
  x)

(make-cycle (mlist 1 2 3 4))
;; #0=(mcons 1 (mcons 2 (mcons 3 (mcons 4 #0#))))

;; This has created a loop. The last pair (4 in this case) is returned from last-pair
;; then the cdr of this (the null at the end) is set to the begining of x
;; the end is pointing to the start of the list.

