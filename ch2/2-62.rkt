#lang racket

;; Exercise 2.62.  Give a O(n) implementation of union-set for sets represented 
;; as ordered lists.

;; This is like the merge component of merge sort, except if (car s1) == (car s2)
;; then we just put one of them in the list.

(define (union-set-ordered s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        ((= (car s1) (car s2)) (cons (car s1) (union-set-ordered (cdr s1) (cdr s2))))
        ((< (car s1) (car s2)) (cons (car s1) (union-set-ordered (cdr s1) s2)))
        ((> (car s1) (car s2)) (cons (car s2) (union-set-ordered s1 (cdr s2))))))
          
(union-set-ordered (list 5 6 7 8) (list 6 9 13))