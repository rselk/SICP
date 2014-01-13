#lang racket

;; Exercise 3.3.  Modify the make-account procedure so that it creates password-protected
;; accounts. That is, make-account should take a symbol as an additional argument

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch p m)
    (if (eq? p password) ;; added this if statement
      (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m)))
      (error "incorrect password")))
  dispatch)

(define acc (make-account 100 `mypw))

((acc `mypw `withdraw) 40)

((acc `wrongpw `deposit) 10)