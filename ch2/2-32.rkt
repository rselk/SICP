#lang racket

;; We can represent a set as a list of distinct elements, and we can 
;; represent the set of all subsets of the set as a list of lists. 
;; For example, if the set is (1 2 3), then the set of all subsets is
;; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)). Complete the following
;; definition of a procedure that generates the set of subsets of a set
;; and give a clear explanation of why it works.

;; The reason it works (and I had to look this up) is:
;; the set of all subsets is a) set of all subsets of (cdr s)
;;                           b) same as above, with first number cons'ed onto each


(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s)))) ;; A
        (append rest (map (lambda (val)
                            (cons (car s) val)) ;; B
                          rest)))))

(subsets (list 1 2 3))
                            