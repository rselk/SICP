(define (Ackermann x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
	((= y 1) 2)
	(else (Ackermann (- x 1) (Ackermann x (- y 1))))))

(define (f n)
    (Ackermann 0 n))
;; 2, 4, 6, 8 .... n = 2n

(define (g n)
  (Ackermann 1 n))
;; 1, 2, 4, 8, 16, 32, 64 ..... 2^n

(define (h n)
  (Ackermann 2 n))
;; 0, 2, 4, 16, 65536 .... 2^2^2^2...n times

