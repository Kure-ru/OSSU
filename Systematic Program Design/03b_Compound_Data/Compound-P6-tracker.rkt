;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Compound-P6-tracker) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; 
; PROBLEM:
; 
; Design a world program that displays the current (x, y) position
; of the mouse at that current position. So as the mouse moves the 
; numbers in the (x, y) display changes and its position changes. 
; 


;; =================
;; Constants:

(define WIDTH 600)
(define HEIGHT 300)
(define MTS (empty-scene WIDTH HEIGHT))
(define MOUSE-CURSOR (overlay
                      (line 0 20 "black")
                      (line 20 0 "black")))

(define TEXT-SIZE 12)
(define TEXT-COLOUR "black")


;; =================
;; Data definitions:

(define-struct mouse (x y))
;; Mouse is (make-mouse Number[0, WIDTH] Number[0, HEIGHT])
;; interp. the coordinates of the mouse in pixels

(define M0 (make-mouse 30 50))
(define M1 (make-mouse 540 203))
(define M2 (make-mouse 0 0))

#;
(define (fn-for-mouse m)
  (... (mouse-x m)     ;Number[0, WIDTH]
       (mouse-y m)))   ;Number[0, HEIGHT]

;; Template rules used:
;;   - compound: 2 fields

;; =================
;; Functions:

;; Mouse -> Mouse
;; start the world with (main (make-mouse 0 0))
;; no example needed

(define (main m)
  (big-bang m                  
    (to-draw   render-mouse)   ; Mouse -> Image
    (on-mouse  handle-mouse)))    ; Mouse Integer Integer MouseEvent -> Mouse

;; Mouse -> Mouse
;; When mouse moves, update the mouse coordinates
(check-expect (handle-mouse M1 0 0 "move") M2)
(check-expect (handle-mouse M0 540 203 "move") M1)
(check-expect (handle-mouse M1 540 203 "button-up") M1)

;(define (handle-mouse m x y me) M2);stub

(define (handle-mouse m x y me)
  (cond [(mouse=? me "move") (make-mouse x y)]
        [else m]))

;; Mouse -> Image
;; render the coordinates of the mouse on MTS
(check-expect (render-mouse M0) (place-image (above (text (string-append
                                                           (number->string 30)
                                                           ", "
                                                           (number->string 50))
                                                           TEXT-SIZE
                                                           TEXT-COLOUR) MOUSE-CURSOR) 30 50 MTS))
(check-expect (render-mouse M1) (place-image (above (text (string-append
                                                           (number->string 540)
                                                           ", "
                                                           (number->string 203))
                                                           TEXT-SIZE
                                                           TEXT-COLOUR) MOUSE-CURSOR) 540 203 MTS))

;(define (render-mouse m) ...)  ;stub

;<use template from mouse>
(define (render-mouse m)
  (place-image
   (above (text (string-append
          (number->string(mouse-x m))
          ", "
          (number->string (mouse-y m)))
         TEXT-SIZE
         TEXT-COLOUR)
          MOUSE-CURSOR)
   (mouse-x m) (mouse-y m) MTS))
