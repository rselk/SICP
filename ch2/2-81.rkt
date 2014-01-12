#lang racket

;; a. With Louis's coercion procedures installed, what happens if apply-generic is
;; called with two arguments of type scheme-number or two arguments of type complex
;; for an operation that is not found in the table for those types? For example,
;; assume that we've defined a generic exponentiation operation:

;; A) This will loop forever and not end. 

;; b. Is Louis correct that something had to be done about coercion with arguments
;; of the same type, or does apply-generic work correctly as is?

;; B) Nothing is wrong with the code that I can see. Apply-generic should work.

