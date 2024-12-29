;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Accumulators-P4-average) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; average-starter.rkt

; 
; PROBLEM:
; 
; Design a function called average that consumes (listof Number) and produces the
; average of the numbers in the list.
; 


;; (listof Number) -> Number
;; produce average of all elements of lon
(check-expect (average (list 1 2 3)) 2)
(check-expect (average (list 14 8 17 20 5 12)) 13)

(define (average lon0)
  (local [(define (average lon acc n)
            (cond [(empty? lon) (round (/ acc n))]
                  [else (average (rest lon)
                                 (+ acc (first lon)) (add1 n))]))]
    (average lon0 0 0)))