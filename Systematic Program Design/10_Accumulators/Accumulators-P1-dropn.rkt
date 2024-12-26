;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Accumulators-P1-dropn) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; dropn-starter.rkt

; 
; PROBLEM:
; 
; Design a function that consumes a list of elements lox and a natural number
; n and produces the list formed by dropping every nth element from lox.
; 
; (dropn (list 1 2 3 4 5 6 7) 2) should produce (list 1 2 4 5 7)
; 


;; (listof X) Natural -> (listof X)
;; produce a list formed by dropping every nth element from lox
(check-expect (dropn empty 0) empty)
(check-expect (dropn (list "a" "b" "c" "d" "e" "f") 0) empty)
(check-expect (dropn (list "a" "b" "c" "d" "e" "f") 1) (list "a" "c" "e"))
(check-expect (dropn (list "a" "b" "c" "d" "e" "f") 2) (list "a" "b" "d" "e"))


;(define (dropn lox n) empty)

;; templated according to (listof X) and accumulator
(define (dropn lox0 n)
  (local [(define (dropn lox acc)
            (cond [(empty? lox) empty]
                  [else
                   (if (zero? acc)
                       (dropn (rest lox) n)
                       (cons (first lox)
                             (dropn (rest lox)
                                    (sub1 acc))))]))]
    (dropn lox0 n)))