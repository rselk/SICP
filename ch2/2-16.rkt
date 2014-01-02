#lang racket

(define (last-pair ll)
  (define (last-pair-iter l last)
    (if (null? l)
        last
        (last-pair-iter (cdr l) (car l))))
  (last-pair-iter ll 0))

 (last-pair '()) 
 (last-pair (list 1))  ;; '(1) 
 (last-pair (list 1 2))  ;; '(2) 
 (last-pair (list 1 2 3))  ;; '(3) 
 (last-pair (list 1 2 3 4))  ;; '(4) 
 

 
(reverse (list 1 4 9 16 25))

