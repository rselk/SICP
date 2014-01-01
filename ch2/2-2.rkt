#lang racket

;; Ex 2.2
 (define (print-point p) 
   (newline) 
   (display "(") 
   (display (x-point p)) 
   (display ",") 
   (display (y-point p)) 
   (display ")")) 
 
(define (make-segment a b) ;; takes in 2 cons pairs
  (cons a b))

(define (make-point x y)
  (cons x y))

(define (y-point a)
  (cdr a))

(define (x-point a)
  (car a))

(define (start-segment a)
  (car a))

(define (end-segment a)
  (cdr a))

(define (aveline a b)
  (/ (+ a b) 2))

(define (midpoint-segment a)
  (make-point (aveline (x-point (start-segment a)) (x-point (end-segment a)))               
              (aveline (y-point (start-segment a)) (y-point (end-segment a)))))
                                 

 (define test (make-segment (make-point 2 2) (make-point 4 4))) 
 (print-point (midpoint-segment test)) ;; expect: (3,3)