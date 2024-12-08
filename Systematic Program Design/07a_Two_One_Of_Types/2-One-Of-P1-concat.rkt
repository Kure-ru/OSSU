;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 2-One-Of-P1-concat) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; concat-starter.rkt

; Problem:
; 
; Given the data definition below, design a function called concat that
; consumes two ListOfString and produces a single list with all the elements 
; of lsta preceding lstb.
; 
; (concat (list "a" "b" ...) (list "x" "y" ...)) should produce:
; 
; (list "a" "b" ... "x" "y" ...)
; 
; You are basically going to design the function append using a cross product 
; of type comments table. Be sure to simplify your design as much as possible. 
; 
; Hint: Think carefully about the values of both lists. You might see a way to 
; change a cell's content so that 2 cells have the same value.
; 


;; =================
;; Data Definitions:

;; ListOfString is one of:
;;  - empty
;;  - (cons String ListOfString)
;; interp. a list of strings
(define LOS1 empty)
(define LOS2 (cons "a" (cons "b" empty)))
(define LOS3 (cons "x" (cons "y" empty)))

;; ==========
;; Functions:

;; ListOfString ListOfString -> ListOfString
;; produce a single list concatenating the two lists given
(check-expect (concat empty empty) empty)
(check-expect (concat LOS2 empty) (cons "a" (cons "b" empty)))
(check-expect (concat empty LOS2) (cons "a" (cons "b" empty)))
(check-expect (concat LOS2 LOS3) (cons "a" (cons "b" (cons "x" (cons "y" empty)))))

;(define (concat lsta lstb) empty)

(define (concat lsta lstb)
  (cond [(empty? lsta) lstb]
        [(empty? lstb) lsta]
        [else (append lsta lstb)]))