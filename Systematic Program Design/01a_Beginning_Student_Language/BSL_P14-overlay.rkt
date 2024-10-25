;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname BSL_P14-overlay) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; overlay-starter.rkt

; 
; PROBLEM:
; 
; Write an expression that uses star and overlay to produce an image similar to this:
; 
;                                   .
; You can consult the DrRacket help desk for information on how to use star and overlay. 
; Don't worry about the exact size of the stars.
; 


(require 2htdp/image)

(overlay
 (star 20 "solid" "blue")
 (star 40 "solid" "yellow")
 (star 60 "solid" "blue"))