;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDF-P8-ensure-question) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; ensure-question-starter.rkt

; 
; PROBLEM:
; 
; Use the How to Design Functions (HtDF) recipe to design a function that consumes a string, and adds "?" 
; to the end unless the string already ends in "?".
; 
; For this question, assume the string has length > 0. Follow the HtDF recipe and leave behind commented 
; out versions of the stub and template.
; 


;; String -> String
;; If a string doesn't end with '?', add '?' to it

;(define (make-question str) "")    ;stub

(check-expect (make-question "hi") "hi?")
(check-expect (make-question "question?") "question?")


;(define (make-question str)      ;template
;  (... str))

(define (make-question str)
  (if (string=? (substring str (- (string-length str) 1)) "?")
      str
      (string-append str "?")
 ))