#lang racket

;;count number of times we can divide and get % 0
(define (count-divisions n divisor)
  (define (count-divisions-iter x)
    (if (= (modulo n (expt divisor x)) 0)
        (count-divisions-iter (+ x 1))
        (- x 1)))
  (count-divisions-iter 1))

(define (cons a b) 
  (* (expt 2 a) (expt 3 b)))

(define (car a)
  (count-divisions a 2))

(define (cdr a)
  (count-divisions a 3))

;;tests
(car (cons 4 15)) 
(cdr (cons 4 15))  