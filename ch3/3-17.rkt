#lang racket

;; Exercise 3.17.  Devise a correct version of the count-pairs procedure of
;; exercise 3.16 that returns the number of distinct pairs in any structure.
;; (Hint: Traverse the structure, maintaining an auxiliary data structure that
;; is used to keep track of which pairs have already been counted.)

;; new correct-pairs function.
;; uses mutable seen list.
;; if not a pair, return zero
;; if a pair which we havn't seen, put it in the seen list and add 1 + recursivly call the
;; rest of the list
;; if its a pair we have seen, don't count it and recursivly call the rest of the list

(define (count-pairs-correct x)
  (let ((seen `()))
    (define (helper x)
      (if (pair? x)
          (if (memq x seen) 
              (+ (helper (car x)) (helper (cdr x)))
              (begin (set! seen (cons x seen))
                     (+ 1 (helper (car x)) (helper (cdr x)))))
          0)) 
    (helper x)))
          
     
;; helper function. makes list of x pairs with values of 1.
(define (cons-with-x-pairs x) 
  (if (= x 0)
      null
      (cons 1 (cons-with-x-pairs (- x 1)))))

;;tests
(count-pairs-correct (cons-with-x-pairs 1))
(count-pairs-correct (cons-with-x-pairs 2))
(count-pairs-correct (cons-with-x-pairs 999))