#lang racket

;(define (fact n)
;  (if (= n 0)
;      1
;      (* n (fact (- n 1)))))


(define (mymin x y)
  (if (< x y)
      x
      y))

(define (inside? x a b) (and (<= a x) (>= b x)))

(define (square x) (* x x))

(define (myfunc x y) (/ (+ (square x) (square y)) 2))

(define (fib prev curr toGo)
  (if (= toGo 0)
      (+ prev curr)
      (fib curr (+ prev curr) (- toGo 1))))


(define (myfib n)
  (if (<= n 1)
      1
      (fib 1 1 (- n 2))))


  