#lang racket
(require scheme/mpair)
;; Exercise 3.18.  Write a procedure that examines a list and determines whether it
;; contains a cycle, that is, whether a program that tried to find the end of the
;; list by taking successive cdrs would go into an infinite loop. Exercise 3.13
;; constructed such lists.

;; from 3.13
(define (mlast-pair x)
  (if (null? (mcdr x))
      x
      (mlast-pair (mcdr x))))

(define (make-cycle x)
  (set-mcdr! (mlast-pair x) x)
  x)

(define c-list (make-cycle (mlist 1 2 3 4 5 6))) ;; circular list.

;; to find a circular list we can:
;; start looking at list from very start
;; start looking at list from very start + 1
;; if these 2 starting points ever end up at the same spot, there must be a circle.

(define (circular-list? l)
  (define (go-through l1 l2)
    (cond ((null? l2) #f)
          ((eq? (mcar l) (mcar l2)) #t)
          (else (go-through (mcdr l) (mcdr l2)))))
  (go-through l (mcdr l)))

(circular-list? c-list) ;; true
(circular-list? (mlist 1 2 3 4)) ;;false
   
    