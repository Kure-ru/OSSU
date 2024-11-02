;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDD-P1-employees) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; employees-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; You work in the Human Resources department at a ski lodge. 
; Because the lodge is busier at certain times of year, 
; the number of employees fluctuates. 
; There are always more than 10, but the maximum is 50.
; 
; Design a data definition to represent the number of ski lodge employees. 
; Call it Employees.


;; Employees is Natural (10, 50]
;; interp. the range of employees at one time

(define E1 11) ;min
(define E2 25)
(define E3 50) ;max

#;
(define (fn-for-employees nb)
  (... nb))

;; Template rules used:
;;   - atomic non-distinct: Integer(10, 50]

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; Now design a function that will calculate the total payroll for the quarter.
; Each employee is paid $1,500 per quarter. Call it calculate-payroll.
; 


;; Employees -> Number
;; Calculate the total payroll for the quarter according to number of employees * $1,500

(check-expect (calculate-payroll E1) (* 11 1500))
(check-expect (calculate-payroll E2) (* 25 1500))
(check-expect (calculate-payroll E3) (* 50 1500))

;(define (calculate-payroll nb) 0) ;stub

; <use template from Employee>
(define (calculate-payroll nb)
  (* nb 1500))

