;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDF-Design-Quiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; PROBLEM:
; 
; Design a function that consumes two images and produces true if the first is larger than the second.


;; Image Image -> Boolean
;; Produce true if the 1st image is larger than the second

(check-expect (is-larger? (rectangle 10 20 "solid" "red")  (rectangle 20 30 "solid" "red")) false)
(check-expect (is-larger? (rectangle 10 20 "solid" "red")  (rectangle 20 20 "solid" "red")) false)
(check-expect (is-larger? (rectangle 10 30 "solid" "red")  (rectangle 20 10 "solid" "red")) false)
(check-expect (is-larger? (rectangle 20 20 "solid" "red")  (rectangle 20 30 "solid" "red")) false)
(check-expect (is-larger? (rectangle 20 20 "solid" "red")  (rectangle 20 20 "solid" "red")) false)
(check-expect (is-larger? (rectangle 20 30 "solid" "red")  (rectangle 20 20 "solid" "red")) false)
(check-expect (is-larger? (rectangle 40 20 "solid" "red")  (rectangle 20 30 "solid" "red")) false)
(check-expect (is-larger? (rectangle 40 20 "solid" "red")  (rectangle 20 20 "solid" "red")) false)
(check-expect (is-larger? (rectangle 30 40 "solid" "red")  (rectangle 10 20 "solid" "red")) true)

;(define (is-larger? img1 img2) false)   ;stub


;(define (is-larger? img1 img2)          ;template
; (... img1 img2))

(define (is-larger? img1 img2)
  (and (> (image-width img1) (image-width img2))
       (> (image-height img1) (image-height img2))))

