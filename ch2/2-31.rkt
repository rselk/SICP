#lang racket

;; Exercise 2.31.  Abstract your answer to exercise 2.30 to produce a
;; procedure tree-map with the property that square-tree could be defined as

(define (square x) (* x x))

(define (square-tree tree)
  (tree-map square tree))

;; just add proc
;; can be called with any procedure that takes since inpute (ie (square x) )
(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)))
       tree))

;; tests
(define x (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(square-tree x)