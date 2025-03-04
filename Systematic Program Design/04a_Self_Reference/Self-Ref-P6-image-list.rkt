;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Self-Ref-P6-image-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; image-list-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; Design a data definition to represent a list of images. Call it ListOfImage. 
; 


;; ListOfImage is one of:
;;  - empty
;;  - (cons Image ListOfImage)
;; interp. a list of images
(define LOI1 empty)
(define LOI2 (cons (rectangle 20 40 "solid" "tan") (cons (square 5 "solid" "blue") empty)))
#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Image ListOfImage)
;;  - self-reference: (rest loi) is ListOfImage

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; Design a function that consumes a list of images and produces a number 
; that is the sum of the areas of each image. For area, just use the image's 
; width times its height.
; 


;; ListOfImage -> Number
;; produce the sum of area of every image of the list
(check-expect (total-image-area LOI1) 0)
(check-expect (total-image-area (cons (rectangle 20 40 "solid" "tan") empty)) (* 20 40))
(check-expect (total-image-area LOI2) (+ (* 20 40) (* 5 5)))

;(define (total-image-area loi) 0) ;stub
;<use template from ListOfImage>

(define (total-image-area loi)
  (cond [(empty? loi) 0]
        [else
         (+ (* (image-width (first loi)) (image-height (first loi)))
         (total-image-area (rest loi)))]))