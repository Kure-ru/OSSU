;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDD-P3-rocket) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; rocket-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; You are designing a program to track a rocket's journey as it descends 
; 100 kilometers to Earth. You are only interested in the descent from 
; 100 kilometers to touchdown. Once the rocket has landed it is done.
; 
; Design a data definition to represent the rocket's remaining descent. 
; Call it RocketDescent.
; 


;; RocketDescent is one of:
;;   - from 100 km to touchdown to Earth
;;   - false

;; interp.
;; Number(0, 100]   means the rocket is landing and how many km left
;; false         means the rocket has landed on Earth

(define RD1 100) ;just started descending
(define RD2 49)
(define RD3 0.5)   ;almost done
(define RD4 false) ;rocket has landed

#;
(define (fn-for-rocket-descent rd)
  (cond [(number? rd)(... rd)]
        [else (... )]))

;; Template rules used:
;;   - atomic non-distinct: Number (0, 100]
;;   - atomic distinct: false

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; Design a function that will output the rocket's remaining descent distance 
; in a short string that can be broadcast on Twitter. 
; When the descent is over, the message should be "The rocket has landed!".
; Call your function rocket-descent-to-msg.
; 


;; Countdown -> String
;; Produce a message of current state of rocket descent

(check-expect (rocket-descent-to-msg RD1) "Rocket is landing. Remaining distance: 100km.")
(check-expect (rocket-descent-to-msg RD2) "Rocket is landing. Remaining distance: 49km.")
(check-expect (rocket-descent-to-msg RD3) "Rocket is landing. Remaining distance: 1/2km.")
(check-expect (rocket-descent-to-msg RD4) "The rocket has landed!")  

;(define (rocket-descent-to-msg rd) "")

; <use template from RocketDescent>

(define (rocket-descent-to-msg rd)
  (cond [(number? rd)(string-append "Rocket is landing. Remaining distance: " (number->string rd) "km.")]
        [else "The rocket has landed!"]))


