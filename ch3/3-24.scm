;; Lang - MIT Scheme*

;; Exercise 3.24.  In the table implementations above, the keys are tested for equality
;; using equal? (called by assoc). This is not always the appropriate test. For instance
;; we might have a table with numeric keys in which we don't need an exact match to
;; the number we're looking up, but only a number within some tolerance of it. Design
;; a table constructor make-table that takes as an argument a same-key? procedure that
;; will be used to test ``equality'' of keys. Make-table should return a dispatch procedure
;; that can be used to access appropriate lookup and insert! procedures for a local table.

;; * - switched back to MIT scheme for this. Racket handles mutable lists
;; quite a bit differently and by switching here it avoids me having to re-write
;; many of the given functions

;; All we have to do here is add another parameter for make-table to take (same-key?)
;; Instead of using equal to test for equality, we can now pass in a function to decide
;; if the table keys are equal.

;; Added same-key?
(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    
    (define (lookup key-1 key-2 table)
      (let ((subtable (assoc key-1 (cdr table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  false))
            false)))
    
    (define (assoc key records)
      (cond ((null? records) false)
            ;; substitute equal? for same-key?
        ((same-key? key (caar records)) (car records))
        (else (assoc key (cdr records)))))
    
    (define (insert! key-1 key-2 value table)
      (let ((subtable (assoc key-1 (cdr table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr table)))))
      'ok)
    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define my-table (make-table equal?))