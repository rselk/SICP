;;scip 1-16

(define (sqr b n)
  (iter-square 1 b n))

(define (iter-square a b n)
  (cond((= n 0) a)
  ((even? n) 
    (iter-square a (* b b) (/ n 2)))
  (else 
    (iter-square (* a b) b (- n 1)))))

(define (even? n)
  (= (remainder n 2) 0))
