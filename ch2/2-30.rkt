#lang racket

;; Exercise 2.30.
;; Define a procedure square-tree analogous to the square-list 
;; procedure of exercise 2.21.

;; without using higher order procedures
(define (square-tree-woho tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree tree))
         (else (cons (square-tree-woho (car tree))
                     (square-tree-woho (cdr tree))))))

;; map and recursion version
(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (* sub-tree sub-tree)))
       tree))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

(square-tree-woho
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))