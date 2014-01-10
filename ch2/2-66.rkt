#lang racket

;; Exercise 2.66.  Implement the lookup procedure for the case where the set of records
;; is structured as a binary tree, ordered by the numerical values of the keys.

;; we should be able to get O (log n) time here.

(define (lookup given-key record-tree)
  (cond ((null? record-tree) false)
        ((equal? given-key (entry record-tree)) true)
        ((> given-key (entry record-tree)) (lookup given-key (right-branch record-tree)))
        ((< given-key (entry record-tree)) (lookup given-key (left-branch record-tree)))))
         

(define (make-tree entry left right)
  (list entry left right))

(define (entry tree)
  (car tree))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define tree1 (make-tree 7 (make-tree 3 (make-tree 1 `() `()) (make-tree 5 `() `()))
                        (make-tree 9 `() (make-tree 11 `() `()))))

;; test

(lookup 20 tree1) ;;false
(lookup 9 tree1) ;;true