;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname BSL_4-glue) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; glue-starter.rkt

; 
; PROBLEM:
; 
; Write an expression that sticks the strings "Super" "Glue" together into a single string 
; "Super Glue" with a space between the two words.
; 


(string-append "Super" " " "Glue")