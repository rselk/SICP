#lang racket

;; Exercise 2.61.  Give an implementation of adjoin-set using the ordered representation.
;; By analogy with element-of-set? show how to take advantage of the ordering to produce
;; a procedure that requires on the average about half as many steps as with the 
;; unordered representation.

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set-ordered x set) 
       (if (or (null? set) (< x (car set)))
           (cons x set)
           (cons (car set) (adjoin-set-ordered x (cdr set)))))

;;tests
(adjoin-set-ordered 0 (list 1 2 8 10))
(adjoin-set-ordered 5 (list 1 2 8 10))
(adjoin-set-ordered 9 (list 1 2 8 10))
(adjoin-set-ordered 11 (list 1 2 8 10))