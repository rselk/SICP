#lang racket

;; This is the 8-queens problem

;; needed functions from earlier
(define (accumulate op initial sequence) 
   (if (null? sequence) 
       initial 
       (op (car sequence) 
           (accumulate op initial (cdr sequence))))) 
 
(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))
 
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

;; queens function
(define (queens board-size)
  (define (queen-cols k)  
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

;; define a null board
(define empty-board null)

;; representation for storage and creation of queen

(define (make-pos row col)
  (cons row col))

(define (position-row pos)
  (car pos))

(define (position-col pos)
  (cdr pos)) 

;; functions to interact with given queens procedure
(define (adjoin-position r c pos)
  (append pos (list (make-pos r c))))

(define (safe? col positions)
  ;; rest-queens is the locations of the queens which are not in the kth column
  (let ((rest-queens (filter (lambda (q)
                                (not (= col (position-col q))))
                              positions)))
    ;; this iterates through the board and checks to see if the position has no conflict
    (define (safe-iter q board)
      ;; check if board is null (will get here because we are cdring down board)
      (or (null? board)
          (and (not (check-if-checkmate q (car board)))
               (safe-iter q (cdr board)))))
    ;; call safe iter with nth queen and rest of queens
    (safe-iter (list-ref positions (- col 1)) rest-queens)))
    

;; check if q1 and q2 are "in checkmate"
(define (check-if-checkmate q1 q2)
      ;; check if in same row
      (or (= (position-row q1) (position-row q2))
          ;;check if on diagonal
          (= (abs (- (position-row q1) (position-row q2)))
             (abs (- (position-col q1) (position-col q2))))))


;; test
(queens 8)