#lang racket

;; Exercise 3.4.  Modify the make-account procedure of exercise 3.3 by adding
;; another local state variable so that, if an account is accessed more than
;; seven consecutive times with an incorrect password, it invokes the procedure
;; call-the-cops.

;; made internal procedures call-the-cops and good-pw
(define (make-account balance password)
  (define counter 0)
  (define max-attempts 7)
  (define (call-the-cops) "Called Police")
  (define (good-pw? p)
    (if (eq? p password)
        (set! counter 0)
        (begin
          (if (= counter max-attempts)
              (call-the-cops)
              (set! counter (+ 1 counter)))
          (display "Incorrect Password")
          false)))
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch p m)
    (if (good-pw? p) ;; added this if statement
      (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m)))
      (lambda (x) (display "")))) ;; dont want to display anything here.
  dispatch)

(define acc (make-account 100 `mypw))
((acc `mypw `withdraw) 40)
((acc `wrongpw `deposit) 10)