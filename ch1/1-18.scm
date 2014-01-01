(define (double x)
 (+ x x))

(define (half x)
 (/ x 2))

;; similar to 1.16 but uses s to make it iterative
;; need to call it from another funciton to avoid passing extra s param
  
(define (* a b)
 (multiter 0 a b))

 (define (multiter s a b)
  (cond ((= b 0) s)
   ((even? b) (multiter s (double a) (half b)))
   (else (multiter (+ s a) a (- b 1)))))
