#lang racket

;; Exercise 2.39.   Complete the following definitions of reverse 
;; (exercise 2.18) in terms of fold-right and fold-left from exercise 2.38:

;; (define (reverse sequence)
;;  (fold-right (lambda (x y) <??>) nil sequence))
;; (define (reverse sequence)
;;  (fold-left (lambda (x y) <??>) nil sequence))

(define (reverse-foldr sequence)
  (foldr (lambda (x y) (append y (list x))) null sequence))

(define (reverse-foldl sequence)
  (foldl (lambda (x y) (cons x y)) null sequence))

(reverse-foldr (list 1 2 3 4))
(reverse-foldl (list 1 2 3 4))

  
  