#lang racket
;; Exercise 3.22.  Instead of representing a queue as a pair of pointers, we can build
;; a queue as a procedure with local state. The local state will consist of pointers
;; to the beginning and the end of an ordinary list. Thus, the make-queue procedure
;; will have the form

;;(define (make-queue)
;;  (let ((front-ptr ...)
;;        (rear-ptr ...))
;;    <definitions of internal procedures>
;;    (define (dispatch m) ...)
;;    dispatch))

;; Complete the definition of make-queue and provide implementations of the queue
;; operations using this representation.
(require scheme/mpair)

(define (make-queue)
  (let ((front-ptr (mcons mcons mcons))
        (rear-ptr (mcons mcons mcons)))
    
    (define (get-front-ptr)
      (display front-ptr))
    
    (define (queue-null?)
      (null? front-ptr))
    
    ;; push the queue
    (define (push val)
      (let ((new-pair (mcons val `())))
        (cond ((queue-null?)
               ;; queue is null
               (set! front-ptr val)
               (set! rear-ptr val))
              (else
               (set-mcdr! rear-ptr val)
               (set! rear-ptr new-pair)))))

    ;; pop the queue
    (define (pop)
             (cond ((queue-null?)
              (error "cannot pop empty queue"))
              (else (set! front-ptr (mcdr front-ptr)))))
    
    ;; dispatch
    (define (dispatch m)
      (cond ((eq? m `push) push)
            ((eq? m `pop) (pop))
            ((eq? m `queue-null?) queue-null?)
            ((eq? m `get-front-ptr) get-front-ptr)
            (else (error "dispatch unknown"))))
    
    dispatch))

;; queue operations
(define myqueue (make-queue))
((myqueue `push) 2)
((myqueue `push) 3)
((myqueue `push) 5)
(myqueue `pop)
