#lang racket

;; a)
;; because we cant call function `operator with them.

;; new package of sum and product

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;; procedures for sums and products

;; new deriv package (parts B and C)
(define (install-deriv-package)
  (define (make-sum a1 a2) (list `+ a1 a2))
  ;;addend/augend now changed as we no longer need to pass around the first element (*/+)
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  
  (define (make-product a1 a2) (list `* a1 a2))
  (define (muliplier p) (car p))
  (define (muliplicant p) (cadr p))
  
  (define (derive-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  
  (define (deriv-product exp var)
    (make-sum
     (make-product (multiplier exp)
                   (deriv (multiplicant exp) var))
     (make-product (deriv (multiplier exp) var)
                   (multiplicand exp))))
  ;; Part C - adding exponentiation
  (define (deriv-exponentiation base exp)
    (make-product (make-product (exponent exp)
                                (make-sum (exponent exp) -1)))
    (deriv (base exp) var))

(put `deriv `+ deriv-sum)
(put `deriv `* deriv-product))
(put `deriv `** deriv-exponentiation))    

;; Original make-exponentiation

;;(define (make-exponentiation base exp)
;;  (cond ((=number? exp 0) 1)
;;        ((=number? exp 1) base)
;;        ((and (number? base) (number? exp))
;;         (expt base exp))
;;        (else (list `** base exp))))  
    
              
;;((exponentiation? exp)
;; (make-product 
;;  (make-product 
;;   (exponent exp)
;;   (make-exponentiation (base exp)
;;                        (make-sum (exponent exp) -1)))
;;  (deriv (base exp) var)))
    
;; Part D
;; Since we are just changing the order, we can re-impliment functions in our package
;; to use that order. We could also make another function which swaps the values.
              

