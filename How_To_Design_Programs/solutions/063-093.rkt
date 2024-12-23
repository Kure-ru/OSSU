;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 063-093) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;  Exercise 63
; 
; Evaluate the following expressions:
; (distance-to-0 (make-posn 3 4))
; (distance-to-0 (make-posn 6 (* 2 4)))
; (+ (distance-to-0 (make-posn 12 5)) 10)


; Exercise 64
; 
; Design the function manhattan-distance, which measures the Manhattan distance of the given posn to the origin. 



;; Position -> Natural
;; Calculate the Manhattan distance from posn to origin.
(check-expect (manhattan-distance (make-posn 6 2))   8)
(check-expect (manhattan-distance (make-posn 10 5)) 15)

;(define (manhattan-distance pos1 pos2) 0)

(define (manhattan-distance pos1)
  (+ (posn-x pos1) (posn-y pos1)))

;  Exercise 65
; 
; Take a look at the following structure type definitions:
; (define-struct movie [title producer year])
; 
; (define-struct person [name hair eyes phone])
; 
; (define-struct pet [name number])
; 
; (define-struct CD [artist title price])
; 
; (define-struct sweater [material size producer])


;  Exercise 66
; Revisit the structure type definitions of exercise 65.
; Make sensible guesses as to what kind of values go with which fields. Then create at least one instance per structure type definition. 


(define-struct movie (title producer year))
;; make-movie
;; movie-title, movie-producer, movie-year
;; movie?
(define last-seen-movie (make-movie "Leurs enfants après eux" "Ludovic Boukherma" "2024"))

(define-struct person (name hair eyes phone))
;; make-person
;; person-name, person-hair, person-eyes, person-phone
;; person?
(define santa (make-person "Santa Clauss" "white" "blue" "605-313-4000"))

(define-struct pet (name number))
;; make-pet
;; pet-name, pet-number
;; pet?
(define pongo (make-pet "Pongo" 1))

(define-struct CD (artist title price))
;; make-CD
;; CD-artist, CD-title, CD-price
;; CD?
(define best-sold-cd (make-CD "Michael Jackson" "Thriller" 10))

(define-struct sweater (material size producer))
;; make-sweater
;; sweater-material, sweater-size, sweater-producer
;; sweater?
(define red-sweater (make-sweater "wool" "M" "Zara"))

;  Exercise 67
; 
; Here is another way to represent bouncing balls. Interpret this code fragment and create other instances of balld. 


;(define SPEED 3)
(define-struct balld [location direction])

;; Balld is (make-balld Number String)
;; interp. (make-balld location direction) is a bouncing ball with
;;   location in pixels from the top of the canvas
;;   direction ("up" / "down")
(make-balld 10 "up")
(make-balld 45 "down")

;  Exercise 68
; 
; An alternative to the nested data representation of balls uses four fields to keep track of the four properties:
; (define-struct ballf [x y deltax deltay])
; 
; Programmers call this a flat representation. Create an instance of ballf that has the same interpretation as ball1. 


(define-struct ballf [x y deltax deltay])

(make-ballf 10 96 -5 -5)

;  Exercise 69
; 
; Draw box representations for the solution of exercise 65. 


;  Exercise 70
; 
; Spell out the laws for these structure type definitions:
; (define-struct centry [name home office cell])
; (define-struct phone [area number])


;; (centry-name (make-centry "n1" "h1" "o1" "c1")) == "n1"
;; (centry-home (make-centry "n1" "h1" "o1" "c1")) == "h1"
;; (centry-office (make-centry "n1" "h1" "o1" "c1")) == "o1"
;; (centry-cell (make-centry "n1" "h1" "o1" "c1")) == "c1"

;; (phone-area (make-phone "a1" "n1")) == "a1"
;; (phone-number (make-phone "a1" "n1")) == "n1"

;  Exercise 71
; Place the following into DrRacket’s definitions area:
; Click RUN and evaluate the following expressions.



; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))
 
(define-struct game [left-player right-player ball])
 
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))


(game-ball game0)
(posn? (game-ball game0))
(game-left-player game0)

