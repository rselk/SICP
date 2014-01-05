#lang racket

;; part A

;; Write the corrIesponding selectors left-branch and right-branch, 
;; which return the branches of a mobile, and branch-length and 
;; branch-structure, which return the components of a branch.

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch x)
  (car x))

(define (right-branch x)
  (car (cdr x)))

(define (branch-length x)
  (car x))

(define (branch-structure x)
  (car (cdr x)))

(define ll (make-branch 9 10))
(define rr (make-branch 5 (make-mobile (make-branch 2 11) (make-branch 7 12))))

(define passbalance (make-mobile
                     (make-branch 5 5)
                     (make-branch 5 5)))

;; construction tests / example
(define mainmobile (make-mobile ll rr))
(display mainmobile)
(display "\n" )
(display (left-branch mainmobile))
(display "\n" )
(display (right-branch mainmobile))
(display "\n" )
(display (branch-length ll))

;; part B
;; Using your selectors, define a procedure total-weight that
;; returns the total weight of a mobile.

(define (b-weight branch) 
   (if (pair? (branch-structure branch)) 
       (total-weight (branch-structure branch)) 
       (branch-structure branch)))
  
(define (total-weight b) 
 (+ (b-weight (left-branch b)) 
    (b-weight (right-branch b)))) 
 
(display "\n" )
(total-weight mainmobile)

;; part C

;; A mobile is said to be balanced if the torque applied by its top-left
;; branch is equal to that applied by its top-right branch (that is, if
;; the length of the left rod multiplied by the weight hanging from that
;; rod is equal to the corresponding product for the right side) and if
;; each of the submobiles hanging off its branches is balanced. Design
;; a predicate that tests whether a binary mobile is balanced.


;; individual branch torque
(define (b-torque b)
  (* (b-weight b) (branch-length b)))

(define (b-balanced b)
  (if (pair? (branch-structure b)) ;; check if mobile
      (balanced (branch-structure b))
      true))

(define (balanced m)
  (if (and
       (= (b-torque (left-branch m)) (b-torque (right-branch m)))
       (b-balanced (left-branch m))
       (b-balanced (right-branch m)))
      true
      false))

;; failing balance test
(balanced mainmobile)
;; passing balance test
(balanced passbalance)

;; D
;; just remove car from right-branch && structure as we don't need to deal with null end
(define (right-branch-cons x)
  (cdr x))

(define (branch-structure-cons x)
  (cdr x))