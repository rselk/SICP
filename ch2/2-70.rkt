#lang racket

;; Exercise 2.70.  The following eight-symbol alphabet with associated
;; relative frequencies was designed to efficiently encode the lyrics
;; of 1950s rock songs. (Note that the ``symbols'' of an ``alphabet'' 
;; need not be individual letters.)

;; A	2	NA	16
;; BOOM	1	SHA	3
;; GET	2	YIP	9
;; JOB	2	WAH	1
;; Use generate-huffman-tree (exercise 2.69) to generate a corresponding
;; Huffman tree, and use encode (exercise 2.68) to encode the following 
;; message:
;;
;; Get a job
;; Sha na na na na na na na na
;; Get a job
;; Sha na na na na na na na na
;; Wah yip yip yip yip yip yip yip yip yip
;; Sha boom
;;
;; How many bits are required for the encoding? What is the smallest number 
;; of bits that would be needed to encode this song if we used a fixed-
;; length code for the eight-symbol alphabet?


(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge s)
  (if (null? s)
      `()
      (if (null? (cdr s))
          (car s)
          (successive-merge
               (adjoin-set (make-code-tree (car s) (car (cdr s)))
                           (cddr s))))))

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


;; answers
(define 50srock (generate-huffman-tree '((a 2) (boom 1) (Get 2) (job 2) (na 16) (Sha 3)
                               (yip 9) (Wah 1))))

50srock

(define lyrics `(Get a job
          Sha na na na na na na na na    
          Get a job    
          Sha na na na na na na na na    
          Wah yip yip yip yip yip yip yip yip yip    
          Sha boom))
(encode lyrics 50srock)
(length (encode lyrics 50srock))
(length lyrics)
(* 3 36)

;;fixed length = 2^x = 8 (2 because binary is in base 2), 8 is number of letters)
;; since 2^3 = 8
;; we would need 3 bits
;; the length of the lyrics is 36 words
;; 36 words * 3 bits each = 108bits (> 108 (length (encode lyrics 50srock)))

