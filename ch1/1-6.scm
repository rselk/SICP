(define (new-if pred then-c else-c)
  (cond (pred then-c)
  (else else-c)))
 
(define 
  (largest-2-square-and-sum x y z)
    (new-if (= x (larger x y))
     (sum-of-squares x (larger y z ))
     (sum-of-squares y (larger x z ))
   )
)

(define 
  (larger x y)
    (if (> x y) x y)
)

(define 
  (sum-of-squares a b)
    (+ (* a a) (* b b))
)
    
    
