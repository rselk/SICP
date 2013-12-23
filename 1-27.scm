;; SCIP 1.27 

(define (square x) 
  (* x x)) 
 
(define (expmod base exp m) 
  (cond ((= exp 0) 1) 
        ((even? exp) 
         (remainder (square (expmod base (/ exp 2) m)) 
                    m)) 
        (else 
         (remainder (* base (expmod base (- exp 1) m)) 
                   m))))         
  
(define (full-fermat-prime? n) 
  (define (it a n) 
    (if (= a n) true 
        (if (= (expmod a n n) a) (it(+ a 1) n) false))) 
  (it 1 n)) 
  
(define (check-fermat x known)
 (report x (full-fermat-prime? x) known))

(define (report x result known)
 (newline)
 (display x)
 (display " Our Calculation: ")
 (display result)
 (display " Known Answer: ")
 (display known))

