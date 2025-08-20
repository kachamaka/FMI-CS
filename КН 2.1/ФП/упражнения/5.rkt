#lang racket

(define (repeated f n)
  (if (= n 1)
      f
      (λ (x) (f ((repeated f (- n 1)) x)))
      )
  )

((repeated (λ (x) (* 2 x)) 8) 1)


(define (derive-x f eps)
  (λ (x y) (/ (- (f (+ x eps) y) (f x y)) eps)))


(define (derive-y f eps)
  (λ (x y) (/ (- (f x (+ y eps)) (f x y)) eps)))
  
((derive-x (λ (x y) (+ (* 4 x x) (* 2 x y))) 1e-3) 2 5)
((derive-y (λ (x y) (+ (* 4 x x) (* 2 x y))) 1e-3) 2 5)

(define (newton-sqrt n)
  (define (helper res [iter 10])
    (if (= iter 0)
        (exact->inexact res)
        (helper (/ (+ res (/ n res)) 2) (- iter 1))
        )
    )
  (helper 1)
  )
  
(newton-sqrt 612)

(define (sum-digit-divisors n)
  (define (helper x [res 0])
    (define d (remainder x 10))
    (if (= x 0)
        res
        (if (< d 0)
            (helper (quotient x 10) res)
            (helper (quotient x 10) (+ res d))
            )
        )
    )
  (helper n)
  )

(sum-digit-divisors 1222)
(sum-digit-divisors 1202)
(sum-digit-divisors 2321)

