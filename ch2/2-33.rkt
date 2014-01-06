#lang racket


;; Exercise 2.33.  Fill in the missing expressions to complete the following
;; definitions of some basic list-manipulation operations as accumulations:

;; (define (map p sequence)
;;  (accumulate (lambda (x y) <??>) nil sequence))
;; (define (append seq1 seq2)
;;  (accumulate cons <??> <??>))
;; (define (length sequence)
;;  (accumulate <??> 0 sequence))

;; accumulate function
 (define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 
 
 (accumulate + 0 (list 1 2 3 4))
 
 ;;map
 (define (mmap p sequence)
   (accumulate (lambda (x y) (cons (p x) y)) null sequence))
 
 ;; test with basic function
 (define (cube x) (* x x x))
 (mmap cube (list 1 2 3 4))
 
 ;; test with lambda function
 (mmap (lambda (x) (* x x x)) (list 1 2 3 4))
 
 ;;append
 (define (aappend seq1 seq2)
   (accumulate cons seq2 seq1))
 
 (aappend (list 1 2 3 4) (list 4 4 4 4))
 
 ;;length
 (define (llength sequence)
   (accumulate (lambda (x y) (+ y 1)) 0 sequence))
 
 (llength (list 1 2 3 4 5))
 