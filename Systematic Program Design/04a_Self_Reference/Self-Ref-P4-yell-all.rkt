;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Self-Ref-P4-yell-all) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; yell-all-starter.rkt

;; =================
;; Data definitions:

; 
; Remember the data definition for a list of strings we designed in Lecture 5c:
; (if this data definition does not look familiar, please review the lecture)
; 


;; ListOfString is one of: 
;;  - empty
;;  - (cons String ListOfString)
;; interp. a list of strings

(define LS0 empty) 
(define LS1 (cons "a" empty))
(define LS2 (cons "a" (cons "b" empty)))
(define LS3 (cons "c" (cons "b" (cons "a" empty))))

#;
(define (fn-for-los los) 
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))

;; Template rules used: 
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons String ListOfString)
;; - self-reference: (rest los) is ListOfString

;; =================
;; Functions:

; 
; PROBLEM:
; 
; Design a function that consumes a list of strings and "yells" each word by 
; adding "!" to the end of each string.
; 


;; ListOfString -> ListOfString
;; produce a new list of strings that adds "!" to the end of each string of the list
(check-expect (yell-all empty) empty)
(check-expect (yell-all LS1) (cons (string-append "a" "!") empty))
(check-expect (yell-all LS2) (cons (string-append "a" "!") (cons (string-append "b" "!") empty)))

;(define (yell-all los) empty)  ;stub
;<use template from ListOfString>
(define (yell-all los) 
  (cond [(empty? los) empty]
        [else
         (cons (string-append (first los) "!")
              (yell-all (rest los)))]))