#lang racket

;; Exercise 2.12.  Define a constructor make-center-percent that takes a 
;; center and a percentage tolerance and produces the desired interval. 
;; You must also define a selector percent that produces the percentage 
;; tolerance for a given interval. The center selector is the same as the 
;; one shown above.

(define (make-interval a b)
  (cons a b))

(define (upper-bound i)
  (max (car i) (cdr i)))

(define (lower-bound i)
  (min (car i) (cdr i)))

;;center (given)
(define (center i)
  (/ (+ (upper-bound i) (lower-bound i)) 2))

;; this is a helper function when we want to use % instead of pre-calculated values
(define (percent-interval val pct)
  (make-interval (- val (* val pct)) (+ val (* val pct))))

;; http://community.schemewiki.org/?sicp-ex-2.12
(define (tolerance i) 
   (let ((center (/ (+ (upper-bound i) (lower-bound i)) 2.0)) 
         (width (/ (- (upper-bound i) (lower-bound i)) 2.0))) 
     (* (/ width center) 100))) 

 (define i (percent-interval 10 .50)) 
 (lower-bound i) 
 (upper-bound i) 
 (center i) 
 (tolerance i) 

