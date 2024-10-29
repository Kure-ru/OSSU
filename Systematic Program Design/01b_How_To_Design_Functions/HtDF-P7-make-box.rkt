;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDF-P7-make-box) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; make-box-starter.rkt

; 
; PROBLEM:
; 
; You might want to create boxes of different colours.
; 
; Use the How to Design Functions (HtDF) recipe to design a function that consumes a color, and creates a 
; solid 10x10 square of that colour.  Follow the HtDF recipe and leave behind commented out versions of
; the stub and template.
; 



;; Color -> Image
;; Produce a 10x10 box of given color

;(define (make-box color) empty-image)      ;stub

(check-expect (make-box "green") (square 10 "solid" "green"))
(check-expect (make-box "pink") (square 10 "solid" "pink"))
(check-expect (make-box "yellow") (square 10 "solid" "yellow"))

;(define (make-box color)      ;template
;  (... color))

(define (make-box color)
  (square 10 "solid" color))