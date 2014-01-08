#lang racket

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

;; union set sends each element of s2 as "x" to element-of-set
;; if element-of-set includes x, we add it to our list. 
(define (union-set s1 s2)
  (if (null? s2)
      s1
      (if (element-of-set? (car s2) s1)
        (union-set s1 (cdr s2))
        (cons (car s2) (union-set s1 (cdr s2))))))
          
;; tests
(union-set (list 1 2 3) (list 4 5 6))
;; 1 2 3 4 5 6
(union-set (list 1 2 3) (list 1 2 4))
;; 1 2 3 4