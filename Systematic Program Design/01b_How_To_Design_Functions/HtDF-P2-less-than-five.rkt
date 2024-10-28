;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDF-P2-less-than-five) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; less-than-five-starter.rkt

; 
; PROBLEM:
; 
; DESIGN function that consumes a string and determines whether its length is
; less than 5.  Follow the HtDF recipe and leave behind commented out versions 
; of the stub and template.
; 


;; String -> Boolean
;; Produce true if the string length is less than 5

(check-expect (less-than-five? "computer") false)
(check-expect (less-than-five? "salem") false)
(check-expect (less-than-five? "cat") true)

;(define (less-than-five? str) false)       ;stub

;(define (less-than-five? str)              ;template
;  (... str))

(define (less-than-five? str)
  (< (string-length str) 5))