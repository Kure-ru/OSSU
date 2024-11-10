;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Compound-P2-spinning) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; spinning-starter.rkt

; 
; PROBLEM:
; 
; Design a world program as follows:
; 
; The world starts off with a small square at the center of the screen. As time 
; passes, the square stays fixed at the center, but increases in size and rotates 
; at a constant speed.Pressing the spacebar resets the world so that the square 
; is small and unrotated.
; 
; Starting display:
; .
; After a few seconds:
; .
; After a few more seconds:
; .
; Immediately after pressing the spacebar:
; .
; NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; NOTE 2: The rotate function requires an angle in degrees as its first 
; argument. By that it means Number[0, 360). As time goes by the box may end up 
; spinning more than once, for example, you may get to a point where it has spun 
; 362 degrees, which rotate won't accept. One solution to that is to use the 
; remainder function as follows:
; 
; (rotate (remainder ... 360) (text "hello" 30 "black"))
; 
; where ... can be an expression that produces any positive number of degrees 
; and remainder will produce a number in [0, 360).
; 
; Remember that you can lookup the documentation of rotate if you need to know 
; more about it.
; 
; NOTE 3: There is a way to do this without using compound data. But you should 
; design the compound data based solution.
; 


;; =================
;; Constants:

(define WIDTH 400)
(define HEIGHT WIDTH)
(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))
(define ROTATIONAL-SPEED 5)
(define GROWTH-SPEED 1)
(define MTS (empty-scene WIDTH HEIGHT))
(define SQUARE-COLOUR "red")


;; =================
;; Data definitions:

(define-struct rotating-square (size angle))
;; Square is (make-rotating-square Integer Number[0, 360))
;; interp. (make-rotating-square size angle)) is a square with a size in pixel that is rotated to an angle in degree

(define S0 (make-rotating-square 20 0))
(define S1 (make-rotating-square 30 0))
(define S2 (make-rotating-square 40 50))

#;
(define (fn-for-rotating-square s)
  (... (rotating-square-size s)      ;Integer
       (rotating-square-angle s)))   ;Number[0, 360)

;; Template rules used:
;;   - compound: 2 fields

;; =================
;; Functions:

;; RotatingSquare -> RotatingSquare
;; Make a red square rotate and grow bigger; start with (main S0)

(define (main s)
  (big-bang s                    
            (on-tick   transform-square)     ; RotatingSquare -> RotatingSquare
            (to-draw   render-square)        ; RotatingSquare -> Image
            (on-key    reset-square)))       ; RotatingSquare KeyEvent -> RotatingSquare

;; RotatingSquare -> RotatingSquare
;; produce a square bigger and more rotated
(check-expect (transform-square S1) (make-rotating-square 31 5))
(check-expect (transform-square S2) (make-rotating-square 41 55))
 
;(define (transform-square s) S1)  ;stub
;use template from Square
(define (transform-square s)
  (make-rotating-square (increase-square-size s) (rotate-square s)))

;; RotatingSquare -> Number
;; increase size of the square of GROWTH-SPEED pixels
(check-expect (increase-square-size S1) (+ (rotating-square-size S1) GROWTH-SPEED))
(check-expect (increase-square-size S2) (+ (rotating-square-size S2) GROWTH-SPEED))

;(define (increase-square-size s) ...)  ;stub
;use template from Square
(define (increase-square-size s)
   (+ (rotating-square-size s) GROWTH-SPEED))

;; RotatingSquare -> RotatingSquare
;; rotate square by ROTATIONAL-SPEED degrees
(check-expect (rotate-square S1) (+ (rotating-square-angle S1) ROTATIONAL-SPEED))
(check-expect (rotate-square S2) (+ (rotating-square-angle S2) ROTATIONAL-SPEED))

;(define (rotate-square s) ...) ;stub
;use template from Square
(define (rotate-square s)
   (+ (rotating-square-angle s) ROTATIONAL-SPEED))

;; RotatingSquare -> Image
;; render the correct image of a square on MTS
(check-expect (render-square S1) (place-image (rotate (remainder 0 360)  (square 30 "solid" SQUARE-COLOUR)) CTR-X CTR-Y  MTS))
(check-expect (render-square S2) (place-image (rotate (remainder 50 360) (square 40 "solid" SQUARE-COLOUR)) CTR-X CTR-Y  MTS))

;(define (render-square s) ...) ;stub

;use template from Square
(define (render-square s)
  (place-image (rotate (remainder (rotating-square-angle s) 360) (square (rotating-square-size s) "solid" SQUARE-COLOUR)) CTR-X CTR-Y  MTS))

; RotatingSquare KeyEvent -> RotatingSquare
; reset the square when pressing the spacebar
(check-expect (reset-square S1 " ") S0)
(check-expect (reset-square S0 " ") S0)
(check-expect (reset-square S2 "a") S2)
(check-expect (reset-square S0 "a") S0)

;(define (reset-square s ke) S0)  ;stub
;template from KeyEvent
(define (reset-square s ke)
  (cond [(key=? ke " ") (make-rotating-square 20 0)]
        [else s]))
