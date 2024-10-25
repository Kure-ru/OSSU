;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname BSL_P10-triangle) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; triangle-starter.rkt

; PROBLEM:
; 
; Write an expression that uses triangle, overlay, and rotate to produce an image similar to this:
; 
;                                   .
; You can consult the DrRacket help desk for information on how to use triangle and overlay.
; Don't worry about the exact size of the triangles.
; 


(require 2htdp/image)

(underlay
 (rotate 180 (triangle 50 "solid" "yellow"))
 (triangle 50 "solid" "green"))
