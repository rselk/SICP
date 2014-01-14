#lang racket

;; Exercise 3.8.  When we defined the evaluation model in section 1.1.3, we said
;; that the first step in evaluating an expression is to evaluate its subexpressions.
;; But we never specified the order in which the subexpressions should be evaluated
;; (e.g., left to right or right to left). When we introduce assignment, the order
;; in which the arguments to a procedure are evaluated can make a difference to the
;; result. Define a simple procedure f such that evaluating (+ (f 0) (f 1)) will
;; return 0 if the arguments to + are evaluated from left to right but will return
;; 1 if the arguments are evaluated from right to left.

;; if we go from Left -> Right
;; we evaluate (f 0) which returns 0 (as we get the true part of the if condition)
;; then we evaluate (f 1) which also returns 0 (we get the false part of the if condition)

;; if we go from Right -> Left
;; we evalute (f 1) we return 1 (the true part of the if condition)
;; we then evaluea (f 0) which also 
(define f
  (let ((number -99))
    (lambda (x)
      (if (eq? number -99)
          (begin (set! number x) number)
          0))))
   
(define g
  (let ((number -99))
    (lambda (x)
      (if (eq? number -99)
          (begin (set! number x) number)
          0))))

;; note - to demo I made 2 functions as the local variable "number" will be saved between calls
(+ (f 0) (f 1))
(+ (g 1) (g 0))