#lang racket

;; this is the code for put/get. I found this code online, the book assumes we have
;; put/get in this section but in my enviroment I do not. In section 3.3.3 the book 
;; has its own implimentation similar to below:

(require rnrs/base-6)
(require rnrs/mutable-pairs-6)

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(define (attach-tag type-tag contents)
  (cons type-tag contents))

;; primative operations
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag `scheme-number x))
  (put 'add `(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put `sub `(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put `mul `(scheme-number scheme-number)
       (lambda (x y) (tag * x y)))
  (put `div `(scheme-number scheme -number)
       (lambda (x y) (tag (/ x y))))
  (put `make `scheme-number
       (lambda (x) (tag x)))
  `done)
  
;;this is how we will use the primatives
(define (make-scheme-number n)
  ((get `make `scheme-number) n))

;; rational arithmetic

(define (install-rational-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (numer y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  
  (define (tag x) (attach-tag `rational x))
  (put `add `(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put `sub `(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put `mul `(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put `div `(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  
  (put `make `rational
       (lambda (n d) (tag (make-rat n d))))
  `done)
                 
(define (make-rational n d)
  ((get `make `rational) n d))

;; complex number package

(define (install-complex-package)
  (define (make-from-real-imag x y)
    ((get `make-from-real-imag `rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get `make-from-mag-ang `polar) r a))
  ;internal
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (image-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-real-image (* (magnitude z1) (magnitude z2))
                          (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  ;; interface
  (define (tag z) (attach-tag `complex z))
  (put `add `(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put `sub `(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put `mul `(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put `div `(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put `make-from-real-imag `complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put `make-from-mag-ang `complex
       (lambda (x y) (tag (make-from-mag-ang r a))))
  
  ;;from 2.77
  (put `real-part `(complex) real-part)
  (put `image-part `(complex) image-part)
  (put `magnitude `(complex) magnitude)
  (put `angle `(complex) angle)
  
  `done)

;;outsice access
(define (make-complex-from-real-imag x y)
  ((get `make-from-real-imag `complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get `make-from-mag-ang `complex) r a))


;; 2.77 answer

;; Without the code there was no magnitude/real-part/image-part/angle functions
;; availible to be called. Apply generic is called twice as 
;; - gets called during calling rectangular/polar
;; - gets called during calling of complex


       