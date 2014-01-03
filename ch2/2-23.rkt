#lang racket

;; Exercise 2.23
;; Give an implementation of for-each.
 
(define (foreach proc list)
  (cond ((null? list) true )
        (else (proc (car list))
              (foreach proc (cdr list)))))

(foreach (lambda (x) (newline) (display x))
          (list 57 321 88))