;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Compound-P5-growing-grass) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; growing-grass-starter.rkt

; 
; PROBLEM:
; 
; Design a world program as follows:
; 
; The world starts off with a piece of grass waiting to grow. As time passes, 
; the grass grows upwards. Pressing any key cuts the current strand of 
; grass to 0, allowing a new piece to grow to the right of it.
; 
; Starting display:
; 
; .
; 
; After a few seconds:
; 
; .
; 
; After a few more seconds:
; 
; .
; 
; Immediately after pressing any key:
; 
; .
; 
; A few more seconds after pressing any key:
; 
; .
; 
; NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 


(require 2htdp/image)
(require 2htdp/universe)

;; =================
;; Constants:

(define WIDTH 400)
(define HEIGHT 300)
(define MTS (empty-scene WIDTH HEIGHT "Light Cyan"))

(define GRASS-COLOUR "Spring Green")
(define GRASS-WIDTH )
(define GRASS-Y 5)
(define GRASS-SPACING 2)

;; =================
;; Data definitions:

(define-struct grass (x size)) 
;; Grass is (make-grass [5, (- WIDTH 5)] Natural)
;; interp. grass with x coordinate and size of times GRASS-Y

(define G0 (make-grass 5  0)) ;starting point
(define G1 (make-grass 5  (* GRASS-Y 1)))
(define G2 (make-grass 5  (* GRASS-Y 2)))
(define G3 (make-grass 7  0)) ;after grass is cut once
(define G4 (make-grass 7 (* GRASS-Y 1))) 

#;
(define (fn-for-grass g)
  (... (grass-x g)       ;[5, (- WIDTH 5)]
       (grass-size g)))  ;Natural

;; Template rules used:
;;   - compound: 2 fields

;; =================
;; Functions:

;; Grass -> Grass
;; growing grass; start with (main G0)
;; <examples not needed>

(define (main g)
  (big-bang g                   
            (on-tick   next-grass)     ; Grass -> Grass
            (to-draw   render-grass)   ; Grass -> Image
            (on-key    handle-key)))   ; Grass KeyEvent -> Grass


;; Grass -> Grass
;; increase grass size
(check-expect (next-grass G0) G1)
(check-expect (next-grass G1) G2)
(check-expect (next-grass (make-grass 7 0)) G4)

;(define (next-grass g) G0) ;stub
;template from Grass
(define (next-grass g)
  (make-grass (grass-x g) (+ (grass-size g) GRASS-Y)))  


;; Grass -> Image
;; render the correct image of grass at its x-position and correct size on MTS
(check-expect (render-grass G0) MTS)
(check-expect (render-grass G1) (place-image (rectangle GRASS-WIDTH (* GRASS-Y 1) "solid" GRASS-COLOUR) 5 HEIGHT MTS))
(check-expect (render-grass G2) (place-image (rectangle GRASS-WIDTH (* GRASS-Y 2) "solid" GRASS-COLOUR) 5 HEIGHT MTS))
(check-expect (render-grass G4) (place-image (rectangle GRASS-WIDTH (* GRASS-Y 1) "solid" GRASS-COLOUR) 7 HEIGHT MTS))

;(define (render-grass g) MTS) ;stub
;template from Grass

(define (render-grass g)
  (place-image (rectangle GRASS-WIDTH (grass-size g) "solid" GRASS-COLOUR) (grass-x g) HEIGHT MTS))

;; Grass KeyEvent -> Grass
;; cut the grass and move it to the right when the space bar is pressed
(check-expect (handle-key G0 " ") G3) 
(check-expect (handle-key G2 " ") G3)
(check-expect (handle-key G0 "a") G0) 
(check-expect (handle-key G2 "a") G2)

(define (handle-key g ke)
  (cond [(key=? ke " ") (make-grass (+ (grass-x g) GRASS-SPACING) 0)]
        [else g]))
