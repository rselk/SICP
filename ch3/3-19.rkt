#lang racket
(require scheme/mpair)
;; Exercise 3.19.  Redo exercise 3.18 using an algorithm that takes only a constant
;; amount of space. (This requires a very clever idea.)

;;my solution from 3-18 did this. 

(define (mlast-pair x)
  (if (null? (mcdr x))
      x
      (mlast-pair (mcdr x))))

(define (make-cycle x)
  (set-mcdr! (mlast-pair x) x)
  x)

(define c-list (make-cycle (mlist 1 2 3 4 5 6))) ;; circular list.
(define (circular-list? l)
  (define (go-through l1 l2)
    (cond ((null? l2) #f)
          ((eq? (mcar l) (mcar l2)) #t)
          (else (go-through (mcdr l) (mcdr l2)))))
  (go-through l (mcdr l)))

(circular-list? c-list) ;; true
(circular-list? (mlist 1 2 3 4)) ;;false