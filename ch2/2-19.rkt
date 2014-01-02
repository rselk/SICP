#lang racket

;; given defs
(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

;; new change count program
(define (cc-new amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc-new amount
                (except-first-denomination coin-values))
            (cc-new (- amount
                   (first-denomination coin-values))
                coin-values)))))

;; see if list is null
(define (no-more? x)
  (if (null? x)
      true
      false))

;; return first denomination in the list
(define (first-denomination x)
  (car x))

;; return all except-first-denomination
(define (except-first-denomination x)
  (cdr x))

;;tests
(cc-new 100 us-coins)
(cc-new 100 uk-coins)