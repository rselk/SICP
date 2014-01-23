#lang racket

;; Exercise 3.28.  Define an or-gate as a primitive function box. Your 
;; or-gate constructor should be similar to and-gate.

;; and gate for reference
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

;; or gate
(define (or-gate a1 a2 output)
  (define (or-action-proc)
    (let ((new-value 
           (locic-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-proc)
  (add-action! a2 or-action-proc)
  `ok)
;; logic for or-gate
(define (logic-or one two)
  (if (or (= one 1) (= two 1))
      1
      0))
