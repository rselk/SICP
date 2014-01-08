#lang racket

;; Exercise 2.56
;; add a new clause to the deriv program and defining appropriate procedures
;; exponentiation?, base, exponent, and make-exponentiation. (You may use 
;; the symbol ** to denote exponentiation.) Build in the rules that anything
;; raised to the power 0 is 1 and anything raised to the power 1 is the 
;; thing itself.


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

(define (augend s)
  (caddr s))

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

(define (multiplicand p)
  (caddr p))

;; tests from book
(deriv `(+ x 3) `x)
(deriv `(* x y) `x)
(deriv `(* (* x y) (+ x 3)) `x)

;;exponent test
(deriv `(** x 3) `x) ;; '{* 3 {** x 2}}


                          
                          