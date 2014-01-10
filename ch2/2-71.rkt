#lang racket

;; Exercise 2.71.  Suppose we have a Huffman tree for an alphabet of
;; n symbols, and that the relative frequencies of the symbols are
;; 1, 2, 4, ..., 2n-1. Sketch the tree for n=5; for n=10. In such
;; a tree (for general n) how many bits are required to encode the
;; most frequent symbol? the least frequent symbol?

;; tree would look like this for n=5

;;  (sym1 sym2 sym3 sym4 sym5)
;;     |             |
;;  (sym5)          (sym1 sym2 sym3 sym4)
;;                   |               |
;;                   (sym4)         (sym1 sym2 sym3)
;;                                   |            |
;;                                   (sym3)       (sym1 sym2)
;;                                                |       |
;;                                                (sym2)  (sym1)

;; most frequent symbol (in this case sym5) will be able to use a single bit.
;; this is because the 2nd biggest symbol will always have to be on the other side
;; of the tree
;; (n-1) will get to the symbol using the most bits (the least frequent symbol)