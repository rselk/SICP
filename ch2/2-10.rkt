#lang racket

;; Exercise 2.10.  Ben Bitdiddle, an expert systems programmer, 
;; looks over Alyssa's shoulder and comments that it is not clear 
;; what it means to divide by an interval that spans zero. Modify 
;; Alyssa's code to check for this condition and to signal an error 
;; if it occurs.

(define (make-interval a b)
  (cons a b))

(define (upper-bound i)
  (max (car i) (cdr i)))

(define (lower-bound i)
  (min (car i) (cdr i)))

(upper-bound (make-interval 2 4))
(lower-bound (make-interval 2 4))


(define (sub-interval a b)
  (make-interval (- (lower-bound a) (upper-bound b))
                 (- (upper-bound a) (lower-bound b))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (<= (* (lower-bound y) (upper-bound y)) 0) ;; answer to 2-10
      (error "/ 0")
      ((mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))))

;; tests

(sub-interval 
 (make-interval 2 4)
 (make-interval 5 6))