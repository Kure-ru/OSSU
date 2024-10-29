;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDF-P5-blue-triangle) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; blue-triangle-starter.rkt

(require 2htdp/image)

; PROBLEM:
; 
; Design a function that consumes a number and produces a blue solid triangle of that size.
; 
; You should use The How to Design Functions (HtDF) recipe, and your complete design should include
; signature, purpose, commented out stub, examples/tests, commented out template and the completed function.


;; Natural -> Image
;; Produce a blue solid triangle of the size of a given number

;(define (make-blue-triangle size) (empty-image))         ;stub

(check-expect (make-blue-triangle 20) (triangle 20 "solid" "blue"))
(check-expect (make-blue-triangle 12) (triangle 12 "solid" "blue"))

;(define (make-blue-triangle size)       ; template
;   (... img ))

(define (make-blue-triangle size)
  (triangle size "solid" "blue"))

