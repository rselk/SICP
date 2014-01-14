#lang racket

;; Exercise 3.7.  Consider the bank account objects created by make-account, with
;; the password modification described in exercise 3.3. Suppose that our banking
;; system requires the ability to make joint accounts. Define a procedure make-joint
;; that accomplishes this. Make-joint should take three arguments. The first is a
;; password-protected account. The second argument must match the password with which
;; the account was defined in order for the make-joint operation to proceed. The
;; third argument is a new password. Make-joint is to create an additional access to
;; the original account using the new password.

;; function (unchanged) from 3-4
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

;;new make-joint function
;; current-pw the password of the account we want to join to
;; joint-pw the new password we want for this joint account
;; once we create the account, we will not have to remember
;; the account-pw of the original account
(define (make-joint account current-pw joint-pw)
  ;;dispatch based on password and procedure (withdraw or deposit)
  (define (dispatch pw proc)
    (cond ((not (eq? pw joint-pw)) (error "wrong password"))
          ((eq? proc `withdraw) (account current-pw `withdraw))
          ((eq? proc `deposit) (account current-pw `deposit))
          (else (error "unknown" proc))))
  dispatch)

;; tests

(define ryan-acc (make-account 100000 `mypassword))
(define joint-acc (make-joint ryan-acc `mypassword `newjointpw))
                
((ryan-acc `mypassword `withdraw) 1000) ;; 99000
((joint-acc `newjointpw `withdraw) 2000) ;; 97000

