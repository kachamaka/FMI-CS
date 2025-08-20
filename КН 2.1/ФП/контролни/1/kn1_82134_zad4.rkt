#lang racket

(define (persistence n)
  ;calculate product of digits in num
  ;res = 1 because of multiplication
  (define (calcDigitsProduct num [res 1])
    ;bottom (because of quotient)
    (if (= num 0)
        res
        ;multiply by res
        (calcDigitsProduct (quotient num 10) (* res (remainder num 10)))
        )
    )
  ;get list of recursive product of digits
  (define (getProductList num [res '()])
    ;if only one digit
    (if (< num 10)
        res
        ;use let to define newNum
        (let ([newNum (calcDigitsProduct num)])
          ;add newNum to res
          (getProductList newNum (append res (list newNum)))
          )
        )
    )

  ;catch corner case of n being only 1 digit
  (if (< n 10)
      (cons (list n) 1)
      (let ([ys (getProductList n)])
        (cons ys (length ys))
        )
      )
  )

(equal? (persistence 39) (cons '(27 14 4) 3))
(equal? (persistence 126) (cons '(12 2) 2))
(equal? (persistence 4) (cons '(4) 1))
(equal? (persistence 999) (cons '(729 126 12 2) 4))

;some more tests
(equal? (persistence 0) (cons '(0) 1))
(equal? (persistence 2134) (cons '(24 8) 2))
(equal? (persistence 324234) (cons '(576 210 0) 3))
(equal? (persistence 99399299) (cons '(3188646 27648 2688 768 336 54 20 0) 8))