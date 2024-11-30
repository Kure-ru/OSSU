;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 033-047) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; Exercise 33
; 
; Research the “year 2000” problem. 


; Exercise 34
; 
; Design the function string-first, which extracts the first character from a non-empty string. Don’t worry about empty strings. 


; String -> 1String
; interp. extract the first character of the given string. ASSUME the string is not empty.
; given: "hello", expect: "h"
; given: "bye", expect: "b"

;(define (string-first str) "a")

#;
(define (string-first str) ;template
  (... str))

(define (string-first str)
  (substring str 0 1))

(string-first "hello")
(string-first "bye")

; Exercise 35
; 
; Design the function string-last, which extracts the last character from a non-empty string.


; String -> 1String
; interp. extract the last character of the given string. ASSUME the string is not empty.
; given: "hello", expect: "o"
; given: "bye", expect: "e"

;(define (string-last str) "a")

#;
(define (string-last str) ;template
  (... str))

(define (string-last str)
  (substring str (- (string-length str) 1)))

(string-last "hello")
(string-last "bye")

;  Exercise 36
; 
; Design the function image-area, which counts the number of pixels in a given image. 


; Image -> Number
; interp. the number of pixel (width * height) of a given image
; given (rectangle 10 2 "solid" "red"), expect 20
; given (square 5 "solid" "green") expect 25

;(define (image-area img) 0)

#;
(define (image-area img)
  (... img))

(define (image-area img)
  (* (image-height img) (image-width img)))

(image-area (rectangle 10 2 "solid" "red"))
(image-area (square 5 "solid" "green"))

;  Exercise 37
; 
; Design the function string-rest, which produces a string like the given one with the first character removed. 


; String -> String
; interp. produce a given string without its first character.
; given: "hello", expect: "ello"
; given: "bye", expect: "ye"

;(define (string-rest str) "a")

#;
(define (string-rest str) ;template
  (... str))

(define (string-rest str)
  (substring str 1))

(string-rest "hello")
(string-rest "bye")

;  Exercise 38
; 
; Design the function string-remove-last, which produces a string like the given one with the last character removed.


; String -> String
; interp. produce a given string without its last character.
; given: "hello", expect: "hell"
; given: "bye", expect: "by"

;(define (string-remove-last str) "a")

#;
(define (string-remove-last str) ;template
  (... str))

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

(string-remove-last "hello")
(string-remove-last "bye")

;  Exercise 39
; 
; Develop your favorite image of an automobile so that WHEEL-RADIUS remains the single point of control.


;; Constants
(define WHEEL-RADIUS 5)
(define WHEEL-DIAMETER (* WHEEL-RADIUS 2))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define TWO-WHEELS
  (underlay/offset WHEEL (* WHEEL-DIAMETER 2) 0 WHEEL))

(define CAR-COLOR "magenta")
(define CAR-BODY
  (rectangle (* WHEEL-DIAMETER 4) WHEEL-DIAMETER "solid" CAR-COLOR))

(define CAR-BODY-TOP
  (rectangle (* WHEEL-DIAMETER 2) WHEEL-DIAMETER "solid" CAR-COLOR))

(define CAR
  (underlay/offset CAR-BODY-TOP
                   0 (* WHEEL-RADIUS 2)
                   (underlay/offset CAR-BODY
                                    0 WHEEL-RADIUS
                                    TWO-WHEELS)))

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))


(define BACKGROUND-WIDTH  300)
(define BACKGROUND-HEIGHT 150)
(define BACKGROUND
  (overlay/align "middle" "bottom"
                 TREE
                 (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT)))

(define Y-CAR  (- BACKGROUND-HEIGHT (/ (image-height CAR) 2)))
(define X-CAR-STOP (+ BACKGROUND-WIDTH (/ (image-width CAR) 2) 1))

;; Functions

; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [on-mouse hyper]
    [stop-when end?]))

; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define (tock ws)
  (+ ws 3))

; Exercise 40
; 
; Formulate the examples as BSL tests, that is, using the check-expect form. Introduce a mistake. Re-run the tests. 


; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state
(check-expect (render 10) (place-image CAR 10 Y-CAR BACKGROUND))

(define (render ws)
  (place-image CAR ws Y-CAR BACKGROUND))

; Exercise 41
; 
; Finish the sample problem and get the program to run.


;; WorldState -> Boolean
;; When the car disappears on the right border of the screen, stop the animation.
(check-expect (end? 400)  true)
(check-expect (end?  30) false)

(define (end? ws)
  (> ws X-CAR-STOP))

;  Exercise 42
; 
; Modify the interpretation of the sample data definition so that a state denotes the x-coordinate of the right-most edge of the car. 


;  Exercise 43
; 
; Design a program that moves a car across the world canvas, from left to right, at the rate of three pixels per clock tick.
; If the mouse is clicked anywhere on the canvas, the car is placed at the x-coordinate of that click.


; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down"
(check-expect (hyper 20 10 20 "enter") 20)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)

(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))

;  Exercise 44
; 
; Formulate the examples as BSL tests. Click RUN and watch them fail. 


