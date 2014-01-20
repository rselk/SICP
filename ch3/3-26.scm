;; Exercise 3.26.  To search a table as implemented above, one needs to scan through
;; the list of records. This is basically the unordered list representation of section
;; 2.3.3. For large tables, it may be more efficient to structure the table in a
;; different manner. Describe a table implementation where the (key, value) records
;; are organized using a binary tree, assuming that keys can be ordered in some way
;; (e.g., numerically or alphabetically). (Compare exercise 2.66 of chapter 2.)


;; tree structure:
;; [] left right
;; this code is from 2-66
;; new make-table functions

(define (make-table)
  
  (let ((local-table nil))
    
    ;; tree functions from 2-66
    (define (make-tree entry left right)
      (list entry left right))
    
    (define (entry tree)
      (car tree))
    
    (define (left-branch tree)
      (cadr tree))
    
    (define (right-branch tree)
      (caddr tree))
    
    (define (adjoin-set x set) 
      (cond ((null? set) (make-tree x '() '())) 
            ((= (car x) (car (entry set))) set) 
            ((< (car x) (car (entry set))) 
             (make-tree (entry set) 
                        (adjoin-set x (left-branch set)) 
                        (right-branch set))) 
            ((> (car x) (car (entry set))) 
             (make-tree (entry set) 
                        (left-branch set) 
                        (adjoin-set x (right-branch set)))))) 
    
    ;; lookup
    ;; we want to be able to lookup in O (log n) time, this will do that if tree
    ;; is balanced.
    ;; if key > record value then we can look on the left-branch
    ;; if key < record value then we can look on the right-branch
    (define (lookup key record)
      (cond ((null? record) false)
            ((= key (car (entry record))) (entry record))
            ((> key (car (entry record))) (lookup key (left-branch record)))
            ((< key (car (entry record))) (lookup key (right-branch record)))))
    
    ;; the key to the insert is that we call adjoin-set
    (define (insert key value) 
      (let ((record (lookup key local-table))) 
        (if record 
            (set-cdr! record value) 
            (set! local-table (adjoin-set (cons key value) local-table))))) 
    
    ;; just a call to lookup, local-table is the current table.
    (define (get k) (lookup k local-table))
    
    ;; standard function dispatch
    (define (dispatch m)
      (cond ((eq? m `get) get)
            ((eq? m `insert) insert)
            ((eq? m `print) local-table)
            (else (error "error"))))
    
    dispatch))

(define my-table (make-table))
(define get (my-table `get))
(define insert (my-table `insert))
(define print (my-table `print))

(insert 11 `aaaa)
(insert 12 `bbbb)
(insert 13 `cccc)

(my-table `print)
