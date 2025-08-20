#lang racket


(define (my-identity x) x)


(define (my-compose f g)
  (lambda (x)
    (f (g x))))

(define (f1 x) (+ x 1))
(define (g1 x) (* x 2))
((my-compose f1 g1) 5)

(define (my-negate p)
  (λ (x) (not (p x))))

((my-negate f1) 0)

(define (my-curry f x)
  (λ (y z) (f x y z)))

(define (f3 a b c)
  (+ a (* b c)))

(define f3-10
  (my-curry f3 10))

;(f3-10 12 15)

((my-curry f3 10) 12 15)


(define (difference F a b)
  (- (F b) (F a)))

(difference g1 3 5)


(define (f x) (* 2 x))

(define (fEquiv)
  (λ (x)
    (* 2 x)))
((fEquiv) 5)



(define (derive f eps)
  (λ (x)
    (/ (difference f x (+ x eps)) eps)))

(define (ex x)
  (expt x 4))

((derive (λ (x) (* 4 x x)) 1e-3) 1)

((derive (λ (x) (* 4 x x)) 1e-3) 
((derive (λ (x) (* 4 x x)) 1e-3) 1))

(define (derive2 f eps)
  (λ (x)
    ((derive (derive f eps) eps) x)))


((derive2 (λ (x) (* 4 x x)) 1e-3) 2)

(define (derive-n f n eps)
  (cond
    [(< 0 n) (derive-n (derive f eps) (- n 1) eps)]
    [(= 0 n) f]
    [(> 0 n) (error "Cannot differentiate negative number of times without extra information of the function f" f )]))

((derive-n (λ (x) (* 4 x x)) 1 1e-2) 2)
