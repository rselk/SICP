#lang racket

;;(define (partial-tree elts n)
;;  (if (= n 0)
;;      (cons '() elts)
;;      (let ((left-size (quotient (- n 1) 2)))
;;        (let ((left-result (partial-tree elts left-size)))
;;          (let ((left-tree (car left-result))
;;                (non-left-elts (cdr left-result))
;;                (right-size (- n (+ left-size 1))))
;;            (let ((this-entry (car non-left-elts))
;;                  (right-result (partial-tree (cdr non-left-elts)
;;                                              right-size)))
;;              (let ((right-tree (car right-result))
;;                    (remaining-elts (cdr right-result)))
;;                (cons (make-tree this-entry left-tree right-tree)
;;                      remaining-elts))))))))

;; a. Write a short paragraph explaining as clearly as you can how partial-tree works. Draw
;; the tree produced by list->tree for the list (1 3 5 7 9 11).

;; partial-tree breaks down elts into 3 components. the middle (this-entry), the left-tree and right-tree
;; the middle is determined from the first element which is not in the left tree.
;; these calls are make recursivly so we are constantly making new partial-roots and partial trees.

;; b. What is the order of growth in the number of steps required by list->tree to convert a list of n
;; elements?

;; the order of grown is linear. (O (n)) 
;; splitting the list and combinding the tree (make-tree) are constant time
;; the order is determined by partial tree which visits each element in elts 1x.
;; since we are visiting each element 1x, the order is O (n)