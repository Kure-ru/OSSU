;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDW-P1-countdown-animation) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; countdown-animation starter.rkt

; 
; PROBLEM:
; 
; Design an animation of a simple countdown. 
; 
; Your program should display a simple countdown, that starts at ten, and
; decreases by one each clock tick until it reaches zero, and stays there.
; 
; To make your countdown progress at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, 
; (on-tick advance-countdown 1) then big-bang will wait 1 second between 
; calls to advance-countdown.
; 
; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; Once you are finished the simple version of the program, you can improve
; it by reseting the countdown to ten when you press the spacebar.
; 


;; Animation of a simple countdown

;; =================
;; Constants:

(define WIDTH 100)
(define HEIGHT WIDTH)

(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))

(define MTS (empty-scene WIDTH HEIGHT))

(define TEXT-SIZE 20)
(define TEXT-COLOUR "black")

;; =================
;; Data definitions:

;; Countdown is Natural[0, 10]
;; interp. the current seconds remaining in the countdown

(define CD1 10)
(define CD2 5)
(define CD3 0)

#;
(define (fn-for-countdown cd)
  (... cd))

;; Template rules used:
;;   - Atomic non-distinct: Natural[0, 10]

;; =================
;; Functions:

;; Countdown -> Countdown
;; start the world with (main 10)
(define (main cd)
  (big-bang cd                            ; Countdown
    (on-tick   advance-countdown 1)       ; Countdown -> Countdown
    (to-draw   render)                    ; Countdown -> Image
    (on-key    handle-key)))              ; Countdown KeyEvent -> Countdown

;; Countdown -> Countdown
;; produce the countdown by subtracting 1, if the countdown is 0 it remains at 0

(check-expect (advance-countdown 10) 9)
(check-expect (advance-countdown 5) 4)
(check-expect (advance-countdown 0) 0)

;(define (advance-countdown cd) 0)   ;stub

;<use template from Countdown>
(define (advance-countdown cd)
  (if (= cd 0)
      0
      (- cd 1)))

;; Countdown -> Image
;; render countdown image on MTS 
(check-expect (render 4) (place-image (text "4" TEXT-SIZE TEXT-COLOUR) CTR-X CTR-Y MTS))

;(define (render cd) MTS)   ;stub

;<use template from Countdown>
(define (render cd)
  (place-image (text (number->string cd) TEXT-SIZE TEXT-COLOUR)
               CTR-X
               CTR-Y
               MTS))

;; Countdown KeyEvent -> Countdown
;; reset Countdown to 10 when space bar is pressed
(check-expect (handle-key 10 " ") 10)
(check-expect (handle-key 2 " ") 10)
(check-expect (handle-key 10 "a") 10)
(check-expect (handle-key 2 "a") 2)


;(define (handle-key cd ke) 10)   ;stub

(define (handle-key cd ke)
  (cond [(key=? ke " ") 10]
        [else cd]))