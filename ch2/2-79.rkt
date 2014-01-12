#lang racket

;; Exercise 2.79.  Define a generic equality predicate equ? that tests the equality
;; of two numbers, and install it in the generic arithmetic package. This operation
;; should work for ordinary numbers, rational numbers, and complex numbers.

;; access function by
(define (ecu? n1 n2)
  (apply-generic `equ? n1 n2))

;; in scheme package
(put `ecu? `(scheme-number scheme-number) =)

;; in rational package
(define (equ? r1 r2) (= (* (numer r1) (denom r1))
                        (* (numer r2) (denom r1))))
(put `ecu? `(rational rational) equ?)

;; in complex package
(define (equ? c1 c2) (and
                      (= (real-part c1) (real-part c2))
                      (= (imag-part c1) (image-part c1))))
(put `ecu? `(complex complex) equ?)
                        
