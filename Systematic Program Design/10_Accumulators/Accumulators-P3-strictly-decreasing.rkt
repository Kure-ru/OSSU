;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Accumulators-P3-strictly-decreasing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; strictly-decreasing-starter.rkt

; 
; PROBLEM:
; 
; Design a function that consumes a list of numbers and produces true if the 
; numbers in lon are strictly decreasing. You may assume that the list has at 
; least two elements.
; 


;; (listof Number) -> Boolean
;; produce true if list consists of strictly decreasing numbers
(check-expect (strictly-decreasing? (list 1 2 3 4 5)) false)
(check-expect (strictly-decreasing? (list 5 4 3 2 1)) true)
(check-expect (strictly-decreasing? (list 1 1 1 1 1)) false)
(check-expect (strictly-decreasing? (list 1 2 3)) false)
(check-expect (strictly-decreasing? (list 3 2 1)) true)


;(define (strictly-decreasing lon) empty)

(define (strictly-decreasing? lon0)
  (local [(define (strictly-decreasing? lon prev)
            (cond [(empty? lon) true]
                  [else
                   (if (< (first lon) prev)
                            (strictly-decreasing? (rest lon) (first lon))
                            false)]))]
    (strictly-decreasing? (rest lon0) (first lon0))))
