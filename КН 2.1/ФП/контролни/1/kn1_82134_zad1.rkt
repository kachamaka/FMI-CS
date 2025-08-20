#lang racket

(define (get-distribution n)
  ;calculate how many times digit is in num
  (define (calcDigits num digit [count 0])
    ;bottom of recursion
    (cond [(= num 0) count]
          ;if digit equals last digit of num
          [(= (remainder num 10) digit) (calcDigits (quotient num 10) digit (+ count 1))]
          ;else skip
          [else (calcDigits (quotient num 10) digit count)]
          )
    )
  ;helper to iterate digits from 0 to 9
  (define (helper num [iter 0] [res '()])
    (cond [(> iter 9) res]
          ;using let to define cnt
          [else (let ([cnt (calcDigits num iter)])
                  (if (= cnt 0)
                      ;skip if cnt = 0
                      (helper num (+ iter 1) res)
                      ;add pair
                      (helper num (+ iter 1) (append res (list (cons iter cnt))))
                      )
                  )]
          )
    )
  ;catch corner case
  (if (= n 0)
      (list (cons 0 1))
      (helper (* n n))
      )
  )

(get-distribution 123)
(get-distribution 243)
(get-distribution 5489)
(get-distribution 9999)
(get-distribution 0)
(get-distribution 4)