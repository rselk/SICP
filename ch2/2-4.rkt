#lang racket

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

;;verify
(car (cons 2 3)) ;; 2

;;corresponding cdr

(define (cdr z)
  (z (lambda (p q) q)))

(cdr (cons 2 3))
