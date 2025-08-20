#lang racket

;(remainder 10 3) -> 1

(define (gcd a b)
  (cond
    [(= a b) a]
    [(> a b) (gcd (- a b) b)]
    [else (gcd a (- b a))]))


(define (mymaxdivisor x)
  (define (iteratedivisors d)
          (if (= (remainder x d) 0)
              d
              (iteratedivisors (- d 1))))
  (if (= x 1)
      x
      (iteratedivisors (- x 1))))

;(mymaxdivisor 53)

(define (sum-odds a b)
  (define (iterator i sum)
    (if (and (>= i a) (<= i b))
        (if (not (= (remainder i 2) 0))
            (iterator (+ i 1) (+ sum i))
            (iterator (+ i 1) sum))
        sum))
  (iterator a 0))

;(sum-odds 0 10)

(define (prime? n)
  (define upper (floor (sqrt n)))
  (define (iterator i)
    (if (> i upper)
        #t
        (if (= (remainder n i) 0)
            #f
            (iterator (+ i 1)))))
  (iterator 2))

;(prime? 19)


(define (reverse n)
  (define (numlen num len)
    (if (= num 0)
        len
        (numlen (quotient num 10) (+ len 1))))

  (define len (numlen n 0))
  (define (iterator i num rev)
    (if (>= i 0)
        (iterator (- i 1) (quotient num 10)  (+ rev (* (remainder num 10) (expt 10 i))))
        (/ rev 10)))
  (iterator len n 0))

;better reverse function
;(define (numlen num len)
;    (if (= num 0)
;        len
;        (numlen (quotient num 10) (+ len 1))))
;(define (revs n)
;  (if (< n 10)
;      n
;      (+ (* (remainder n 10) (expt 10 (- (numlen n 0) 1)))
;         (revs (quotient n 10)))))
 

(define (count-palindromes a b)
 (define (palindrome? n)
   (if (= n (reverse n))
       #t
       #f))
  
  (define (iterator i count)
   (if (and (>= i a) (<= i b))
        (if (palindrome? i)
            (iterator (+ i 1) (+ count 1))
            (iterator (+ i 1) count))
        count))
  (iterator a 0))



(define (count-divisors n)
  (define (iterator i count)
    (if (< i 1)
        count
        (if (= (remainder n i) 0)
            (iterator (- i 1) (+ count 1))
            (iterator (- i 1) count))))
  (iterator n 0))
            