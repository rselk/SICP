#lang racket

;; Exercise 2.78.  The internal procedures in the scheme-number package are essentially
;; nothing more than calls to the primitive procedures +, -, etc. It was not possible
;; to use the primitives of the language directly because our type-tag system requires 
;; that each data object have a type attached to it. In fact, however, all Lisp
;; implementations do have a type system, which they use internally. Primitive predicates
;; such as symbol? and number? determine whether data objects have particular types.
;; Modify the definitions of type-tag, contents, and attach-tag from section 2.4.2 so
;; that our generic system takes advantage of Scheme's internal type system. That is to
;; say, the system should work as before except that ordinary numbers should be
;; represented simply as Scheme numbers rather than as pairs whose car is the symbol
;; scheme-number.

;; we have

;;(define (attach-tag type-tag contents)
;;  (cons type-tag contents))
;;(define (type-tag datum)
;;  (if (pair? datum)
;;      (car datum)
;;      (error "Bad tagged datum -- TYPE-TAG" datum)))
;;(define (contents datum)
;;  (if (pair? datum)
;;      (cdr datum)
;;      (error "Bad tagged datum -- CONTENTS" datum)))

;; new methods

(define (attach-tag type-tag content)
  (if (number? content) 
      content
      (if (pair? content)
          (cons tag conent) 0)))

(define (type-tag datum)
  (if (number? datum) 
      datum
      (if (pair? datum)
          (car datum)
          (error "wrong datum" datum))))

(define (contents datum)
  (if (number? datum)
      datum
      (if (pair? datum)
          (cadr datum)
          (error "wrong datum"))))
  
  
                         