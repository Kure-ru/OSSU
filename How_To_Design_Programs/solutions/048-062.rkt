;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 048-062) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;  Exercise 48
; 
; Enter the definition of reward followed by (reward 18) into the definitions area of DrRacket and use
; the stepper to find out how DrRacket evaluates applications of the function. 


(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))

(reward 18)

;   Exercise 49
; 
; Reformulate create-rocket-scene.v5 to use a nested expression, the resulting function mentions place-image only once. 


;(define WIDTH  100)
;(define HEIGHT  60)
;(define MTSCN  (empty-scene WIDTH HEIGHT))
;(define ROCKET .)
;(define ROCKET-CENTER-TO-TOP
;  (- HEIGHT (/ (image-height ROCKET) 2)))
; 
;(define (create-rocket-scene.v5 h)
;   (place-image ROCKET 50 (cond [(<= h ROCKET-CENTER-TO-TOP) h]
;                               [else ROCKET-CENTER-TO-TOP]) MTSCN))

;  Exercise 50
; 
; If you copy and paste the above function definition into the definitions area of DrRacket and click RUN,
; DrRacket highlights two of the three cond lines. This coloring tells you that your test cases do not cover
; the full conditional. Add enough tests to make DrRacket happy. 


; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

;  Exercise 51.
; 
; Design a big-bang program that simulates a traffic light for a given duration.
; The program renders the state of a traffic light as a solid circle of the appropriate color,
; and it changes state on every clock tick. What is the most appropriate initial state?
; Ask your engineering friends


(define HEIGHT 150)
(define MTS (empty-scene 150 HEIGHT "black"))
(define LIGHT-SIZE 50)

;; WS -> WS
;; start the world with (traffic-light "red")
(define (traffic-light tl)
  (big-bang tl                   ; WS
    (on-tick   tock 1)     ; WS -> WS
    (to-draw   render)))   ; WS -> Image

;; WS -> WS
;; produce the next traffic light state
(define (tock tl)
  (traffic-light-next tl))

;; WS -> Image
;; render the correct traffic light 
(check-expect (render "green") (place-image (circle LIGHT-SIZE "solid" "green")
                                            (/ HEIGHT 2) (/ HEIGHT 2)
                                            MTS))
;(define (render tl) MTS)

(define (render tl)
  (place-image (circle LIGHT-SIZE "solid" tl)
               (/ HEIGHT 2) (/ HEIGHT 2)
               MTS))

;  Exercise 52
; 
; Which integers are contained in the four intervals above?
; 
; [3, 5]: Includes integers 3, 4, 5.
; (3, 5]: Includes integers 4, 5 (excludes 3).
; [3, 5): Includes integers 3, 4 (excludes 5).
; (3, 5): Includes integer 4 (excludes 3 and 5).


;  Exercise 53
; 
; The design recipe for world programs demands that you translate information into data and vice versa to ensure a complete understanding of the data definition.
; It’s best to draw some world scenarios and to represent them with data and, conversely, to pick some data examples and to draw pictures that match them.
; Do so for the LR definition, including at least HEIGHT and 0 as examples. 


(define RHEIGHT 300) ; distances in pixels 
(define RWIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene RWIDTH RHEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

; LRCD -> LRCD
;(define (main1 s)
;  (big-bang s
;    [to-draw show]
;    [on-key launch]))


; Exercise 54
; 
; Why is (string=? "resting" x) incorrect as the first condition in show? Conversely, formulate a completely accurate condition, that is, a Boolean expression
; that evaluates to #true precisely when x belongs to the first sub-class of LRCD. 
; 
; 


; LRCD -> Image
; renders the state as a resting or flying rocket
;(check-expect (show "resting") (to-show RHEIGHT))
;(check-expect (show "resting") (to-show RHEIGHT))
;(check-expect (show -2) (place-image (text "-2" 20 "red")
;                                     10 (* 3/4 RWIDTH)
;                                     (to-show RHEIGHT)))
;(check-expect (show 53) (to-show 53))
;(check-expect (show RHEIGHT) (to-show (- RHEIGHT CENTER)))
;(check-expect (show 53) (to-show (- 53 CENTER)))
;
;(define (show x)
;  (cond
;    [(string? x) (to-show (- RHEIGHT CENTER))]
;    [(<= -3 x -1)
;     (place-image (text (number->string x) 20 "red")
;                  10 (* 3/4 RWIDTH)
;                  (to-show (- RHEIGHT CENTER)))]
;    [(>= x 0) (to-show (- x CENTER))]))

; Exercise 55
; 
; Take another look at show. It contains three instances of an expression with the approximate shape:
; (place-image ROCKET 10 (- ... CENTER) BACKG)
; 
; This expression appears three times in the function: twice to draw a resting rocket and once to draw a flying rocket.
; Define an auxiliary function that performs this work and thus shorten show. Why is this a good idea?


(define (to-show y-pos)
  (place-image ROCKET 10 y-pos BACKG))

; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed, 
; if the rocket is still resting
;(define (launch x ke) x)
 
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

; Exercise 56
; 
; Define main2 so that you can launch the rocket and watch it lift off.


; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

; Exercise 57
; 
; Recall that the word “height” forced us to choose one of two possible interpretations. Now that you have solved the exercises in this section,
; solve them again using the first interpretation of the word. Compare and contrast the solutions. 


;(define (to-show y-pos)
;  (place-image ROCKET 10 (- RHEIGHT y-pos) BACKG))
;
;(define (show x)
;  (cond
;    [(string? x) (to-show 0)]
;    [(<= -3 x -1)
;     (place-image
;       (text (number->string x) 20 "red")
;       10 (* 3/4 RWIDTH)
;       (to-show 0))]
;    [(>= x 0) (to-show x)]))
;
;(define (fly x)
;  (cond
;    [(string? x) x]
;    [(<= -3 x -1) (if (= x -1) 0 (+ x 1))]
;    [(>= x 0) (+ x YDELTA)]))
;
;(define (launch x ke)
;  (cond
;    [(string? x) (if (string=? " " ke) -3 x)]
;    [else x]))
;
;(define (main2 s)
;  (big-bang s
;    [to-draw show]
;    [on-key launch]
;    [on-tick fly]))

;  Exercise 58
; 
; Introduce constant definitions that separate the intervals for low prices and luxury prices from the others so that the legislators in Tax Land can easily
; raise the taxes even more. 


; A Price falls into one of three intervals: 
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item

; Price -> Number
; computes the amount of tax charged for p
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 1282) 64.1)
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 12017) (* 0.08 12017))

