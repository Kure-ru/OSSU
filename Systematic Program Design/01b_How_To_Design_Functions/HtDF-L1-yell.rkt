;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDF-L1-yell) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; yell-starter.rkt

; 
; PROBLEM:
; 
; DESIGN a function called yell that consumes strings like "hello" 
; and adds "!" to produce strings like "hello!".
; 
; Remember, when we say DESIGN, we mean follow the recipe.
; 
; Leave behind commented out versions of the stub and template.
; 


;; String -> String
;; Produce the given string with "!" added to the end.

;; EXAMPLES/TESTS
(check-expect (yell "hello") "hello!")
(check-expect (yell "bye") "bye!")

;; STUB
;(define (yell str) "")

;; TEMPLATE (outline of the function)
;(define (yell str)
;  (...str))

;; CODE BODY
(define (yell str)
  (string-append str "!"))