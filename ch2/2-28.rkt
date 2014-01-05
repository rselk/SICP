#lang racket

;; Exercise 2.28.  Write a procedure fringe that takes as argument a tree
;; (represented as a list) and returns a list whose elements are all the
;; leaves of the tree arranged in left-to-right order.

(define mylist (list 1 2))
(define x (list (list 1 2) (list 3 4)))

(define (fringe in)
  (define (iter l1 l2)
    (if (null? l1)
        l2
        (if (pair? l1)
            (iter (car l1) (iter (cdr l1) l2))
            (cons l1 l2))))
  (iter in null))

;; tests
(fringe x)
(fringe (list x x))
            