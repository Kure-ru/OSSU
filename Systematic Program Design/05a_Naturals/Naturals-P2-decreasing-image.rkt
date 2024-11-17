;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Naturals-P2-decreasing-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; decreasing-image-starter.rkt

;  PROBLEM:
;  
;  Design a function called decreasing-image that consumes a Natural n and produces an image of all the numbers 
;  from n to 0 side by side. 
;  
;  So (decreasing-image 3) should produce .

(define TEXT-SIZE 20)
(define TEXT-COLOR "black")
(define SPACING (text " " TEXT-SIZE TEXT-COLOR))

;; Natural ->
;; produce an image of all the numbers from n to 0 side by side
(check-expect (decreasing-image 0) (text (number->string 0) TEXT-SIZE TEXT-COLOR))
(check-expect (decreasing-image 1) (beside (text (number->string 1) TEXT-SIZE TEXT-COLOR) SPACING (text (number->string 0) TEXT-SIZE TEXT-COLOR)))
(check-expect (decreasing-image 3) .)

;stub (define (decreasing-image n) (square 0 "solid" "white")) ;stub

(define (decreasing-image n)
  (cond [(zero? n) (text (number->string 0) TEXT-SIZE TEXT-COLOR)]
        [else
         (beside (text (number->string n) TEXT-SIZE TEXT-COLOR)
                 SPACING
                 (decreasing-image (sub1 n)))]))