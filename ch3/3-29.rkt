#lang racket

;; Exercise 3.29.  Another way to construct an or-gate is as a compound
;; digital logic device, built from and-gates and inverters. Define a
;; procedure or-gate that accomplishes this. What is the delay time of
;; the or-gate in terms of and-gate-delay and inverter-delay?

;; Circut Diagram
;;
;; --inverter --
;;               |AND| --- inverter ---
;; --inverter --

(define (or-using-and-inv s1 s2 out)
  (let ((wire-one (make-wire))
        (wire-two (make-wire))
        (wire-three (make-wire)))
    
    (inverter s1 wire-one)
    (inverter s2 wire-two)
    (and-gate wire-one wire-two wire-three)
    (inverter wire-three out)))
                  