#lang racket

(define (square-list items)
  (if (null? items)
      null
      (cons (* (car items) (car items)) (square-list (cdr items)))))

(square-list (list 1 2 3 4))

(define (square-listl items)
  (map (lambda (x) (* x x)) items))

(square-listl (list 1 2 3 4))