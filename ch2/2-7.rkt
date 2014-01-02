#lang racket

(define (make-interval a b)
  (cons a b))

(define (upper-bound i)
  (max (car i) (cdr i)))

(define (lower-bound i)
  (min (car i) (cdr i)))

;; tests

(upper-bound (make-interval 2 4))
(lower-bound (make-interval 2 4))