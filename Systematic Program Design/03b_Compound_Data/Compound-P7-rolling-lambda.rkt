;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Compound-P7-rolling-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; rolling-lambda-starter.rkt

; 
; PROBLEM:
; 
; Design a world program as follows:
; 
; The world starts off with a lambda on the left hand side of the screen. As 
; time passes, the lambda will roll towards the right hand side of the screen. 
; Clicking the mouse changes the direction the lambda is rolling (ie from 
; left -> right to right -> left). If the lambda hits the side of the window 
; it should also change direction.
; 
; Starting display (rolling to the right):
; 
; .
; 
; After a few seconds (rolling to the right):
;       .
; After a few more seconds (rolling to the right):
;                .
; A few seconds after clicking the mouse (rolling to the left):
; 
;      .
; 
; NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; NOTE 2: DO THIS PROBLEM IN STAGES.
; 
; FIRST
; 
; Just make the lambda slide back and forth across the screen without rolling.
;       
; SECOND
;   
; Make the lambda spin as it slides, but don't worry about making the spinning
; be just exactly right to make it look like its rolling. Just have it 
; spinning and sliding back and forth across the screen.
; 
; FINALLY
; 
; Work out the math you need to in order to make the lambda look like it is
; actually rolling.  Remember that the circumference of a circle is 2*pi*radius,
; so that for each degree of rotation the circle needs to move:
; 
;    2*pi*radius
;    -----------
;        360
; 
; Also note that the rotate function requires an angle in degrees as its 
; first argument. [By that it means Number[0, 360). As time goes by the lambda
; may end up spinning more than once, for example, you may get to a point 
; where it has spun 362 degrees, which rotate won't accept. One solution to 
; that is to  use the modulo function as follows:
; 
; (rotate (modulo ... 360) LAMBDA)
; 
; where ... can be an expression that produces any positive number of degrees 
; and remainder will produce a number in [0, 360).
; 
; Remember that you can lookup the documentation of modulo if you need to know 
; more about it.
; 


;; =================
;; Constants:

(define WIDTH 600)
(define HEIGHT 300)
(define MTS (empty-scene WIDTH HEIGHT))

(define LAMBDA-IMG .)
(define LAMBDA-Y (/ HEIGHT 2))
(define IMG-HEIGHT (image-height LAMBDA-IMG)) 
(define RADIUS (/ IMG-HEIGHT 2))
(define ROTATION-PER-PIXEL (floor (/ 360 (* 2 pi RADIUS))))

;; =================
;; Data definitions:

(define-struct rolling-lambda (x dx))
;; Lambda is (make-lambda Natural[0, WIDTH], Integer)
;; interp. a rolling lambda with x coordinate and velocity dx
;;    the x is the center of the lambda
;;    x is in screen coordinates (pixels)
;;    dx is pixels per tick

(define RL1 (make-rolling-lambda 30   5)) ;at position 30, moving left -> right
(define RL2 (make-rolling-lambda 160 -6)) ;at position 160, moving left <- right

#;
(define (fn-for-rolling-lambda rl)
  (...(rolling-lambda-x rl)    ;Natural[0, WIDTH]
      (rolling-lambda-dx rl))) ;Integer

;; Template rules used:
;;   - compound: 2 fields

;; =================
;; Functions:

;; RollingLambda -> RollingLambda
;; Make a RollingLambda roll on the sides of the screen; (main (make-rolling-lambda 0 5))
;; no tests for main function
(define (main rl)
  (big-bang rl                    ; RollingLambda
    (on-tick   next-rolling-lambda)     ; RollingLambda -> RollingLambda
    (to-draw   render-lambda)   ; RollingLambda -> Image
    (on-mouse  handle-mouse)))    ; RollingLambda Integer Integer MouseEvent -> RollingLambda

;; RollingLambda -> RollingLambda
;; increases rolling lambda x by dx; bounce off edges
(check-expect (next-rolling-lambda RL1) (make-rolling-lambda (+ 30 5)   5))  ;middle
(check-expect (next-rolling-lambda RL2) (make-rolling-lambda (- 160 6) -6))
(check-expect (next-rolling-lambda (make-rolling-lambda (- WIDTH 5) 5)) (make-rolling-lambda WIDTH 5)) ;reaches edge
(check-expect (next-rolling-lambda (make-rolling-lambda 7 -7)) (make-rolling-lambda 0 -7))
(check-expect (next-rolling-lambda (make-rolling-lambda (- WIDTH 5) 7)) (make-rolling-lambda WIDTH -7)) ;bounces when reaching edge
(check-expect (next-rolling-lambda (make-rolling-lambda 5 -8)) (make-rolling-lambda 0 8))

;(define (next-rolling-lambda rl) RL1) ;stub

;<use template from RollingLambda
(define (next-rolling-lambda rl)
  (cond [(> (+ (rolling-lambda-x rl) (rolling-lambda-dx rl)) WIDTH) (make-rolling-lambda WIDTH (- (rolling-lambda-dx rl)))]
        [(< (+ (rolling-lambda-x rl) (rolling-lambda-dx rl)) 0) (make-rolling-lambda 0 (- (rolling-lambda-dx rl)))]
        [else (make-rolling-lambda (+ (rolling-lambda-x rl) (rolling-lambda-dx rl)) (rolling-lambda-dx rl))]))

;; RollingLambda -> Image
;; render a lamda at its x-position on MTS

(check-expect (render-lambda RL1) (place-image (rotated-lambda RL1) 30 LAMBDA-Y MTS))
(check-expect (render-lambda RL2) (place-image (rotated-lambda RL2) 160 LAMBDA-Y MTS))

;(define (render-lambda rl) MTS) ;stub

;<use template from RollingLambda
(define (render-lambda rl)
  (place-image (rotated-lambda rl) (rolling-lambda-x rl)  LAMBDA-Y MTS))

;; RollingLambda -> Image
;; rotate the lamba
(check-expect (rotated-lambda RL1) (rotate (modulo (* 30 ROTATION-PER-PIXEL) 360) LAMBDA-IMG))
(check-expect (rotated-lambda RL2) (rotate (modulo (* 160 ROTATION-PER-PIXEL) 360) LAMBDA-IMG))

;(define (rotate-lambda rl) LAMBDA-IMG)  ;stub

;<use template from RollingLambda
(define (rotated-lambda rl)
(rotate (modulo (* (rolling-lambda-x rl) ROTATION-PER-PIXEL) 360) LAMBDA-IMG))


;; RollingLambda Integer Integer MouseEvent -> RollingLambda
;; Clicking the mouse changes the direction the RollinagLambda is rolling
(check-expect (handle-mouse RL1 30 50 "button-down") (make-rolling-lambda 30  (- (rolling-lambda-dx RL1)))) 
(check-expect (handle-mouse RL2 30 50 "button-down") (make-rolling-lambda 160 (- (rolling-lambda-dx RL2)))) 
                                                                         
(define (handle-mouse rl x y me)
  (cond [(mouse=? me "button-down") (make-rolling-lambda (rolling-lambda-x rl) (- (rolling-lambda-dx rl)))]
        [else rl]))