;(define (sales-tax p) 0)

#;
(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000)) ...]
    [(and (<= 1000 p) (< p 10000)) ...]
    [(>= p 10000) ...]))

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000)) 0]
    [(and (<= 1000 p) (< p 10000)) (* 0.05 p)]
    [(>= p 10000) (* 0.08 p)]))

;  Exercise 59
; 
; Finish the design of a world program that simulates the traffic light FSA.


; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

(define TL_HEIGHT 30)
(define WIDTH 90)
(define SCALE (/ TL_HEIGHT 10))
(define RADIUS (/ TL_HEIGHT SCALE))
(define BG (empty-scene WIDTH TL_HEIGHT))
(define SPACE (rectangle (* SCALE SCALE) SCALE "solid" "white"))

; Mode Color -> Bulb
; A Bulb is one of:
; - outline
; - solid
; interpretation returns a bulb based on the color and mode of
; the bulb
(check-expect (bulb "outline" "red")
              (circle RADIUS "outline" "red"))
(check-expect (bulb "solid" "green")
              (circle RADIUS "solid" "green"))
(define (bulb mode color)
  (circle RADIUS mode color))

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next "red") "green")
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next "green") "yellow")
(define (tl-next cs)
  (cond
    [(string=? cs "red") "green"]
    [(string=? cs "yellow") "red"]
    [(string=? cs "green") "yellow"]))
 
; TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render "red")
              (place-image (beside (bulb "solid" "red")
                                   SPACE
                                   (bulb "outline" "yellow")
                                   SPACE
                                   (bulb "outline" "green"))
                           45 15
                           BG))
(check-expect (tl-render "yellow")
              (place-image (beside (bulb "outline" "red")
                                   SPACE
                                   (bulb "solid" "yellow")
                                   SPACE
                                   (bulb "outline" "green"))
                           45 15
                           BG))
(define (tl-render cs)
  (place-image
   (beside (if (string=? cs "red")
               (bulb "solid" "red")
               (bulb "outline" "red"))
           SPACE
           (if (string=? cs "yellow")
               (bulb "solid" "yellow")
               (bulb "outline" "yellow"))
           SPACE
           (if (string=? cs "green")
               (bulb "solid" "green")
               (bulb "outline" "green")))
   45 15
   BG))

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

; Exercise 62
; 
; During a door simulation the “open” state is barely visible. Modify door-simulation so that the clock ticks once every three seconds. Rerun the simulation. 



(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN     "open")

; A DoorState is one of:
; - LOCKED
; - CLOSED
; - OPEN

; DoorState -> DoorState
; closes an open door over the period of one tick
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN)   CLOSED)

(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN   state-of-door) CLOSED]))

; DoorState KeyEvent -> DoorState
; turns key event k into an action on state s
(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)
 
(define (door-action s k)
  (cond
    [(and (string=? LOCKED s) (string=? "u" k)) CLOSED]
    [(and (string=? CLOSED s) (string=? "l" k)) LOCKED]
    [(and (string=? CLOSED s) (string=? " " k))   OPEN]
    [else s]))

; DoorState -> Image
; translates the state s into a large text image
(check-expect (door-render CLOSED)
              (text CLOSED 40 "pink"))

(define (door-render s)
  (text s 40 "pink"))

; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key door-action]
    [to-draw door-render]))