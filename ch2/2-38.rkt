#lang racket

;; Exercise 2.38.

;; (fold-right / 1 (list 1 2 3))
(foldr / 1 (list 1 2 3))
;; 3/2

;; (fold-left / 1 (list 1 2 3))
;; 1/6
(foldl / 1 (list 1 2 3))
;; racket does things a differently from the lisp dialect in sicp as it returns 1.5

;; (fold-right list nil (list 1 2 3))
(foldr list null (list 1 2 3))
;; '(1 (2 (3 ())))

;; (fold-left list nil (list 1 2 3))
(foldl list null (list 1 2 3))
;; '(3 (2 (1 ())))