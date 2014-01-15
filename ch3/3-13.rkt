#lang racket

;; NOTE - I am using Racket. In racket (and PLT Scheme) cons cells are immutable
;; by default
;; with the below require we can use mcar, mcdr, mcons and set-mcar! set-mcdr!

;; Exercise 3.12. 
;; What are the missing <response>s? 
(require scheme/mpair)

(define (append! x y)
  (set-mcdr! (mlast-pair x) y)
  x)

(define (mlast-pair x)
  (if (null? (mcdr x))
      x
      (mlast-pair (mcdr x))))

;;(define x (list 'a 'b))
;;(define y (list 'c 'd))
;;(define z (append x y))
;;z
;;(a b c d)
;;(cdr x)
;;<response>

;; this will be `(b)

;;(define w (append! x y))
;;w
;;(a b c d)
;;(cdr x)
;;<response>

;; since append! mutates x, this will be `(b c d)