;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname more-arithmetic-expression) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; more-arithmetic-expression-starter.rkt

; 
; PROBLEM:
; 
; Write two expressions that multiply the numbers 3, 5 and 7. 
; The first should take advantage of the fact that * can accept more than 2 arguments. 
; The second should build up the result by first multiplying 3 times 5 and then multiply the result of that by 7. 
; 


(* 3 5 7)
(* (* 3 5) 7)