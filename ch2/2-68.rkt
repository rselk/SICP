#lang racket

;; Exercise 2.68.  The encode procedure takes as arguments a message
;; and a tree and produces the list of bits that gives the encoded message.

(define (encode-sym sym tree)
  ;; check to see if in tree at all
  (cond ((not (memq sym (symbols tree))) (error "not in tree"))
        ((leaf? tree) null) ;;this will be the end of the list.
        ;; if its in left branch we get a 0 + next "move"
        ((memq sym (symbols (left-branch tree)))
         (cons 0 (encode-sym sym (left-branch tree))))
        ;; if its in right branch we get a 1 + next "move"
        ((memq sym (symbols (right-branch tree)))
         (cons 1 (encode-sym sym (right-branch tree))))))
        
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-sym (car message) tree)
              (encode (cdr message) tree))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        `()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

;; huffman tree
(define (make-leaf symbol weight)
  (list `lead symbol weight))

(define (leaf? object)
  (eq? (car object) `lead))

(define (symbol-leaf x)
  (cadr x))

(define (weight-leaf x)
  (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))



(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))


(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      `()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) ;; sym
                               (cadr pair)) ;; freq
                    (make-leaf-set (cdr pairs))))))


(define sample-tree
  (make-code-tree (make-leaf `A 4)
                  (make-code-tree
                   (make-leaf `B 2)
                   (make-code-tree (make-leaf `D 1)
                                   (make-leaf `C 1)))))

;; encode / decode message
(define sample-message `(0 1 1 0 0 1 0 1 0 1 1 1 0))                              
(decode sample-message sample-tree)
(encode '(A D A B B C A) sample-tree)










