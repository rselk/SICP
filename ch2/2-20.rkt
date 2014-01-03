#lang racket

;; Example 2-20
;; write a procedure same-parity that takes one or more integers and 
;; returns a list of all the arguments that have the same even-odd 
;; parity as the first argument.

(define (same-parity . origlist)
  (define (check-first-value x) ;;returns a function here. either even or odd.
    (if (even? x)
        even?
        odd?))
  (define (iter evenorodd l)
    (if (null? l) 
        `()
        (if (evenorodd (car l))
            (cons (car l) (iter evenorodd (cdr l)))
            (iter evenorodd (cdr l)))))
  (iter (check-first-value (car origlist)) origlist))
  
(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7) 