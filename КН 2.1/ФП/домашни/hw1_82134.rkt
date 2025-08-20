#lang racket

(define (sum-counts-iter x d)
  ;define helper function to get sum of digits with default value of digitSum = 0 for convenience
  (define (sum-digits n [digitSum 0])
    (if (= n 0)
        digitSum
        ;if n!=0 call sum-digits with one less digit and add remainder to result
        (sum-digits (quotient n 10) (+ digitSum (remainder n 10)))))
  ;define helper function to count all digits matching d and store result in sum
  (define (count-digit num [sum 0])
    (if (= num 0)
        sum
        (if (= d (remainder num 10))
            (count-digit (quotient num 10) (+ sum 1))
            (count-digit (quotient num 10) sum))))
  ;define helper function to go from 1 to n and examine each number in the range
  (define (helper-iterator [currNum 1] [count 0])
    (if (> currNum x)
        count
        ;if currNum is in range increment and use helper functions to add result to count argument
        (helper-iterator (+ currNum 1) (+ count (count-digit currNum)))
        )
    )
  (sum-digits (helper-iterator)))

(define (add-ones n)
  ;define helper to examine number and change it by removing last digit and examining it
  ;using multiplier argument to add to result with appropriate shifting
  (define (helper-merge-numbers num [multiplier 0] [result 0])
    (if (= num 0)
        result
        ;if last digit + 1 is double digit increment multiplier with 2 else with 1 
        (if (= (quotient (+ (remainder num 10) 1) 10) 0)
            (helper-merge-numbers (quotient num 10) (+ multiplier 1) (+ result (* (+ (remainder num 10) 1) (expt 10 multiplier))))
            (helper-merge-numbers (quotient num 10) (+ multiplier 2) (+ result (* (+ (remainder num 10) 1) (expt 10 multiplier)))))))
  ;check for n = 0 corner case in this specific implementation
  (if (= n 0)
      1
      (helper-merge-numbers n)))