;  Exercise 72
; 
; Formulate a data definition for the above phone structure type definition that accommodates the given examples.
; 
; Next formulate a data definition for phone numbers using this structure type definition:
; (define-struct phone# [area switch num])
; 
; Historically, the first three digits make up the area code, the next three the code for the phone switch (exchange) of your neighborhood,
; and the last four the phone with respect to the neighborhood. Describe the content of the three fields as precisely as possible with intervals. 


;; Phone is a structure:
;;  (make-phone Integer[000, 999] Integer[000, 999] Integer[0000, 9999])
;; interp. a phone number, with:
;;         area: the area code
;;         switch: the phone exchange of the neighbourhood
;;         num: the phone with respect to the neighbourhood

;  Exercise 73
; 
; Design the function posn-up-x, which consumes a Posn p and a Number n. It produces a Posn like p with n in the x field.


;; Posn Number -> Posn
;; produces a posn with n in the x field
;(check-expect (posn-up-x (make-posn 3 4)     5) (make-posn   5  4))
;(check-expect (posn-up-x (make-posn 42 93) 183) (make-posn 183 93))
;
;(define (posn-up-x p n)
;  (make-posn n (posn-y p)))

;  Exercise 74
; 
; Copy all relevant constant and function definitions to DrRacket’s definitions area. Add the tests and make sure they pass.
; Then run the program and use the mouse to place the red dot. 


(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
; A Posn represents the state of the world.
 
; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))

; Posn -> Image
; adds a red spot to MTS at p
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))

(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

; Posn -> Posn
; increases the x-coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))

(define (x+ p)
  (posn-up-x p (+ (posn-x p) 3)))

;; Posn Number -> Posn
;; produces a posn with n in the x field
(check-expect (posn-up-x (make-posn 3 4)     5) (make-posn   5  4))
(check-expect (posn-up-x (make-posn 42 93) 183) (make-posn 183 93))

(define (posn-up-x p n)
  (make-posn n (posn-y p)))

; Posn Number Number MouseEvt -> Posn 
; for mouse clicks, (make-posn x y); otherwise p
(check-expect
 (reset-dot (make-posn 10 20) 29 31 "button-down")
 (make-posn 29 31))
(check-expect
 (reset-dot (make-posn 10 20) 29 31 "button-up")
 (make-posn 10 20))

(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))

;  Exercise 75
; 
; Enter these definitions and their test cases into the definitions area of DrRacket and make sure they work.
; This is the first time that you have dealt with a “wish,” and you need to make sure you understand how the two functions work together. 


(define-struct ufo [loc vel])
; A UFO is a structure: 
;   (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location
; p moving at velocity v

(define-struct vel (deltax deltay))
;; A Vel is a structure:
;;   (make-vel Number Number)
;; interpretation (make-vel dx dy) is the
;; change in x direction in pixels [per clock tick], and
;; change in y direction in pixels [per clock tick]

(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))

; UFO -> UFO
; determines where u moves in one clock tick; 
; leaves the velocity as is
 
(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))
 
(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))


; Posn Vel -> Posn 
; adds v to p
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))

(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))

;  Exercise 77
; 
; Provide a structure type definition and a data definition for representing points in time since midnight.
; A point in time consists of three numbers: hours, minutes, and seconds. 


(define-struct time-struct (hours minutes seconds))
;; A Time is a structure:
;;   (make-point Integer Interger Number)
;; interp. a point in time since midnight
;;         includes the number of hours, minutes and seconds
;;         since midnight

;  Exercise 78
; 
; Provide a structure type and a data definition for representing three-letter words. A word consists of lowercase letters, represented with
; the 1Strings "a" through "z" plus #false.


(define-struct 3word (first second third))
;; A 3Word is a structure:
;;   (make-3word 1String/false 1String/false 1String/false)
;; interp. a three-letter word, which consists of lowercase
;;         letters represented with 1Strings, "a" through "z"
;;         or #false if no letter fills that position

;  Exercise 79
; 
; Create examples for the following data definitions:



; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

(define WHITE "white")
(define YELLOW "yellow")
(define ORANGE "orange")

;; ===================================

; H is a Number between 0 and 100.
; interpretation represents a happiness value

