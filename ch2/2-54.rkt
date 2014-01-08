#lang racket

;; Exercise 2.54.  Two lists are said to be equal? if they contain equal elements
;; arranged in the same order. Using this idea, implement equal? as a procedure.

(define (equal? l1 l2)
  (cond ((and (null? l1) (null? l2)) true)
        ((null? l1) false)
        ((null? l2) false)
        (else (if (eq? (car l1) (car l2))
                  (equal? (cdr l1) (cdr l2))
                  false))))

(equal? `(this is a list) `(this is a list))
(equal? `(this is a list) `(this (is a) list))