#lang racket

;; Exercise 2.57.  Extend the differentiation program to handle sums
;; and products of arbitrary numbers of (two or more) terms. Then the
;; last example above could be expressed as
;; (deriv '(* x y (+ x 3)) 'x)
;; Try to do this by changing only the representation for sums and
;; products, without changing the deriv procedure at all. For example,
;; the addend of a sum would be the first term, and the augend would
;; be the sum of the rest of the terms.

;; initially I had a solution to this problem by:
;; checking if there was a fourth item in the list
;; (list `+ a b c) <- c is 4th
;; if there was a fourth item, then call make-sum on 3rd and 4th item
;; or for multiplication (list `* a b c)
;; if there was a fourth item, then call make-product on 3rd and 4th item

;; after looking at others solutions, I think using accumulate is a better solution.
;; this works because:
;; when given an nested list ie:
;; (list `+ a b (list `+ c d) e)
;; we can think of it like a tree, and we are just trying to get the end nodes
;; since order is not important we can call accumulate with make-sum/make-product
;; it will effectivly turn the above expression into
;; (+ a b c d e)

;; accumulate function
 (define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 
 
(define (augend s)
 (accumulate make-sum 0 (cddr s)))
 
(define (multiplicand p)
  (accumulate make-product 1 (cddr p))) ;; note 1 as (= (* x 0) 0)
 
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        
        ;; exponentiation clause
        ((exponentiation? exp)
         (make-product 
          (make-product 
           (exponent exp)
           (make-exponentiation (base exp)
                                (make-sum (exponent exp) -1)))
          (deriv (base exp) var)))
                        
                                            
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
        (and (variable? v1)
             (variable? v2)
             (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))  

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) 
              (number? a2))
         (+ a1 a2))
        (else (list `+ a1 a2))))

           

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1)
              (number? m2))
         (* m1 m2))
        (else (list `* m1 m2))))

;; return 1 if exp 0
;; return base if exp 1
;; if both base and exp are numbers, we can simplify the calculation
;; else we can't and have to return the symbol
(define (make-exponentiation base exp)
  (cond ((=number? exp 0) 1)
        ((=number? exp 1) base)
        ((and (number? base) (number? exp))
         (expt base exp))
        (else (list `** base exp))))

(define (sum? x)
  (and (pair? x) (eq? (car x) `+)))

(define (addend s) 
  (cadr s))



(define (product? x)
  (and (pair? x) (eq? (car x) `*)))

;; see if exponent by checking if car is **
(define (exponentiation? x)
  (and (pair? x) (eq? (car x) `**)))

;; base is the 2nd argument ie (`** base exp)
(define (base p)
  (cadr p))

;; exponent is the 3rd argument
(define (exponent p)
  (caddr p))

(define (multiplier p)
  (cadr p))

;; tests
(deriv '(* x y (+ x 3)) 'x)
