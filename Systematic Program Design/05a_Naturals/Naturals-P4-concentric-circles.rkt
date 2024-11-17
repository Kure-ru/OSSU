;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Naturals -P4-concentric-circles|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; concentric-circles-starter.rkt

;  PROBLEM:
;
;  Design a function that consumes a natural number n and a color c, and produces n 
;  concentric circles of the given color.
;
;  So (concentric-circles 5 "black") should produce .
;

;; Natural String -> Image
;; produce an image of concentric circles of color c and number n
(check-expect (concentric-circles 0 "pink") empty-image)
(check-expect (concentric-circles 1 "pink") (overlay (circle 10 "outline" "pink") empty-image))
(check-expect (concentric-circles 6 "black") (overlay (circle 10 "outline" "black")
                                                      (circle 20 "outline" "black")
                                                      (circle 30 "outline" "black")
                                                      (circle 40 "outline" "black")
                                                      (circle 50 "outline" "black")
                                                      (circle 60 "outline" "black")))

;(define (concentric-circles n c) empty-image) ;stub

(define (concentric-circles n c)
  (cond [(zero? n) empty-image]
        [else
         (overlay (circle (* 10 n) "outline" c)
          (concentric-circles (sub1 n) c))]))