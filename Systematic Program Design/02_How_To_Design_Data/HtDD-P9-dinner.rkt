;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDD-P9-dinner) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; dinner-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; You are working on a system that will automate delivery for 
; YesItCanFly! airlines catering service. 
; There are three dinner options for each passenger, chicken, pasta 
; or no dinner at all. 
; 
; Design a data definition to represent a dinner order. Call the type 
; DinnerOrder.
; 


;; DinnerOrder is one of:
;;   - "chicken"
;;   - "pasta"
;;   - false

;; interp. false means no dinner, other choices are dinner options

(define D1 "chicken")
(define D2 "pasta")
(define D3 false)

#;
(define (fn-for-dinner-order d)
  (cond  [(false? d) (...)]
         [(string=? d "chicken") (... d)]
         [(string=? d "pasta") (... d)]))

;; Template rules used:
;;   - one of: 3 cases
;;   - atomic non-distinct: false
;;   - atomic distinct: "chicken"
;;   - atomic distinct: "pasta"

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; Design the function dinner-order-to-msg that consumes a dinner order 
; and produces a message for the flight attendants saying what the
; passenger ordered. 
; 
; For example, calling dinner-order-to-msg for a chicken dinner would
; produce "The passenger ordered chicken."
; 


;; DinnerOrder -> String
;; Produce a message with the order

(check-expect (dinner-order-to-msg "chicken") "The passenger ordered chicken.")
(check-expect (dinner-order-to-msg "pasta") "The passenger ordered pasta.")
(check-expect (dinner-order-to-msg false) "The passenger didn't order dinner.")

;(define (dinner-order-to-msg d) "")      ;stub

; <use template from DinnerOrder>

(define (dinner-order-to-msg d)
  (cond  [(false? d) "The passenger didn't order dinner."]
         [(string=? d "chicken") "The passenger ordered chicken."]
         [(string=? d "pasta") "The passenger ordered pasta."]
         ))



