;;Recursive implimentation

(define (f x)
  (if (< x 3) 
   x
    (+ (f (- x 1)) 
     (* (f(- x 2)) 2) 
     (* (f (- x 3)) 3))))

;;Iterative implimentation

(define (f2 x)
  (define (it a b c cnt)
    (if (= 0 cnt)
     a
     (it b c (+ c (* 2 b) (* 3 a)) (- cnt 1))))
  (it 0 1 2 x))
