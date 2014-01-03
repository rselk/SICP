#lang racket

;; Exercise 2.27
;; produce a deep-reverse procedure that takes a list as argument and
;; returns as its value the list with its elements reversed and with 
;; all sublists deep-reversed as well

(define (reverse origlist)
  (define (reverse-iter l1 l2)
    (if (null? l1)
      l2
      (reverse-iter (cdr l1) (cons (car l1) l2))))
  (reverse-iter origlist null))

;; deep-reverse
(define (deep-reverse origlist)
  (define (reverse-iter l1 l2)
    (if (null? l1)
        l2
        (if (pair? (car l1))
            (reverse-iter (cdr l1) (cons (deep-reverse (car l1)) l2))
            (reverse-iter (cdr l1) (cons (car l1) l2)))))
  (reverse-iter origlist null))

;; tests
(define x (list (list 1 2) (list 3 4)))
(deep-reverse x)
(reverse (list 1 2 3 4))