#lang racket

;; Exercise 2.60.  We specified that a set would be represented as a list with no
;; duplicates. Now suppose we allow duplicates. For instance, the set {1,2,3} could 
;; be represented as the list (2 3 2 1 3 2 2). Design procedures element-of-set?, 
;; adjoin-set, union-set, and intersection-set that operate on this representation. 
;; How does the efficiency of each compare with the corresponding procedure for the
;; non-duplicate representation? Are there applications for which you would use this
;; representation in preference to the non-duplicate one?

(define (element-of-set-nd? x set)
  (if (null? set)
      false
      (if (eq? (car set) x)
          true
          (element-of-set-nd? x (cdr set)))))

(element-of-set-nd? 5 (list 1 2 3 3 5))

;; now this is constant time
(define (adjoin-set-nd s1 s2)
  (cons s1 s2))

;; now this is order n time
(define (union-set-nd s1 s2)
  (append s1 s2))

;; output elements which are in both
(define (intersection-set-nd s1 s2)
  (if (or (null? s1) (null? s2))
          `()
          (if (element-of-set-nd? (car s2) s1)
              (cons (car s2) (intersection-set-nd s1 (cdr s2)))
              (intersection-set-nd s1 (cdr s2)))))

(intersection-set-nd (list 1 2 3) (list 1 2 3))
;; 1 2 3
(intersection-set-nd (list 1 2) (list 4 2 7))
;; 2
(adjoin-set-nd (list 1 2 3 4) (list 1 2 3 4))
;; 1 2 3 4 1 2 3 4
(union-set-nd (list 1 2 3 4) (list 1 2 3 4))