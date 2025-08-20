#lang racket

(define (itinerary flights)
  ;function to get the best matching pair according to string conditions
  (define (getBestPair start lst [pair '()])
    (if (empty? lst)
        pair
        ;if element we are expecting is a match
        (if (equal? start (car (car lst)))
            (cond
              ;case for getting first pair
              [(empty? pair) (getBestPair start (cdr lst) (car lst))]
              ;best pair condition
              [(string<? (cdr (car lst)) (cdr pair)) (getBestPair start (cdr lst) (car lst))]
              ;else skip pair
              [else (getBestPair start (cdr lst) pair)])
            ;skip pair
            (getBestPair start (cdr lst) pair))
        )
    )
  ;get list of all possible best pairs
  (define (getBestPairs start lst [res '()])
    (define pair (getBestPair start lst))
    (if (empty? pair)
        res
        (getBestPairs start (remove pair lst) (append res (list pair)))
        )
    )
  ;inspect all possible routes according to best pairs
  (define (getBestRoute start inspectList pairs [res '()])
    ;if no elements to inspect
    (if (empty? inspectList)
        ;add start because path gets appended before calling function for next pair to examine
        (append res (list start))
        (let ()
          ;if there are no pairs to inspect and inspect list is not empty
          (if (empty? pairs)
              ;no such path
              #f
              (let ()
                (define pair (car pairs))
                (define newList (remove pair inspectList))
                (define newStart (cdr pair))
                ;get rest of the path with new arguments and updated result
                (define newRes (getBestRoute newStart newList (getBestPairs newStart newList) (append res (list (car pair)))))
                ;catch the false state
                (if (eq? newRes #f)
                    ;revert old arguments and remove inspected pair
                    (getBestRoute start inspectList (remove pair pairs) res)
                    ;return new result
                    newRes
                    )
                )
              )
          )
        )
    )
        
  (λ (start)
    (if (empty? (getBestPair start flights))        
        ;if there is no best pair        
        (error "No such itinerary!")
        (let ()
          (define pairs (getBestPairs start flights))
          (define route (getBestRoute start flights pairs))
          (if (eq? route #f)
              (error "No such itinerary!")
              route
              )
          )
        )
    )
  )
;((itinerary '(("A" . "C") ("C" . "A") ("A" . "B"))) "A")
(equal? ((itinerary '(("A" . "C") ("C" . "A") ("A" . "B"))) "A") '("A" "C" "A" "B"))
(equal? ((itinerary '(("G" . "E") ("E" . "F") ("A" . "G") ("D" . "E") ("B" . "C") ("E" . "C") ("A" . "B") ("C" . "D") ("F" . "A") ("C" . "A"))) "A")
        '("A" "B" "C" "A" "G" "E" "C" "D" "E" "F" "A"))
(equal? ((itinerary '(("SFO" . "HKO") ("YYZ" . "SFO") ("YUL" . "YYZ") ("HKO" . "ORD"))) "YUL") '("YUL" "YYZ" "SFO" "HKO" "ORD"))

;this line has to throw error
;((itinerary '(("SFO" . "COM") ("COM" . "YYZ"))) "COM")


(define (pad xs)
  ;add num on left and right side
  (define (extendRow row num)
    (append (list num) row (list num)))
  ;get num of rows
  (define rows (length xs))
  ;get new row size after extension
  (define newRowSize (+ (length (car xs)) 2))
  ;generate row with only num
  (define (generateEmptyRow num [iter newRowSize] [res '()])
    (if (= iter 0)
        (list res)
        (generateEmptyRow num (- iter 1) (append res (list num)))
        )
    )
  ;extend all rows
  (define (extendRows currList num [iter rows] [res '()])
    (if (= iter 0)
        res
        (extendRows (cdr currList) num (- iter 1) (append res (list (extendRow (car currList) num))))
        )
    )
        
  (λ (x)
    ;combine empty rows and extended rows
    (append (generateEmptyRow x) (extendRows xs x) (generateEmptyRow x))
  ))


;(equal? ((pad '((1 2 3) (4 5 6) (7 8 9))) 0) '((0 0 0 0 0) (0 1 2 3 0) (0 4 5 6 0) (0 7 8 9 0) (0 0 0 0 0) ) )
;(equal? ((pad '((1 2 3) (4 5 6) (7 8 9))) -1) '((-1 -1 -1 -1 -1) (-1 1 2 3 -1) (-1 4 5 6 -1) (-1 7 8 9 -1) (-1 -1 -1 -1 -1) ) )

