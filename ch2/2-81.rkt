#lang racket

;; a. With Louis's coercion procedures installed, what happens if apply-generic is
;; called with two arguments of type scheme-number or two arguments of type complex
;; for an operation that is not found in the table for those types? For example,
;; assume that we've defined a generic exponentiation operation:

;; A) This will loop forever and not end. 

;; b. Is Louis correct that something had to be done about coercion with arguments
;; of the same type, or does apply-generic work correctly as is?

;; B) Nothing is wrong with the code that I can see. Apply-generic should work.


;; c. Modify apply-generic so that it doesn't try coercion if the two arguments
;; have the same type.

;; Original Apply-generic
;;(define (apply-generic op . args)
;;  (let ((type-tags (map type-tag args)))
;;    (let ((proc (get op type-tags)))
;;      (if proc
;;          (apply proc (map contents args))
;;          (if (= (length args) 2)
;;              (let ((type1 (car type-tags))
;;                    (type2 (cadr type-tags))
;;                    (a1 (car args))
;;                    (a2 (cadr args)))
;;                (let ((t1->t2 (get-coercion type1 type2))
;;                      (t2->t1 (get-coercion type2 type1)))
;;                  (cond (t1->t2
;;                         (apply-generic op (t1->t2 a1) a2))
;;                        (t2->t1
;;                         (apply-generic op a1 (t2->t1 a2)))
;;                        (else
;;                         (error "No method for these types"
;;                                (list op type-tags))))))
;;              (error "No method for these types"
;;                     (list op type-tags)))))))

;; modified apply generic

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                ;;below is the change, check to see if types are equal.
                ;;if they are equal we can return an error 
                (if (equal? type1 type2)
                    (error "no method" type1)
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                             (apply-generic op (t1->t2 a1) a2))
                            (t2->t1
                             (apply-generic op a1 (t2->t1 a2)))
                            (else
                             (error "No method for these types"
                                    (list op type-tags)))))
                    (error "No method for these types"
                           (list op type-tags)))))))))