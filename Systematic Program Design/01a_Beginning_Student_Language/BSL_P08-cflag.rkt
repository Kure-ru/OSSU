;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname BSL_P8-cflag) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; cflag-starter.rkt

; 
; PROBLEM:
; 
; The background for the Canadian Flag (without the maple leaf) is this:
;          .
;          
; Write an expression to produce that background. (If you want to get the
; details right, officially the overall flag has proportions 1:2, and the 
; band widths are in the ratio 1:2:1.)
; 
; 


(require 2htdp/image)

(beside
 (rectangle 20 40 "solid" "red")
 (rectangle 40 40 "solid" "white")
 (rectangle 20 40 "solid" "red"))