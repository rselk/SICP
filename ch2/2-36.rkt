#lang racket

;; Exercise 2.36.  The procedure accumulate-n is similar to accumulate
;; except that it takes as its third argument a sequence of sequences,
;; which are all assumed to have the same number of elements. It applies
;; the designated accumulation procedure to combine all the first elements 
;; of the sequences, all the second elements of the sequences, and so on, 
;; and returns a sequence of the results. For instance, if s is a sequence 
;; containing four sequences, ((1 2 3) (4 5 6) (7 8 9) (10 11 12)), then 
;; the value of (accumulate-n + 0 s) should be the sequence (22 26 30). 
;; Fill in the missing expressions in the following definition of accumulate-n

;; accumulate function
 (define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 

;; accumulate-n
;; take first element of each sub-list in seq (map car seqs)
;; accumulate those with call to original accumulate
 
;; then take the rest of the list and recursivly call accumulate-n
 
;; ex
;; (1 2 3) (4 5 6) (7 8 9)
;; accumulate + 0 (1 4 7)
;; accumulate-n + 0 (2 3) (5 6) (8 9)
;; accumulate + 0 (2 5 8)
;; accumulate-n + 0 (3) (6) (9)
;; accumulate + 0 (3 6 9)
 
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(accumulate-n + 0 (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))