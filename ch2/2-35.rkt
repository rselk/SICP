#lang racket

;; Exercise 2.35.  Redefine count-leaves from section 2.2.2 as an accumulation

;; accumulate function
 (define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 
 
;;original
(define (count-leaves x)
  (cond ((null? x) 0)  
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

;;as a accumulation

;; If its a pair, call it with count-leaves-accumulate as that lambda will break down the pair.
;; ie (2 3 (4 5) 6) 
;; the lambda function will return 1 for 2, 3
;; then it will recursivly call count-leaves-accumulate with (4 5)
;; the lambda function will return 1 for 4, 5
;; once that evaluates we will be back in the original function call
;; the lambda function will return 1 for 6
;; while doing all of this the accumulate function has been summing all of the 1s returned

(define (count-leaves-accumulate t)
  (accumulate + 0 (map (lambda (x) (if (pair? x) 
                                       (count-leaves-accumulate x)
                                       1))t)))
;;tests
(define x (cons (list 1 2) (list 3 4)))
(count-leaves (list x x)) ;;8
(count-leaves-accumulate (list x x)) ;;8