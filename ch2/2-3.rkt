#lang racket
 
(define (make-point x y)
 (cons x y))
 
(define (y-point a)
 (cdr a))

(define (x-point a)
  (car a))

(define (make-rectangle bot-left top-right)
  (cons bot-left top-right))

(define (bot-left r)
  (car r))

(define (top-right r)
  (cdr r))

(define (bot-right r)
  (make-point (x-point (cdr r))
              (y-point (car r))))

(define (top-left r)
  (make-point (x-point (car r))
              (y-point (cdr r))))

(define (width r)
  (abs ( - (x-point (top-left r)) (x-point (top-right r)))))

(define (height r)
  (abs ( - (y-point (top-left r)) (y-point (bot-left r)))))

;; area + perimeter methods

(define (area r)
  (* (width r) (height r)))

(define (perimeter r)
  ( + (* (width r) 2) (* (height r) 2)))
 
(define test (make-rectangle (make-point 1 1) (make-point 3 3)))

;;tests
(perimeter test)
(area test)

 
 
 
 