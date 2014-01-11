#lang racket

;; Exercise 2.75.  Implement the constructor make-from-mag-ang in message-passing
;; style. This procedure should be analogous to the make-from-real-imag procedure
;; given above.

;; pretty much the same as make-from-real-imag (below)
;; just different formulas depending on dispatch

(define (make-from-mag-ang x y)
  (define (dispatch op)
    (cond ((eq? op `real-part)
           (* x (cos y))
           (eq? op `imag-part)
           (* x (sin y))
           ((eq? op `magnitude)
            x)
           ((eq? op `angle )
            a)
           (else
            (error "UNKNOWN OP" op))))) dispatch)

(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

