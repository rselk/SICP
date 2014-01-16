#lang racket
(require scheme/mpair)
;; this is needed for queues in racket
;; different function names then MIT scheme
(require data/queue)

;; Define a procedure print-queue that takes a queue as input and prints the
;; sequence of items in the queue.

;; rackets queue implimentation seems to fix the problem discussed in the book.

;; With the SICP/MIT scheme implimentation the queue is stored as a pair of 2 pointers
;; one pointer is pointing to the start of the list, and one pointer to the end 
;; (the order if these can be determined by the implimentation)
;; in, MIT scheme the first space in he pair of pointer is to the start of the list.
;; so in MIT scheme when we want to access the actual data of the queue we can just
;; ask for the first pointer

(define (print-queue q) (car q))
