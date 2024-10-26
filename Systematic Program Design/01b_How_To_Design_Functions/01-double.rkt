;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 01-double) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; double-starter.rkt

; 
; PROBLEM:
; 
; Design a function that consumes a number and produces twice that number. 
; Call your function double. Follow the HtDF recipe and leave behind commented 
; out versions of the stub and template.
; 


;; Number -> Number                    // SIGNATURE 
;; produce 2 times the given number    // PURPOSE


;; EXAMPLES/TESTS
(check-expect (double 3) 6)
(check-expect (double 4.2) 8.4)

;; STUB
;; function def with name, params and dummy result of correct type
;(define (double n) 0)

;; TEMPLATE (outline of the function)
;(define (double n)
;  (...n))

;; CODE BODY
(define (double n)
  (* 2 n))