(define H1   0)
(define H2  49)
(define H3 100)

;; ===================================

;(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)

;(define P1 (make-person "Linus" "Torvalds" #true))
;(define P2 (make-person "Barbara" "Liskov" #false))

;; ===================================

;(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
; interp. a dog. A dog has:
;         an owner, a Person (make-person String String Boolean)
;         a name, an age and a happiness level, H, Number[0, 100]

;(define D1 (make-dog P1 "Toby" 4 100))
;(define D2 (make-dog
;            (make-person "Bob" "Bobber" #true)
;            "Simba"
;            2
;            99))

;; ====================================

; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight

(define W1 false)
(define W2 (make-posn 3 6))


;  Exercise 80
; 
; Create templates for functions that consume instances of the following structure types:


;(define-struct movie (title director year))
#;
(define (fn-for-movie m)
  (... (movie-title    m)
       (movie-director m)
       (movie-year     m)))

;(define-struct pet (name number))
#;
(define (fn-for-pet p)
  (... (pet-name   p)
       (pet-number p)))

;(define-struct CD (artist title price))
#;
(define (fn-for-CD cd)
  (... (CD-artist cd)
       (CD-title  cd)
       (CD-price  cd)))


;(define-struct sweater (material size color))
#;
(define (fn-for-sweater s)
  (... (sweater-material s)
       (sweater-size     s)
       (sweater-color    s)))
  
;  Exercise 81
; 
; Design the function time->seconds, which consumes instances of time structures (see exercise 77)
; and produces the number of seconds that have passed since midnight. For example, if you are representing 12 hours,
; 30 minutes, and 2 seconds with one of these structures and if you then apply time->seconds to this instance, the correct result is 45002. 



;; Time -> Natural
;; consumes a Time and produces the equivalent in seconds
(check-expect (time->seconds (make-time-struct 0 0 30)) 30)
(check-expect (time->seconds (make-time-struct 0 30 0)) 1800)
(check-expect (time->seconds (make-time-struct 1 0 0)) 3600)
(check-expect (time->seconds (make-time-struct 12 30 2)) 45002)


;(define (time->seconds t) 0)
(define (time->seconds t)
  (+ (* 3600 (time-struct-hours t))
     (* 60 (time-struct-minutes t))
     (time-struct-seconds t)))

;  Exercise 82
; 
; Design the function compare-word. The function consumes two three-letter words (see exercise 78).
; It produces a word that indicates where the given ones agree and disagree. The function retains the content of the structure
; fields if the two agree otherwise it places #false in the field of the resulting word.


;(define-struct 3word (first second third))
;; A 3Word is a structure:
;;   (make-3word 1String/false 1String/false 1String/false)
;; interp. a three-letter word, which consists of lowercase
;;         letters represented with 1Strings, "a" through "z"
;;         or #false if no letter fills that position

;; 3Word 3Word -> 3Word
;; consumes 2 3Word, produce a new 3Word with common letters of the input, or false it the letters differ
(check-expect (compare-word (make-3word "c" "a" "t") (make-3word "c" "a" "r")) (make-3word "c" "a" false))
(check-expect (compare-word (make-3word "r" "e" "d") (make-3word "r" "e" "d")) (make-3word "r" "e" "d"))
(check-expect (compare-word (make-3word "b" "o" "y") (make-3word "r" "a" "t")) (make-3word false false false))

;(define (compare-word w1 w2) (make-3word false false false))

(define (compare-word w1 w2)
  (make-3word 
   (if (string=? (3word-first w1) (3word-first w2))
       (3word-first w1)
       false)
   (if (string=? (3word-second w1) (3word-second w2))
       (3word-second w1)
       false)
   (if (string=? (3word-third w1) (3word-third w2))
       (3word-third w1)
       false)))

;   Exercise 88
; 
; Define a structure type that keeps track of the cat’s x-coordinate and its happiness.
; Then formulate a data definition for cats, dubbed VCat, including an interpretation. 


(define-struct tracker (x h))
;; Tracker is (make-tracker Number[0, WIDTH] Number[0, 100])
;; interp. tracker tracks x coordinates and level of hapiness of a cat
;; x is Natural[0, WIDTH]
;; h is Natural [0, 100]

(define-struct VCat (tracker img))
;; VCat is (make-vcat Tracker Image)
;; interp a cat with it's representation, and data on its position on the screen and level of hapiness

;  Exercise 89
; 
; Design the happy-cat world program, which manages a walking cat and its happiness level.
; Let’s assume that the cat starts out with perfect happiness.


;; --------------
;; Constants

(define BG-WIDTH 600)
(define BG-HEIGHT 300)
(define BG (empty-scene BG-WIDTH BG-HEIGHT))

(define CAT-Y (/ BG-HEIGHT 2))
(define SPEED 3)
(define HAP-RATE 0.1)

(define MAX-HAPPINESS 100)
(define MIN-HAPPINESS 0)

(define CAT1 .)
(define CAT2 . )

;; -----------
;; Functions:

;; VCat -> VCat
(define (happy-cat vcat)
  (big-bang vcat
    (on-tick update-cat)
    (to-draw render-world)
    (stop-when happiness0?)))

;; Number -> Number
;; decrease happiness score by HAP-RATE
(check-expect (decrease-happiness 100) (- 100 0.1))
(check-expect (decrease-happiness  50) (- 50  0.1))
(check-expect (decrease-happiness   0)           0)

(define (decrease-happiness h)
  (if (> h 0)
      (- h HAP-RATE)
      0))

;; Number -> Number
;; Move the cat by `SPEED` pixels and wrap around
(check-expect (move-cat  597) 0)
(check-expect (move-cat  0)   3)

(define (move-cat x-pos)
  (modulo (+ x-pos SPEED) BG-WIDTH))

;; Tracker -> Tracker
;; Update the cat position and hapiness
(define (update-cat t)
  (make-tracker  (move-cat (tracker-x t)) (decrease-happiness (tracker-h t))))

;; VCat -> Image
;; Render the scene with the moving cat and happiness gauge
(check-expect (render-world (make-tracker 0 50))
              (place-image CAT2 0 CAT-Y (render-gauge 50)))
(check-expect (render-world (make-tracker 3 75))
              (place-image CAT1 3 CAT-Y (render-gauge 75)))

(define (render-world tracker)
  (place-image (choose-image (tracker-x tracker))
               (tracker-x tracker) CAT-Y
               (render-gauge (tracker-h tracker))))

;; Number -> Image
;; Select CAT1 or CAT2 based on the x-coordinate
(define (choose-image x)
  (if (odd? x) CAT1 CAT2))

;; Number -> Image
;; Render a vertical gauge proportional to the happiness level
(define (render-gauge h)
  (overlay/align "middle" "bottom"
                 (above (rectangle 50 (* h (/ MAX-HAPPINESS MAX-HAPPINESS))
                                   "solid" "red")
                        (square 10 "solid" "black"))
                 BG))

;; Tracker KeyEvent -> Tracker
;; Update the happiness level based on the key press
(check-expect (update-happiness (make-tracker 0 50) "up") 
              (make-tracker 0 65))  ;; Happiness increases by 30%

(check-expect (update-happiness (make-tracker 0 50) "down") 
              (make-tracker 0 60)) ;; Happiness increases by 20%

(check-expect (update-happiness (make-tracker 0 50) "b") 
              (make-tracker 0 50)) ;; No valid key press, happiness remains unchanged


(define (update-happiness tracker key)
  (make-tracker (tracker-x tracker)
                (cond [(key=? key "up")   (min (+ (tracker-h tracker) (* 0.3 (tracker-h tracker))) MAX-HAPPINESS)]
                      [(key=? key "down") (min (+ (tracker-h tracker) (* 0.2 (tracker-h tracker))) MAX-HAPPINESS)]
                      [else (tracker-h tracker)])))

;; Tracker -> Boolean
;; produces true if happiness is equal or below 0
(check-expect (happiness0? (make-tracker 0 65)) false)
(check-expect (happiness0? (make-tracker 0 0)) true) 

;(define (happiness0? t) false)
(define (happiness0? t)
  (>= 0 (tracker-h t)))

;  Exercise 92
; 
; Design the cham program, which has the chameleon continuously walking across the canvas from left to right.
; When it reaches the right end of the canvas, it disappears and immediately reappears on the left.
; Like the cat, the chameleon gets hungry from all the walking, and, as time passes by, this hunger expresses itself as unhappiness.


;  Exercise 93
; 
; Copy your solution to exercise 92 and modify the copy so that the chameleon walks across a tricolor background. 



;; Constants
(define WIDTH 200)
(define HEIGHT 400)
(define CHAM-Y (/ HEIGHT 2))
(define SPEED 3)
(define HAP-RATE 0.1)

(define MTS
  (beside (empty-scene WIDTH HEIGHT "green")
          (empty-scene WIDTH HEIGHT "white")
          (empty-scene WIDTH HEIGHT   "red")))


(define CHAM-IMG .)


(define-struct track (x hap))
;; A Track is a structure:
;;   (make-track Number Number[0, 100])
;; interp. keeps track of a cham's changing variables
;;         x is the x-coordinate of the car on the screen
;;         hap is its happiness

;; Color is one of:
;;  - "w"
;;  - "r"
;;  - "b"
;;  - "g"
;; interp. the colors a chameleon can take on

(define-struct vcham (color img track))
;; A VCham is a structure:
;;   (make-vcham Color Image Track)
;; interp. a virtual chameleon, including its color, image and
;;         information about its movement and happiness

(define CHAM (make-vcham "w" CHAM-IMG (make-track 125 100)))

; A VCham is the world state


; VCham -> VCham
; moves the vcham three pixels per clock tick
(check-expect (tock CHAM) (make-vcham (vcham-color CHAM)
                                      (vcham-img CHAM)
                                      (make-track (+ 125 SPEED)
                                                  (- 100 HAP-RATE))))

(define (tock vc)
  (make-vcham (vcham-color vc)
              (vcham-img   vc)
              (make-track (+ (track-x   (vcham-track vc)) SPEED)
                          (- (track-hap (vcham-track vc)) HAP-RATE))))

; VCham -> Image
; renders the image of the vcham; if the vcham disappears
; on the right, it reappears on the left
(check-expect (render CHAM)
              (place-image (vcham-img CHAM)
                           (track-x (vcham-track CHAM))
                           CHAM-Y MTS))
(check-expect (render (make-vcham "w" CHAM-IMG
                                  (make-track (+ (* WIDTH 3)
                                                 (image-width CHAM-IMG))
                                              100)))
              (place-image CHAM-IMG
                           0
                           CHAM-Y MTS))

(define (render vc)
  (if (>= (track-x (vcham-track vc))
          (+ (* WIDTH 3) (image-width (vcham-img vc))))
      (place-image (vcham-img vc)
                   (modulo (track-x (vcham-track vc))
                           (+ (* WIDTH 3) (image-width (vcham-img vc))))
                   CHAM-Y MTS)
      (place-image (vcham-img vc)
                   (track-x (vcham-track vc))
                   CHAM-Y MTS)))

; VCham KeyEvent -> VCham
; make the chameleon happy by feeding it (down arrow)
; happiness goes up two points
(check-expect (handle-key CHAM "down") CHAM)
(check-expect (handle-key CHAM "up")   CHAM)
(check-expect (handle-key (make-vcham "w"
                                      CHAM-IMG
                                      (make-track 135 65)) "up")
              (make-vcham "w" CHAM-IMG (make-track 135 65)))
(check-expect (handle-key (make-vcham "w" CHAM-IMG
                                      (make-track 135 65)) "down")
              (make-vcham "w" CHAM-IMG
                          (make-track 135 (+ 65 2))))

(define (handle-key vc ke)
  (cond
    [(and (string=? ke "down")
          (< (track-hap
              (vcham-track vc))
             100))              (make-vcham (vcham-color vc)
                                            (vcham-img vc)
                                            (make-track (track-x (vcham-track vc))
                                                        (+ (track-hap (vcham-track vc))
                                                           2)))]
    [else vc]))

(define (happy-cham vc)
  (big-bang vc
    [to-draw render]
    [on-tick tock]
    [on-key  handle-key]))