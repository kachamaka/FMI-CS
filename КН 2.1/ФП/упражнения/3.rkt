#lang racket

(define (natural-divisors n)
  (define (helper-iterator [num 2] [count 1])
    (if (>= num n)
        count
        (if (= (remainder n num) 0)
            (helper-iterator (+ num 1) (+ count 1))
            (helper-iterator (+ num 1) count)
            )
        )
    )
  (helper-iterator)
  )

(define (perfect-number? n)
  (define (helper-iterator-sum [num 2] [sum 1])
    (if (>= num n)
        sum
        (if (= (remainder n num) 0)
            (helper-iterator-sum (+ num 1) (+ sum num))
            (helper-iterator-sum (+ num 1) sum)
            )
        )
    )
  (= (helper-iterator-sum) n)
  )

(define (inc-digits? n)
  (define (helper-iterate-digits [num (floor (/ n 10))] [last (remainder n 10)])
    (if (= num 0)
        #t
        (if (>= last (remainder num 10))
            (helper-iterate-digits (floor (/ num 10)) (remainder num 10))
            #f)
        )
    )
  (helper-iterate-digits)
  )

(define (calc-sum-expt x n)
  (define (helper-iterator [exp 0] [sum 0])
    (if (> exp n)
        sum
        (helper-iterator (+ exp 1) (+ sum (expt x exp)))
        )
    )
  (helper-iterator)
  )


    
    
    
    
     