#lang racket

;; Exercise 2.18.  Define a procedure reverse that takes a list as argument
;; and returns a list of the same elements in reverse order

 (define (reverse l1)
   (define (reverse-iter l1 l2)
     (if (null? l1)
         l2
         (reverse-iter (cdr l1) (cons (car l1) l2))))
   (reverse-iter l1 null))
 
 ;; ex
 ;; 4 2 1 3
 ;; (iter 213) (cons(4 null))
 ;; (iter 13) (cons (2 (cons 4 null)))
 ;; (iter 3) (cons (1 (cons (2 (cons 4 null ))))
 ;; (iter null) (cons ( 3 (cons (1 (cons (2 (cons 4 null ))))) -> l1 == null so return l2
          
;; test
(reverse (list 1 4 9 16 25))
;;check sending null list
(reverse '()) 

