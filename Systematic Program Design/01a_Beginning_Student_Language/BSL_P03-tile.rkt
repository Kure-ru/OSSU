;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tile-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; tile-starter.rkt

; 
; PROBLEM:
; 
; Use the DrRacket square, beside and above functions to create an image like this one:
; 
; .
; 
; If you prefer to be more creative feel free to do so. You can use other DrRacket image 
; functions to make a more interesting or more attractive image.
; 



(define (colorSquare color)
  (square 20 "solid" color))

(above
 (beside
  (colorSquare "blue")
  (colorSquare "yellow"))
 (beside
  (colorSquare "yellow")
  (colorSquare "blue")))
 