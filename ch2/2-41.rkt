#lang racket
(require math/number-theory) ;; prime

;; needed functions
(define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 
 
(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))
 
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair)))) ; cadr is (car (cdr pair))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

 ;; given accum append
(define (unique-pairs n)
  (accumulate append
            null
            (map (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 n))))

;;solution
;; Once your realize you can solve this nesting
;; flatmap functions the solution becomes much simpler. 
;; O (n^3) complexity! ouch!
;; might come back to this one!

(define (triples-fm n)
  (flatmap (lambda (i)
         (flatmap (lambda (j)
                  (map (lambda (k) (list i j k))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 n)))
           (enumerate-interval 1 n)))

;; tests
(triples-fm 3)