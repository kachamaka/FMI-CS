#lang racket

(define (trailing-zeros n)
  ;calculate zeros from the formula
  ;start with first el and divide by 5 every time
  (define (calcZeros [el (/ n 5)] [res 0])
    ;check if el is < 1 (if denominator is less than nominator)
    (if (< el 1)
        res
        ;divide by 5 and add to res
        (calcZeros (/ el 5) (+ res (floor el)))
        )
    )
  (λ (p)
    (p (calcZeros))
    )
  )

((trailing-zeros 0) even?)
((trailing-zeros 4) even?)
((trailing-zeros 5) even?)
((trailing-zeros 6) even?)
((trailing-zeros 1000) even?)
((trailing-zeros 100000) even?)
((trailing-zeros 1000000000) even?)