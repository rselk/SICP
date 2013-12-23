(define (timed-prime-test n times)
 (start-prime-test n (runtime) times))

(define (start-prime-test n start-time times)
 (if (fast-prime? n times)
     (report-prime n (- (runtime) start-time)times)))

(define (report-prime n elapsed-time times)
 (display " *** ")
 (display times)
 (display "\n")
 (display n)
 (display "  ")
 (display elapsed-time)
 (display "\n"))

(define (smallest-divisor n)
 (find-divisor n 2 ))

(define (find-divisor n test-divisor)
 (cond ((> (square test-divisor) n) n)
       ((divides? test-divisor n) test-divisor)
       (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
 (= (remainder b a) 0))

(define (prime? n)
 (= n (smallest-divisor n)))

(define (search-for-primes first last) 
  (define (search-iter cur last) 
     (if (<= cur last) (timed-prime-test cur)) 
     (if (<= cur last) (search-iter (+ cur 2) last)))
     ;;only want odd numbers so we incriment by 2. we know 
     ;;its odd because of below call
   (search-iter (if (even? first) (+ first 1) first)last)) ;;this calls search-iter

(define (fermat-test n)
 (define (try-it a)
  (= (expmod a n n) a))
 (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
 (cond ((= exp 0) 1)
       ((even? exp)
	(remainder (square (expmod base (/ exp 2) m))
	           m))
       (else
	(remainder (* base (expmod base (- exp 1) m))
	           m))))

(define (fast-prime? n times)
 (cond ((= times 0) true)
       ((fermat-test n) (fast-prime? n (- times 1)))
       (else false)))
