;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Naturals-P1-sum-to-n) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; sum-to-n-starter.rkt

;   PROBLEM:
;   
;   Design a function that produces the sum of all the naturals from 0 to a given n. 
;   


;; Natural -> Natural
;; produce sum of all the naturals from 0 to n
(check-expect (sum 0) 0)
(check-expect (sum 1) (+ 1 0))
(check-expect (sum 3) (+ 3 2 1 0))

;(define (sum n) 0) ;stub

(define (sum n)
  (cond [(zero? n) 0]
        [else
         (+ n (sum (sub1 n)))]))