;; SICP EX 1.3
  
(define 
  (largest-2-square-and-sum x y z)
    (if (= x (larger x y))
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
    
    
