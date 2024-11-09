;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDDDesignQuiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDD Design Quiz

;; Age is Natural
;; interp. the age of a person in years
(define A0 18)
(define A1 25)

#;
(define (fn-for-age a)
  (... a))

;; Template rules used:
;; - atomic non-distinct: Natural


; Problem 1:
; 
; Consider the above data definition for the age of a person.
; 
; Design a function called teenager? that determines whether a person
; of a particular age is a teenager (i.e., between the ages of 13 and 19).


;; Age -> Boolean
;; Produces true if age is comprised between 13 and 19

(check-expect (teenager? 18) true)
(check-expect (teenager? 25) false)

;(define (teenager? a) false)     ;stub

; <use template from Age>

(define (teenager? a)
  (and (>= a 13) (<= a 19)))


; Problem 2:
; 
; Design a data definition called MonthAge to represent a person's age
; in months.


;; MonthAge is Natural
;; interp. person age represented in months

(define MA1 43)
(define MA2 546)

#;
(define (fn-for-month-age ma)
  (... ma))

;; Template rules used:
;;   - atomic non-distinct: Natural

; Problem 3:
; 
; Design a function called months-old that takes a person's age in years 
; and yields that person's age in months.
; 


;; Natural -> MonthAge
;; Produce a person's age in months

(check-expect (months-old 3) 36)
(check-expect (months-old 31) 372)

;(define (months-old ma) 0)     ;stub

; <use template from MonthAge>

(define (months-old ma)
  (* ma 12))


; Problem 4:
; 
; Consider a video game where you need to represent the health of your
; character. The only thing that matters about their health is:
; 
;   - if they are dead (which is shockingly poor health)
;   - if they are alive then they can have 0 or more extra lives
; 
; Design a data definition called Health to represent the health of your
; character.
; 
; Design a function called increase-health that allows you to increase the
; lives of a character.  The function should only increase the lives
; of the character if the character is not dead, otherwise the character
; remains dead.


;; Data Definition:

;; Health is one of:
;;   - Natural
;;   - false
;; interpr. false mean that character is dead, Natural is the number of lives they have


(define H1 false)
(define H2 6)

#;
(define (fn-for-health h)
  (cond [(false? h) (...)]
        [(number? h) (... h)]))

;; Template rules used:
;;   - one of: 2 cases
;;   - atomic distinct: false
;;   - atomic non-distinct: Natural

;; Functions

;; Health -> Health
;; Increase number of lives of character if they are not dead

(check-expect (increase-health 3) 4)
(check-expect (increase-health false) false)

;(define (increase-health h) false)      ;stub

; <use template from Health>

(define (increase-health h)
  (cond [(false? h) false]
        [(number? h) (+ 1 h)]))
