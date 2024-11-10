;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Compound-P4-trip) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; trip-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; Design a data definition to help travellers plan their next trip. 
; A trip should specify an origin, destination, mode of transport and 
; duration (in days).
; 


(define-struct trip (origin destination transport duration))
;; Trip is (make-trip String String String Natural)
;; interp. a trip with origin, destination, mode of transport, and duration in days

(define T1 (make-trip "Paris" "Bruxelles" "train" 2))
(define T2 (make-trip "Paris" "Tokyo" "plane" 15))
(define T3 (make-trip "Paris" "Venise" "plane" 4))
(define T4 (make-trip "Montreal" "New York" "Flight" 4))

#;
(define (fn-for-trip t)
  (... (trip-origin t)      ;String
       (trip-destination t) ;String
       (trip-transport t)   ;String
       (trip-duration t)))  ;Natural

;; Template rules used:
;;  - compound: 4 fields

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; You have just found out that you have to use all your days off work 
; on your next vacation before they expire at the end of the year. 
; Comparing two options for a trip, you want to take the one that 
; lasts the longest. Design a function that compares two trips and 
; returns the trip with the longest duration.
; 
; Note that the rule for templating a function that consumes two 
; compound data parameters is for the template to include all 
; the selectors for both parameters.
; 


;; Trip Trip -> Trip
;; compare 2 trips and produce the trip with longest duration, if durations are equal produce the 2nd trip
(check-expect  (longest-duration T1 T2) T2)
(check-expect  (longest-duration T1 T3) T3)
(check-expect  (longest-duration T3 T4) T4)

;(define (longest-duration t1 t2) T1) ;stub

;<Template from trip>

(define (longest-duration t1 t2)
  (if (> (trip-duration t1) (trip-duration t2))
      t1
      t2))



