;; SICP 1.17

(define (double x)
 (+ x x))

(define (half x)
 (/ x 2))

(define (* a b)
 (cond ((= b 0) 0)
  ((even? b) (double (* a (half b)))) 
  (else (+ a (* a (- b 1))))))
  

;; (* 3 10)
;; double(* 3 5)
;;       (+3 (* 3 (- 5 1)))
;;           (* 3 4)
;;           double (* 3 2)
;;                  double (* 3 1 )
;;                         (+ 3 ( 3 0))
;;                              (0)
;; =
;; double(+ 3 (double (double (+ 3 0))))
;;                            (3)
;;                    (6)
;;            (12)
;;      (15)
;;(30)
;;
;;check (= (* 3 10) 30)
;;
