#lang racket

;; Exercise 2.80.  Define a generic predicate =zero? that tests if its argument is
;; zero, and install it in the generic arithmetic package. This operation should
;; work for ordinary numbers, rational numbers, and complex numbers.

;; access function by
(define (=zero? x)
  (apply-generic `=zero? x))

;; in scheme-number package
(define (=zero? num) (= num 0))
(put `=zero? `(scheme-number) =zero?)

;; in rational package
(define (=zero? rat) (= 0 (/ (numer rat) (denom rat))))
(put `=zero? `(rational) =zero?)

;; in complex package
(define (=zero? complex) (= (real-part complex) (imag-part complex) 0))
(put `=zero? `(complex) =zero?)

                        