;  Exercise 45
; 
; Design a “virtual cat” world program that continuously moves the cat from left to right. Let’s call it cat-prog and let’s assume it consumes
; the starting position of the cat. Furthermore, make the cat move three pixels per clock tick. Whenever the cat disappears on the right,
; it reappears on the left. You may wish to read up on the modulo function. 


;; =================
;; Constants:

(define cat1 .)
(define cat2  .)

(define BG-WIDTH  600)
(define BG-HEIGHT 300)

(define BACKGROUND-IMG (empty-scene BG-WIDTH BG-HEIGHT))
(define CAT-X-STOP (+ BG-WIDTH (* 2 (image-width cat1))))
(define CAT-Y  BACKGROUND-HEIGHT)
(define SPEED 3)

;; =================
;; Functions:

;; WS -> WS
;; start the world with ...
;; 
(define (cat-prog ws)
  (big-bang ws                 
    (on-tick   move-cat)
    (to-draw   render-cat)))

;; WS -> WS
;; make the cat move three pixels per clock tick
(check-expect (move-cat  0) (+  0 SPEED))
(check-expect (move-cat 54) (+ 54 SPEED))

(define (move-cat ws)
  (modulo (+ ws SPEED) BG-WIDTH ))

;; WS -> Image
;; render the cat; Whenever the cat disappears on the right, it reappears on the left
(check-expect (render-cat 5) (place-image (choose-image 5) 5 CAT-Y BACKGROUND-IMG)) 
(check-expect (render-cat BG-WIDTH) (place-image (choose-image BG-WIDTH) BG-WIDTH CAT-Y BACKGROUND-IMG))
(check-expect (render-cat (+ CAT-X-STOP 2)) (place-image (choose-image (+ CAT-X-STOP 2)) 0 CAT-Y BACKGROUND-IMG)) 

;(define (render-cat ws) BACKGROUND-IMG)

(define (render-cat ws)
  (cond [(< ws CAT-X-STOP) (place-image (choose-image ws) ws CAT-Y BACKGROUND-IMG)]
        [else  (place-image (choose-image ws) 0 CAT-Y BACKGROUND-IMG)]))

;  Exercise 46
; 
; Adjust the rendering function from exercise 45 so that it uses one cat image or the other based on whether the x-coordinate is odd.


; WS -> Image
; render the correct image of the cat depending on it's position
(check-expect (choose-image 11) cat1)
(check-expect (choose-image 20) cat2)
(check-expect (choose-image 600) cat2)

;(define (choose-image ws) cat1)

(define (choose-image ws)
  (if (odd? ws)
      cat1
      cat2))

;  Exercise 47
; 
; Design a world program that maintains and displays a "happiness gauge."


;; =================
;; Constants:

(define BG (rectangle 70 120 "solid" "black"))
(define GAUGE-COLOR "red")
(define GAUGE-WIDTH 50)
(define MAX-GAUGE-HEIGHT 50)

;; =================
;; Functions:

;; WS -> WS
(define (gauge-prog ws)
  (big-bang ws                   ; WS
    (on-tick   decrease-happiness)     ; WS -> WS
    (to-draw   render-gauge)   ; WS -> Image
    (on-key    increase-happiness)))    ; WS KeyEvent -> WS

;; WS -> Number
;; decrease happiness score by -0.1
(check-expect (decrease-happiness 100) (- 100 0.1))
(check-expect (decrease-happiness  50) (- 50  0.1))
(check-expect (decrease-happiness   0)           0)

(define (decrease-happiness ws)
  (if (> ws 0)
      (- ws 0.1)
      0))

;; WS -> Image
;; render the gauge with correct level of happiness 
(check-expect (render-gauge 100) (overlay/align "middle" "bottom"
                                                (above 
                                                 (rectangle GAUGE-WIDTH 100 "solid" GAUGE-COLOR)
                                                 (square 10 "solid" "black"))
                                                BG))
(check-expect (render-gauge 45) (overlay/align "middle" "bottom"
                                               (above 
                                                (rectangle GAUGE-WIDTH 45 "solid" GAUGE-COLOR)
                                                (square 10 "solid" "black"))
                                               BG))
;(define (render-gauge ws) BG)

(define (render-gauge ws)
  (overlay/align "middle" "bottom"
                 (above 
                  (rectangle GAUGE-WIDTH ws "solid" GAUGE-COLOR)
                  (square 10 "solid" "black"))
                 BG))

; WS KeyEvent -> WS
; increase happiness level to + 1/5 if down arrow key is pressed; increase it to + 1/3 if up arrow key is pressed
(check-expect (increase-happiness 50 "down") (+ 50 (* 50 .2)))
(check-expect (increase-happiness 50    "g")               50)
(check-expect (increase-happiness 50   "up") (+ 50 (* .3 50)))
(check-expect (increase-happiness 50    "g")               50)

(define (increase-happiness ws ke)
  (cond [(key=? ke "down") (+ ws (* .2 50))]
        [(key=? ke "up")   (+ ws (* .3 50))]
        [else ws]))