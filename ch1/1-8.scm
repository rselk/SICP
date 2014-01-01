(define (cubedroot x)
  (cubed-iter 1.0 x))

(define (cubed-iter guess x)
  (if (good-enough guess x)
    guess
    (cubed-iter (improve guess x)
     x)))

(define (improved guess x)
  (/(+(/ x (square guess)) guess guess) 3))

(define (square x)
 (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough guess x)
  (< (abs (- (improved guess x ) guess)) 
    (* guess .001)))
