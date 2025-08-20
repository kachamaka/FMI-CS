#lang racket

(define (get-missing-length xss)
  ;get list of all lengths sorted
  (define (getListLengths lsts [res '()])
    (cond [(empty? lsts) (sort res <)]
          ;if any list is empty
          [(empty? (car lsts)) (error "Empty list!")]
          ;add length to res
          [else (getListLengths (cdr lsts) (append res (list (length (car lsts)))))]
          )
    )
  ;iterate list of lengths
  (define (findMissing lst)
    (define first (car lst))
    (define second (cadr lst))
    ;check difference between two neighbours
    (if (= (- second first) 1)
        ;skip
        (findMissing (cdr lst))
        ;return missing
        (+ first 1)
        )
    )
  (if (empty? xss)
      (error "Empty list!")
      (findMissing (getListLengths xss))
      )
  )

;(get-missing-length '((1 2) (4 5 1 1) (1) (5 6 7 8 9)))
;(get-missing-length '(("a", "a", "a") ("a", "a") ("a", "a", "a",
;"a") ("a") ("a", "a", "a", "a", "a", "a")))

(define l '('() (4 5 1 1) (1) (5 6 7 8 9)))
(empty? (car l))