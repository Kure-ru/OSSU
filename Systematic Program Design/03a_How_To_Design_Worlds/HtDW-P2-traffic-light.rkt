;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDW-P2-traffic-light) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; traffic-light-starter.rkt

; 
; PROBLEM:
; 
; Design an animation of a traffic light. 
; 
; Your program should show a traffic light that is red, then green, 
; then yellow, then red etc. For this program, your changing world 
; state data definition should be an enumeration.
; 
; Here is what your program might look like if the initial world 
; state was the red traffic light:
; .
; Next:
; .
; Next:
; .
; Next is red, and so on.
; 
; To make your lights change at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, (on-tick next-color 1) 
; then big-bang will wait 1 second between calls to next-color.
; 
; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; Note: If you want to design a slightly simpler version of the program,
; you can modify it to display a single circle that changes color, rather
; than three stacked circles. 
; 



;; Animation of a traffic light

;; =================
;; Constants:

(define CIRCLE-RADIUS 20)
(define SPACING 5) ;space between the lights

(define SPACE (circle SPACING "solid" "black"))
(define MTS (empty-scene (+ (* 2 SPACING) (* 2 CIRCLE-RADIUS)) (+ (* 8 SPACING) (* 6 CIRCLE-RADIUS))  "black"))

(define RED-LIGHT-STATE (overlay (above (circle CIRCLE-RADIUS "solid" "red") SPACE (circle CIRCLE-RADIUS "outline" "yellow") SPACE (circle CIRCLE-RADIUS "outline" "green")) MTS))
(define YELLOW-LIGHT-STATE (overlay (above (circle CIRCLE-RADIUS "outline" "red") SPACE (circle CIRCLE-RADIUS "solid" "yellow") SPACE (circle CIRCLE-RADIUS "outline" "green")) MTS))
(define GREEN-LIGHT-STATE (overlay (above (circle CIRCLE-RADIUS "outline" "red") SPACE (circle CIRCLE-RADIUS "outline" "yellow") SPACE (circle CIRCLE-RADIUS "solid" "green")) MTS))

;; =================
;; Data definitions:

;; TrafficLight is one of:
;;   - "red"
;;   - "green"
;;   - "yellow"
;; interp. the current colour of a traffic light
;; <examples are redundant for enumerations>

#;
(define (fn-for-traffic-light t)
  (cond [(string=? t "red") (...)]
        [(string=? t "green") (...)]
        [(string=? t "yellow") (...)]))

;; Template rules used:
;;   - one of: 3 cases
;;   - atomic distinct: "red"
;;   - atomic distinct: "green"
;;   - atomic distinct: "yellow"

;; =================
;; Functions:

;; TrafficLight -> TrafficLight
;; start the world with (main "red")
;; no tests for main function

(define (main t)
  (big-bang t
            (on-tick   next-color 1)           ; TrafficLight -> TrafficLight
            (to-draw   render-traffic-light))) ; TrafficLight -> Image

;; TrafficLight -> TrafficLight
;; produce the next state of trafficLight
(check-expect (next-color "red")    "green")
(check-expect (next-color "green") "yellow") 
(check-expect (next-color "yellow")   "red") 

;(define (change-traffic-light t) "red")   ;stub
;<use template from TrafficLight>

(define (next-color t)
  (cond [(string=? t "red") "green"]
        [(string=? t "green") "yellow"]
        [(string=? t "yellow") "red"]))

;; TrafficLight -> Image
;; render proper traffic light state
(check-expect (render-traffic-light "red")       RED-LIGHT-STATE)
(check-expect (render-traffic-light "green")   GREEN-LIGHT-STATE)
(check-expect (render-traffic-light "yellow") YELLOW-LIGHT-STATE)


;(define (render-traffic-light t) RED-LIGHT-STATE)   ;stub
;<use template from TrafficLight>
(define (render-traffic-light t)
  (cond [(string=? t "red")    RED-LIGHT-STATE]
        [(string=? t "green")  GREEN-LIGHT-STATE]
        [(string=? t "yellow") YELLOW-LIGHT-STATE]))