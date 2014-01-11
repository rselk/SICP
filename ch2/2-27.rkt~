#lang racket

(define (reverse origlist)
  (define (reverse-iter l1 l2)
    (if (null? l1)
      l2
      (reverse-iter (cdr l1) (cons (car l1) l2))))
    (reverse-iter origlist null))
    

(reverse (list 1 2 3 4))