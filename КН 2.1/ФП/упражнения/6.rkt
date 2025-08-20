#lang racket

(define p (cons 1 2))

(car p)
(cdr p)

(define l (list 1 2 3 4 1 1 1 1 1 1 1 1 5))

(car (cdr l))

(define (list-length l)
  (define (helper curList [size 0])
    (if (empty? curList)
        size
        (helper (cdr curList) (+ size 1))
        )
    )
  (helper l)
  )

(list-length l)

(define (checkEl l el)
  (define (helper curList)
    (if (empty? curList)
        #f
        (if (equal? (car curList) el)
            #t
            (helper (cdr curList))
            )
        )
    )
  (helper l)
  )

(checkEl l 4)
(checkEl l 6)

