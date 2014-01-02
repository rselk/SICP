#lang racket

(define zero 
  (lambda (f) 
    (lambda (x) x)))

(define (add-1 n)
  (lambda (f) 
    (lambda (x) 
      (f ((n f) x)))))

;; (add-1 zero)

;; Sub in zero in add-1
;; (lambda (f) (lambda (x) (f ((zero f) x))))

;; Sub body of zero
;; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))

;; Note - (lambda (x) x) x)) == x
;; (lambda (f) (lambda (x) (f x)))

(define one 
  (lambda (f) (lambda (x) (f x))))

;; same steps as above:

;; (add-1 one)
;; (lambda (f) (lambda (x) (f ((one f) x)))) 
;; (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x)))) 
;; (lambda (f) (lambda (x) (f ( f x))))

(define two 
  (lambda (f) (lambda (x) (f (f x)))))

;; Addition Procedure

(define (add a b)
  (lambda (x)
    (lambda (y)
      ((a x) ((b y) y)))))