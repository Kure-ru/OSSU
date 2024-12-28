;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 094-115) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;  Exercise 94
; 
; Draw some sketches of what the game scenery looks like at various stages. Use the sketches to determine the constant and the variable pieces
; of the game. For the former, develop physical and graphical constants that describe the dimensions of the world (canvas) and its objects.
; Also develop some background scenery. Finally, create your initial scene from the constants for the tank, the UFO, and the background. 


(require 2htdp/image)
(require 2htdp/universe)


;; Constants

(define WIDTH 200)
(define HEIGHT 200)
(define MTS (empty-scene WIDTH HEIGHT "black"))

(define MISSILE (rectangle 3 20 "solid" "white"))
(define MISSILE-SPEED 3)
 
(define UFO-TOP (circle 10 "solid" "Dark Turquoise"))
(define UFO-BODY  (ellipse 30 15 "solid" "Dark Turquoise"))
(define UFO (overlay/align "middle" "bottom" UFO-TOP UFO-BODY))
(define UFO-SPEED 1)
(define UFO-NEXT-LINE 20)

(define TANK (above
              (rectangle 20 10 "solid" "Deep Pink")
              (rectangle 40 10 "solid" "Deep Pink")))

(define TANK-HEIGHT (/ (image-height TANK) 2))
(define TANK-Y      (- HEIGHT TANK-HEIGHT))
(define TANK-SPEED 2)

(define HIT-RANGE 15)

;; -------------------
;; Data Definition

(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
 
; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s
(check-expect (missile-render.v2 false MTS) MTS)
(check-expect (missile-render.v2 (make-posn 150 100) MTS)
              (place-image MISSILE 150 100 MTS))


(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)

(define U1 (make-posn (/ WIDTH 2) 45))
(define U2 (make-posn 10 10))
(define U3 (make-posn 150 50))
  
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

(define T1 (make-tank 0 3))
(define T2 (make-tank 50 2))
(define T3 (make-tank 100 6))
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

(define M1 (make-posn 50 45))
(define M2 (make-posn 10 10))
(define M3 (make-posn 150 50))

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

(define SIGS0 (make-sigs (make-posn 20 10)          (make-tank 28 0)   #false)) ; No missile yet
(define SIGS1 (make-sigs (make-posn 20 50)          (make-tank 28 03)  (make-posn 18 (- HEIGHT TANK-HEIGHT)))) ;ufo about to reach earth
(define SIGS2 (make-sigs (make-posn 20 100)         (make-tank 100 3)  (make-posn 22 103)))
(define SIGS3 (make-sigs (make-posn 20 HEIGHT)      (make-tank 100 3)  (make-posn 22 103)))
(define SIGS4 (make-sigs (make-posn (/ WIDTH 2) 30) (make-tank 50  3)  #false))
(define SIGS5 (make-sigs (make-posn (/ WIDTH 2) 30) (make-tank 50 3)   (make-posn 50 (- HEIGHT TANK-HEIGHT))))


;  Exercise 95
; 
; Explain why the three instances are generated according to the first or second clause of the data definition.
; 
; Exercise 96
; 
; Sketch how each of the three game states could be rendered assuming a image canvas.


(define IMG0 (place-image TANK (/ WIDTH 2) TANK-Y    ;missile not yet fired
                          (place-image UFO (/ WIDTH 2) 30 MTS)))
(define IMG1 (place-image TANK (/ WIDTH 2) TANK-Y    ;missile fired
                          (place-image UFO (/ WIDTH 2) 45
                                       (place-image MISSILE 100 100 MTS))))
(define IMG2 (place-image TANK (/ WIDTH 2) TANK-Y    ;missile about to collide with UFO
                          (place-image UFO (/ WIDTH 2) 30
                                       (place-image MISSILE 100 50 MTS))))

;; -----------
;; Functions:

; SIGS -> Image
; renders the given game state on top of BACKGROUND 
(check-expect (si-render (make-sigs (make-posn (/ WIDTH 2) 30)
                                    (make-tank (/ WIDTH 2) TANK-Y )
                                    false))
              IMG0)
(check-expect (si-render (make-sigs (make-posn (/ WIDTH 2) 45)
                                    (make-tank (/ WIDTH 2) TANK-Y )
                                    (make-posn 100 100)))
              IMG1)
(check-expect (si-render (make-sigs (make-posn (/ WIDTH 2) 30)
                                    (make-tank (/ WIDTH 2) TANK-Y )
                                    (make-posn 100 50)))
              IMG2)

;(define (si-render s) MTS) ;stub

(define (si-render s)
  (cond
    [(boolean? (sigs-missile s)) ; no missile
     (place-image TANK (tank-loc (sigs-tank s)) TANK-Y
                  (place-image UFO (posn-x (sigs-ufo s)) (posn-y (sigs-ufo s)) MTS))]
    [(posn? (sigs-missile s)) ; there is a missile
     (place-image TANK (tank-loc (sigs-tank s)) TANK-Y
                  (place-image UFO (posn-x (sigs-ufo s)) (posn-y (sigs-ufo s))
                               (missile-render.v2 (sigs-missile s) MTS)))]))


;  Exercise 97
; 
; Design the functions tank-render, ufo-render, and missile-render.


; Tank Image -> Image 
; adds t to the given image im
(check-expect (tank-render T2 MTS) (place-image TANK 50 TANK-Y MTS))

;(define (tank-render t im) im)
(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))


; UFO Image -> Image 
; adds u to the given image im
(check-expect (ufo-render U3 MTS) (place-image UFO 150 50 MTS))

;(define (ufo-render u im) im)
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))


; Missile Image -> Image 
; adds m to the given image im
(check-expect (missile-render M1 MTS) (place-image MISSILE 50 45 MTS))

;(define (missile-render m im) im)
(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))

;  Exercise 101
; 
; Turn the examples in figure 35 into test cases.


;; Render the missile if it exists
(define (missile-render.v2 m s)
  (cond [(boolean? m) s] ; if there's no missile
        [(posn? m) (place-image MISSILE (posn-x m) (posn-y m) s)])) ; render missile


; Exercise 98
; 
; Design the function si-game-over? for use as the stop-when handler. The game stops if the UFO lands or if the missile hits the UFO.
; For both conditions, we recommend that you check for proximity of one object to another.


;; SIGS -> Boolean
;; produces true if the UFO lands or missile hits the UFO
(check-expect (si-game-over? SIGS0) false)
(check-expect (si-game-over? SIGS1) false)
(check-expect (si-game-over? SIGS2)  true)
(check-expect (si-game-over? SIGS3)  true)

;(define (si-game-over? s) false)

(define (si-game-over? s)
  (or (>= (posn-y (sigs-ufo s)) TANK-Y)    ; UFO has reached the tank
      (close? (sigs-missile s) (sigs-ufo s))))

;; Check if the missile is close enough to hit the UFO
(define (close? m u)
  (if (false? m)
      false
      (<= (distance m u) HIT-RANGE)))

(define (distance u m)
  (inexact->exact (sqrt (+ (sqr (- (posn-y u) (posn-y m)))
                           (sqr (- (posn-x u) (posn-x m)))))))



;; SIGS -> Image
;; renders "Game Over" when the game ends
(check-expect (si-render-final SIGS3)
              (text "GAME OVER" 24 "Deep Pink"))
(check-expect (si-render-final (make-sigs (make-posn 20 HEIGHT) (make-tank 28 -3) false))
              (text "GAME OVER" 24 "Deep Pink"))
(check-expect (si-render-final (make-sigs (make-posn 20 100)
                                          (make-tank 100 3)
                                          (make-posn 20 100)))
              (text "YOU WIN!" 24 "Deep Pink"))

(define (si-render-final s)
  (if (>= (posn-y (sigs-ufo s)) TANK-Y)
      (text "GAME OVER" 24 "Deep Pink")
      (text "YOU WIN!" 24 "Deep Pink")))

;  Exercise 99
; 
; Design si-move. This function is called for every clock tick to determine to which position the objects move now. Accordingly, it consumes an element of SIGS and produces another one.


;; SIGS -> SIGS
;; determine the position of all the objects

(define (si-move-proper s)
  (make-sigs 
   (move-ufo  (sigs-ufo s))
   (move-tank (sigs-tank s))
   (move-missile (sigs-missile s)))) 

;; Tank -> Tank
;; Move the tank accordingly to tank speed (vel); bounces off edges
(check-expect (move-tank T1) (make-tank (+ (tank-loc T1) (tank-vel T1)) (tank-vel T1)))
(check-expect (move-tank T2) (make-tank (+ (tank-loc T2) (tank-vel T2)) (tank-vel T2)))
(check-expect (move-tank (make-tank WIDTH TANK-SPEED)) (make-tank WIDTH (- TANK-SPEED)))


;(define (move-tank t) T1)
(define (move-tank t)
  (cond [(> (+ (tank-loc t) (tank-vel t)) WIDTH) (make-tank WIDTH (- (tank-vel t)))]
        [(< (+ (tank-loc t) (tank-vel t)) 0)     (make-tank 0     (- (tank-vel t)))]
        [else                                    (make-tank (+ (tank-loc t) (tank-vel t)) (tank-vel t))]))

;; Missile -> Missile
;; Move the missile by MISSILE-SPEED
(check-expect (move-missile M1) (make-posn (posn-x M1) (- (posn-y M1) MISSILE-SPEED)))
(check-expect (move-missile M2) (make-posn (posn-x M2) (- (posn-y M2) MISSILE-SPEED)))

;(define (move-missile t) M1)
(define (move-missile m)
  (if (posn? m)
      (if (< (- (posn-y m)  MISSILE-SPEED) 0)
          false
          (make-posn (posn-x m) (- (posn-y m) MISSILE-SPEED)))
      m))


;; UFO -> UFO
;; Move the UFO from side to side, gets closer to earth whenever it reaches left or right border
(check-expect (move-ufo U2) (make-posn (+ UFO-SPEED 10) 10))
(check-expect (move-ufo (make-posn WIDTH 15)) (make-posn 0 (+ UFO-NEXT-LINE 15)))

(define (move-ufo u)
  (cond [(> (+ (posn-x u) UFO-SPEED) WIDTH)
         (make-posn  0 (+ UFO-NEXT-LINE (posn-y u)))]
        [else
         (make-posn (+ (posn-x u) UFO-SPEED) (posn-y u))]))

 
;  Exercise 100
; 
; Design the function si-control, which plays the role of the key-event handler.


;; SIGS KeyEvent -> SIGS
(check-expect (si-control SIGS4 "left")
              (make-sigs (make-posn (/ WIDTH 2) 30)
                         (make-tank 50 (- TANK-SPEED))
                         false)) ; velocity becomes -2
(check-expect (si-control SIGS4 "right")
              (make-sigs (make-posn (/ WIDTH 2) 30)
                         (make-tank 50 TANK-SPEED)
                         false)) ; velocity becomes 2
(check-expect (si-control SIGS5 "right")
              (make-sigs (make-posn (/ WIDTH 2) 30)
                         (make-tank 50 (+ TANK-SPEED))
                         (make-posn 50 (- HEIGHT TANK-HEIGHT)))) ; Tank moves right, missile remains unchanged
(check-expect (si-control SIGS5 " ")
              SIGS5) ; No change when space is pressed in the "fired" state
(check-expect (si-control SIGS0 "a")
              SIGS0) ; No change for an invalid key


;; SIGS KeyEvent -> SIGS
(define (si-control s ke)
  (cond
    [(key=? ke "left")
     (make-sigs
      (sigs-ufo s)
      (make-tank (tank-loc (sigs-tank s)) (- TANK-SPEED))
      (sigs-missile s))]
    [(key=? ke "right")
     (make-sigs
      (sigs-ufo s)
      (make-tank (tank-loc (sigs-tank s)) TANK-SPEED)
      (sigs-missile s))]
    [(key=? ke " ")
     (if (boolean? (sigs-missile s)) ; if there's no missile
         (make-sigs
          (sigs-ufo s)
          (sigs-tank s)
          (make-posn (tank-loc (sigs-tank s)) (- HEIGHT TANK-HEIGHT))) ; fire missile from tank's position
         s)]
    [else s]))

;; SIGS -> SIGS
;; play the space invaders game; (si-main SIGS0)
(define (si-main s)
  (big-bang s
    [to-draw                       si-render]
    [on-tick                  si-move-proper]
    [on-key                       si-control]
    [stop-when si-game-over? si-render-final]))

;  Exercise 102
; 
; Design all other functions that are needed to complete the game for this second data definition. 


;  Exercise 103
; 
; Develop a data representation for the following four kinds of zoo animals.
; Develop a template for functions that consume zoo animals.
; Design the fits? function, which consumes a zoo animal and a description of a cage. It determines whether the cage’s volume is large enough for the animal. 


(define-struct spider [legs space])
; A Spider is a structure:
; (make-spider Number Number)
; interp. represents the remaining number of legs
;         and the space it occupies

(define-struct elephant [space])
; An Elephant is a structure:
; (make-elephant Number)
; interp. represents the space the elephant occupies

(define-struct boa [length girth])
; A Boa is a structure:
; (make-boa Number Number)
; interp. represents the length of a boa
;         and its girth

(define-struct armadillo [space armor])
; An Armadillo is a structure:
; (make-armadillo Number Number)
; interp. represents the space the armadillo occupies
;         and its level of armor protection (measured in some arbitrary unit)


;; ZooAnimal is one of:
;; - Spider
;; - Elephant
;; - Boa
;; - Armadillo
;; interp. an instance of a zoo animal

#;
(define (fn-for-zoo-animal za)
  (cond [(spider? za)    (... za)]
        [(elephant? za)  (... za)]
        [(boa? za)       (... za)]
        [(armadillo? za) (... za)]))

;; ZooAnimal Number -> Boolean
;; Produce true if the ZooAnimal volume is inferior to the Cage volume
(check-expect (fits? (make-elephant  30) 40) true)
(check-expect (fits? (make-elephant  40) 30) false)
(check-expect (fits? (make-armadillo  10 24) 10) false)
(check-expect (fits? (make-boa 20 10) 50) false)

;(define (fits? za c) false)

(define (fits? za c)
  (cond [(spider? za)    (< (spider-space    za) c)]
        [(elephant? za)  (< (elephant-space  za) c)]
        [(boa? za)       (< (boa-volume      za) c)]
        [(armadillo? za) (< (armadillo-space za) c)]))

;; Boa -> Number
;; produce the volume of a boa, based on its length and girth
;; volume of a cylinder: volume = pi x (girth/2)^2 x length
(define (boa-volume boa)
  (* pi (sqr (/ (boa-girth boa) 2)) (boa-length boa)))

;  Exercise 104
; 
; Your home town manages a fleet of vehicles: automobiles, vans, buses, and SUVs. Develop a data representation for vehicles. The representation of each vehicle must describe
; the number of passengers that it can carry, its license plate number, and its fuel consumption (miles per gallon). Develop a template for functions that consume vehicles. 


;; A PlateNumber is a String of one of:
;;   - Alphanumeric characters
;; interp. "XYZ987AB" represents a license plate number

(define-struct vehicle (capacity plate-number fuel-consumption))
;; A Vehicle is a structure:
;;   (make-vehicle Natural PlateNumber Number)
;; interp. a vehicle has:
;;         capacity,        the maximum number of passengers it can carry
;;         plate-number,    its license plate number
;;         fuel-consumption, the amount of fuel it consumes per trip

(define sedan  (make-vehicle 5  "XYZ123AB" 50))
(define minivan (make-vehicle 8  "LMN456CD" 40))
(define bus    (make-vehicle 50 "BUS789EF" 35))
(define pickup (make-vehicle 3  "TRK321GH" 25))

#;
(define (fn-for-vehicle v)
  (... (vehicle-capacity       v)
       (vehicle-plate-number   v)
       (vehicle-fuel-consumption v)))

;  Exercise 105
; 
; Some program contains the following data definition.
; Make up at least two data examples per clause in the data definition. For each of the examples, explain its meaning with a sketch of a canvas. 


; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define yNeg1 -5) ; A point 5 units below the top of the canvas on the y-axis
(define yNeg2 -8) ; A point 8 units below the top of the canvas on the y-axis

(define xPos1  4) ; A point 4 units to the right of the canvas's left edge on the x-axis
(define xPos2 10) ; A point 10 units to the right of the canvas's left edge on the x-axis

(define point1 (make-posn 7 -3)) ; A point 7 units to the right and 3 units below the top
(define point2 (make-posn 15 -10)) ; A point 15 units to the right and 10 units below the top

;  Exercise 106
; In More Virtual Pets we discussed the creation of virtual pets that come with happiness gauges.
; One of the virtual pets is a cat, the other one, a chameleon. Each program is dedicated to a single pet, however.
; Design the cat-cham world program. Given both a location and an animal, it walks the latter across the canvas, starting from the given location.


;; Constants
(define H-WIDTH 450)
(define H-HEIGHT 400)
(define H-MTS (empty-scene H-WIDTH H-HEIGHT))
(define VANIMAL-Y (/ H-HEIGHT 2))
(define SPEED 3)
(define HAP-RATE 0.1)

(define CAT-IMG .)

(define CHAM-IMG .)

(define-struct track (x hap))
;; A Track is a structure:
;;   (make-track Number Number[0, 100])
;; interp. keeps track of a vanimal's changing variables
;;         x is the x-coordinate of the vanimal on the screen
;;         hap is its happiness

(define-struct vcat (img track))
;; A VCat is a structure:
;;   (make-vcat Image Track)
;; interp. a virtual cat, including its image and
;;         information about its movement and happiness

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

(define CAT  (make-vcat CAT-IMG (make-track 125 100)))
(define CHAM (make-vcham "w" CHAM-IMG (make-track 125 100)))

; A VAnimal is either:
; – a VCat
; – a VCham

; A VAnimal is the world state

; VAnimal -> VAnimal
; moves the vanimal three pixels per clock tick
(check-expect (tock CHAM) (make-vcham (vcham-color CHAM)
                                      (vcham-img CHAM)
                                      (make-track (+ 125 SPEED)
                                                  (- 100 HAP-RATE))))
(check-expect (tock CAT) (make-vcat (vcat-img CAT)
                                    (make-track (+ 125 SPEED)
                                                (- 100 HAP-RATE))))

(define (tock va)
  (cond
    [(vcham? va) (make-vcham (vcham-color va)
                             (vcham-img   va)
                             (make-track (+ (track-x   (vcham-track va)) SPEED)
                                         (- (track-hap (vcham-track va)) HAP-RATE)))]
    [(vcat?  va) (make-vcat (vcat-img va)
                            (make-track (+ (track-x (vcat-track va)) SPEED)
                                        (- (track-hap (vcat-track va)) HAP-RATE)))]))

;; Number -> Image
;; Create a happiness bar based on the happiness level
(define (happiness-bar hap)
  (rectangle 50 10 "solid" (if (> hap 80) "green"
                               (if (> hap 50) "yellow"
                                   "red"))))


; VAnimal -> Image
; renders the image of the vanimal; if the vanimal disappears
; on the right, it reappears on the left
(check-expect (render CAT)
              (place-image (vcat-img CAT)
                           (track-x (vcat-track CAT))
                           VANIMAL-Y (overlay/align "left" "top" (happiness-bar (track-hap (vcat-track CAT))) H-MTS)))
(check-expect (render CHAM)
              (place-image (vcham-img CHAM)
                           (track-x (vcham-track CHAM))
                           VANIMAL-Y (overlay/align "left" "top" (happiness-bar (track-hap (vcham-track CHAM))) H-MTS)))
(check-expect (render (make-vcham "w" CHAM-IMG
                                  (make-track (+ H-WIDTH (image-width CHAM-IMG))
                                              100)))
              (place-image CHAM-IMG
                           0
                           VANIMAL-Y (overlay/align "left" "top" (happiness-bar (track-hap (vcham-track CHAM))) H-MTS)))

(define (render va)
  (if (vcat? va)
      (render-vcat  va)
      (render-vcham va)))

;; VCat -> Image
;; render a vcat
(define (render-vcat vc)
  (if (>= (track-x (vcat-track vc))
          (+ H-WIDTH (image-width (vcat-img vc))))
      (place-image (vcat-img vc)
                   (modulo (track-x (vcat-track vc))
                           (+ H-WIDTH (image-width (vcat-img vc))))
                   VANIMAL-Y
                   (overlay/align "left" "top" (happiness-bar (track-hap (vcat-track vc))) H-MTS))
      (place-image (vcat-img vc)
                   (track-x (vcat-track vc))
                   VANIMAL-Y
                   (overlay/align "left" "top" (happiness-bar (track-hap (vcat-track vc))) H-MTS))))

;; VCham -> Image
;; render a vcham
(define (render-vcham vc)
  (if (>= (track-x (vcham-track vc))
          (+ H-WIDTH (image-width (vcham-img vc))))
      (place-image (vcham-img vc)
                   (modulo (track-x (vcham-track vc))
                           (+ H-WIDTH (image-width (vcham-img vc))))
                   VANIMAL-Y
                   (overlay/align "left" "top" (happiness-bar (track-hap (vcham-track vc))) H-MTS))
      (place-image (vcham-img vc)
                   (track-x (vcham-track vc))
                   VANIMAL-Y
                   (overlay/align "left" "top" (happiness-bar (track-hap (vcham-track vc))) H-MTS))))

;; VAnimal KeyEvent -> VAnimal
;; make the vanimal happy by feeding it (down arrow)
;; happiness goes up two points if vcham,
;; happiness goes up to max if vcat
;; can't pet if the vanimal is vcham,
;; can't change color if vanimal is vcat
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
(check-expect (handle-key CAT "up") CAT)
(check-expect (handle-key (make-vcat CAT-IMG
                                     (make-track 135 65)) "up")
              (make-vcat CAT-IMG
                         (make-track 135 100)))
(check-expect (handle-key (make-vcat CAT-IMG
                                     (make-track 135 65)) "down")
              (make-vcat CAT-IMG
                         (make-track 135 100)))

(define (handle-key vc ke)
  (if (vcat? vc)
      (handle-key-vcat  vc ke)
      (handle-key-vcham vc ke)))

;; VCham KeyEvent -> VAnimal
;; controls for vcham
(define (handle-key-vcham vc ke)
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

;; VCat KeyEvent -> VAnimal
;; controls for vcat
(define (handle-key-vcat vc ke)
  (cond
    [(or (string=? ke "up")
         (string=? ke "down")) (make-vcat (vcat-img vc)
                                          (make-track (track-x (vcat-track vc))
                                                      100))]
    [else vc]))

(define (happy-animal vc)
  (big-bang vc
    [to-draw render]
    [on-tick tock]
    [on-key  handle-key]))

;  Exercise 107. Design the cham-and-cat program, which deals with both a virtual cat and a virtual chameleon. You need a data definition for a “zoo” containing both animals
; and functions for dealing with it.


;; Focus is 1String, one of:
;;  - "l"
;;  - "k"
;; interp. the focus animal for key-handling
;;         "l" denotes "kitty" (VCat)
;;         "k" denotes "lizard" (VCham)

(define-struct zoo (focus vcat vcham))
;; A Zoo is a structure:
;;   (make-zoo Focus VCat VCham)
;; interp. a zoo contains a VCat and a VCham,
;;         as well as a focus to denote which
;;         animal has key-handling focus

(define ZCAT  (make-zoo "k" CAT CHAM))
(define ZCHAM (make-zoo "l" CAT CHAM))

;; Zoo -> Zoo
;; A program which has both a cat and a chameleon; (cham-and-cat ZCAT)
(define (cham-and-cat z)
  (big-bang z
    [to-draw render-cham-and-cat]
    [on-tick tock-cham-and-cat]
    [on-key  handle-key-cham-and-cat]))


;; Zoo -> Image
;; produce an image of both cat and chameleon next to each other
(check-expect (render-cham-and-cat ZCAT) (beside (render (zoo-vcat ZCAT)) (render (zoo-vcham  ZCAT)))) 

;(define (render-cham-and-cat z) H-MTS)
(define (render-cham-and-cat z) (beside (render (zoo-vcat z)) (render (zoo-vcham z))))

; VAnimal -> VAnimal
; moves the vanimal three pixels per clock tick
(check-expect (tock CHAM) (make-vcham (vcham-color CHAM)
                                      (vcham-img CHAM)
                                      (make-track (+ 125 SPEED)
                                                  (- 100 HAP-RATE))))
(check-expect (tock CAT) (make-vcat (vcat-img CAT)
                                    (make-track (+ 125 SPEED)
                                                (- 100 HAP-RATE))))
;; Zoo -> Zoo
;; Move the cat if 'k' is selected, or chameleon if 'l' is selected
(define (update-track track dx dh)
  (make-track (+ (track-x track) dx) (- (track-hap track) dh)))

(define (tock-cham-and-cat z)
  (cond
    [(string=? "k" (zoo-focus z))
     (make-zoo "k" 
               (make-vcat (vcat-img (zoo-vcat z)) 
                          (update-track (vcat-track (zoo-vcat z)) SPEED HAP-RATE)) 
               (zoo-vcham z))]
    [else  
     (make-zoo "l" 
               (zoo-vcat z) 
               (make-vcham (vcham-color (zoo-vcham z))
                           (vcham-img   (zoo-vcham z))
                           (update-track (vcham-track (zoo-vcham z)) SPEED HAP-RATE)))]))

;; Zoo KeyEvent -> Zoo
;; controls for vcat and vcham
(define (handle-key-cham-and-cat z ke)
  (cond
    [(string=? ke "k") (make-zoo "k" (zoo-vcat z) (zoo-vcham z))]
    [(string=? ke "l") (make-zoo "l" (zoo-vcat z) (zoo-vcham z))]
    [(string=? ke "down")
     (if (string=? (zoo-focus z) "l")
         (make-zoo "l" (zoo-vcat z)
                   (make-vcham (vcham-color (zoo-vcham z))
                               (vcham-img   (zoo-vcham z))
                               (make-track (track-x (vcham-track (zoo-vcham z)))
                                           (+ 2 (track-hap (vcham-track (zoo-vcham z)))))))
         (make-zoo "k" 
                   (make-vcat (vcat-img (zoo-vcat z))
                              (make-track (track-x (vcat-track (zoo-vcat z)))
                                          100))
                   (zoo-vcham z)))]
    [else z]))


;  Exercise 108
; 
; In its default state, a pedestrian crossing light shows an orange person standing on a red background. When it is time to allow the pedestrian to cross the street,
; the light receives a signal and switches to a green, walking person. This phase lasts for 10 seconds. After that the light displays the digits 9, 8, ..., 0 with odd numbers colored orange
; and even numbers colored green. When the countdown reaches 0, the light switches back to its default state.


;; Constants
(define W-WIDTH  500)
(define W-HEIGHT 500)
(define SCENE-CENTER-X (/ W-WIDTH 2))
(define SCENE-CENTER-Y (/ W-HEIGHT 2))
(define EMPTY-SCENE (empty-scene W-WIDTH W-HEIGHT))
(define IMAGE-STOP .)
(define IMAGE-WALK .)

(define ODD-TEXT-COLOR "orange")
(define EVEN-TEXT-COLOR "green")
(define TEXT-FONT-SIZE 32)
(define SPACER (rectangle 60 15 "solid" "white"))



;; Data definitions

;; State is one of:
;;  - "default" ("d")
;;  - "walking" ("w")
;; interp. the pedestrian crossing light's state

;; Timer is Natural[0, 20)
;; interp. the countdown timer begins at 19

(define-struct crossing-light (state stop-image walk-image countdown signal?))
;; A CrossingLight is a structure:
;;   (make-crossing-light State Image Image Timer Boolean)
;; interp. a pedestrian crossing light with:
;;         - `state`: "default" or "walking"
;;         - `stop-image`: image of the stop light
;;         - `walk-image`: image of the walk light
;;         - `countdown`: timer to switch back to default state
;;         - `signal?`: boolean to indicate if countdown is active

(define LIGHT-DEFAULT (make-crossing-light "default" IMAGE-STOP IMAGE-WALK 19 false))
(define LIGHT-WALKING (make-crossing-light "walking" IMAGE-STOP IMAGE-WALK 9 true))

#;
(define (fn-for-crossing c)
  (... (crossing-state c)
       (crossing-default c)
       (crossing-walk c)
       (crossing-countdown c)
       (crossing-signal? c)))

;; A CrossingLight is the state of the world


;; Functions

;; CrossingLight -> CrossingLight
;; Advances the countdown timer if the signal is active
(check-expect (tock-cl LIGHT-DEFAULT) LIGHT-DEFAULT)
(check-expect (tock-cl  (make-crossing-light "default" IMAGE-STOP IMAGE-WALK 10 true))
              (make-crossing-light "walking" IMAGE-STOP IMAGE-WALK 9 true))
(check-expect (tock-cl  LIGHT-WALKING)
              (make-crossing-light "walking" IMAGE-STOP IMAGE-WALK 8 true))

(define (tock-cl  light)
  (cond
    [(false? (crossing-light-signal? light)) light]
    [(= (crossing-light-countdown light) 10)
     (make-crossing-light "walking"
                          (crossing-light-stop-image light)
                          (crossing-light-walk-image light)
                          (sub1 (crossing-light-countdown light))
                          true)]
    [(= (crossing-light-countdown light) 0)
     (make-crossing-light "default"
                          (crossing-light-stop-image light)
                          (crossing-light-walk-image light)
                          19
                          false)]
    [else
     (make-crossing-light (crossing-light-state light)
                          (crossing-light-stop-image light)
                          (crossing-light-walk-image light)
                          (sub1 (crossing-light-countdown light))
                          true)]))

;; CrossingLight -> Image
;; Renders the crossing light state and countdown timer
(check-expect (render-cl LIGHT-DEFAULT)
              (place-image IMAGE-STOP SCENE-CENTER-X SCENE-CENTER-Y EMPTY-SCENE))
(check-expect (render-cl LIGHT-WALKING)
              (place-image
               (above IMAGE-WALK SPACER (text "9" TEXT-FONT-SIZE ODD-TEXT-COLOR))
               SCENE-CENTER-X SCENE-CENTER-Y EMPTY-SCENE))

(define (render-cl light)
  (if (string=? (crossing-light-state light) "walking")
      (place-image
       (above (render-light light)
              SPACER
              (render-text (crossing-light-countdown light)))
       SCENE-CENTER-X SCENE-CENTER-Y EMPTY-SCENE)
      (place-image
       (render-light light)
       SCENE-CENTER-X SCENE-CENTER-Y EMPTY-SCENE)))

;; CrossingLight -> Image
;; Renders the appropriate light image
(check-expect (render-light LIGHT-DEFAULT) IMAGE-STOP)
(check-expect (render-light LIGHT-WALKING) IMAGE-WALK)

(define (render-light light)
  (if (string=? (crossing-light-state light) "walking")
      (crossing-light-walk-image light)
      (crossing-light-stop-image light)))

;; Natural -> Image
;; Renders the countdown text
(check-expect (render-text 9)
              (text "9" TEXT-FONT-SIZE ODD-TEXT-COLOR))
(check-expect (render-text 8)
              (text "8" TEXT-FONT-SIZE EVEN-TEXT-COLOR))

(define (render-text n)
  (text (number->string n)
        TEXT-FONT-SIZE
        (render-text-color n)))

;; Natural -> String
;; Produces green if `n` is even, orange if `n` is odd
(check-expect (render-text-color 9) ODD-TEXT-COLOR)
(check-expect (render-text-color 8) EVEN-TEXT-COLOR)

(define (render-text-color n)
  (if (odd? n)
      ODD-TEXT-COLOR
      EVEN-TEXT-COLOR))

;; CrossingLight KeyEvent -> CrossingLight
;; Starts the countdown when the spacebar is pressed
(check-expect (sig-start LIGHT-DEFAULT " ")
              (make-crossing-light "default" IMAGE-STOP IMAGE-WALK 19 true))
(check-expect (sig-start LIGHT-DEFAULT "a") LIGHT-DEFAULT)

(define (sig-start light key-event)
  (cond
    [(and (string=? key-event " ")
          (false? (crossing-light-signal? light)))
     (make-crossing-light (crossing-light-state light)
                          (crossing-light-stop-image light)
                          (crossing-light-walk-image light)
                          (crossing-light-countdown light)
                          true)]
    [else light]))


;; CrossingLight -> CrossingLight
;; Run with (main LIGHT-DEFAULT)
(define (main light)
  (big-bang light
    [to-draw render-cl]
    [on-tick tock-cl 1]
    [on-key sig-start]))


;  Exercise 109
; 
; Design a world program that recognizes a pattern in a sequence of KeyEvents. Initially the program shows a 100 by 100 white rectangle.
; Once your program has encountered the first desired letter, it displays a yellow rectangle of the same size. After encountering the final letter,
; the color of the rectangle turns green. If any “bad” key event occurs, the program displays a red rectangle.

          
;; Constants
(define WINDOW-HEIGHT 400)
(define WINDOW-WIDTH  400)
(define BLANK-SCENE   (empty-scene WINDOW-WIDTH WINDOW-HEIGHT))
(define CENTER-X (/ WINDOW-WIDTH 2))
(define CENTER-Y (/ WINDOW-HEIGHT 2))

(define RECT-WIDTH  100)
(define RECT-HEIGHT 100)
(define RECT-WHITE  (rectangle RECT-WIDTH RECT-HEIGHT "solid" "white"))
(define RECT-YELLOW (rectangle RECT-WIDTH RECT-HEIGHT "solid" "yellow"))
(define RECT-GREEN  (rectangle RECT-WIDTH RECT-HEIGHT "solid" "green"))
(define RECT-RED    (rectangle RECT-WIDTH RECT-HEIGHT "solid" "red"))

(define STATE_START "start: expecting 'a'")
(define STATE_EXPECT "expecting 'b', 'c', or 'd'")
(define STATE_FINISH "finished")
(define STATE_ERROR "error: invalid input")

;; State -> Image
;; Render the given state as a corresponding rectangle
(check-expect (render-state STATE_START) RECT-WHITE)
(check-expect (render-state STATE_EXPECT) RECT-YELLOW)
(check-expect (render-state STATE_FINISH) RECT-GREEN)
(check-expect (render-state STATE_ERROR) RECT-RED)

(define (render-state state)
  (cond
    [(string=? state STATE_START) RECT-WHITE]
    [(string=? state STATE_EXPECT) RECT-YELLOW]
    [(string=? state STATE_FINISH) RECT-GREEN]
    [(string=? state STATE_ERROR) RECT-RED]))

;; State KeyEvent -> State
;; Transition to the next state based on the current state and input
(check-expect (next-state STATE_START "a") STATE_EXPECT)
(check-expect (next-state STATE_START "d") STATE_ERROR)
(check-expect (next-state STATE_START "up") STATE_ERROR)
(check-expect (next-state STATE_EXPECT "b") STATE_EXPECT)
(check-expect (next-state STATE_EXPECT "c") STATE_EXPECT)
(check-expect (next-state STATE_EXPECT "a") STATE_ERROR)
(check-expect (next-state STATE_EXPECT "up") STATE_ERROR)
(check-expect (next-state STATE_EXPECT "d") STATE_FINISH)

(define (next-state state key-event)
  (cond
    [(and (equal? state STATE_START) (string=? key-event "a")) STATE_EXPECT]
    [(and (equal? state STATE_EXPECT)
          (or (string=? key-event "b")
              (string=? key-event "c"))) STATE_EXPECT]
    [(and (equal? state STATE_EXPECT) (string=? key-event "d")) STATE_FINISH]
    [else STATE_ERROR]))

;; State -> Boolean
;; Stop the program if the state is STATE_ERROR or STATE_FINISH
(check-expect (is-terminal-state? STATE_START) false)
(check-expect (is-terminal-state? STATE_EXPECT) false)
(check-expect (is-terminal-state? STATE_FINISH) true)
(check-expect (is-terminal-state? STATE_ERROR) true)

(define (is-terminal-state? state)
  (or (equal? state STATE_ERROR) (equal? state STATE_FINISH)))

;; State -> State
;; Run the regex sequence recognition program
(define (run-regex initial-state)
  (big-bang initial-state
    [to-draw render-state]
    [on-key next-state]
    [stop-when is-terminal-state? render-state]))

;  Exercise 110
; 
; A checked version of area-of-disk can also enforce that the arguments to the function are positive numbers, not just arbitrary numbers. Modify checked-area-of-disk in this way. 


;; Number -> Number
;; computes the area of a disk with radius r
;(define (area-of-disk r)
;  (* pi (* r r)))

; Any -> Number
; computes the area of a disk with radius v, 
; if v is a number
;(check-expect (checked-area-of-disk "bonjour") (error "area-of-disk: positive number expected"))

;(define (checked-area-of-disk v)
;  (cond
;    [(positive? v) (area-of-disk v)]
;    [else (error "area-of-disk: positive number expected")]))

;  Exercise 111
; 
; Take a look at these definitions:
; Develop the function checked-make-vec, which is to be understood as a checked version of the primitive operation make-vec. It ensures that the arguments to make-vec are positive numbers.
; In other words, checked-make-vec enforces our informal data definition. 


(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

(define (checked-make-vec x y)
  (cond [(and (positive? x) (positive? y)) (make-vec x y)]
        [else (error "checked-make-vec: should use positive number for x and y")]))

;  Exercise 112
; 
; Reformulate the predicate now using an or expression. 


(define (missile-or-not? v)
  (cond
    [(or (false? v)
         (posn? v)) #true]
    [else #false]))

;  Exercise 113
; 
; Design predicates for the following data definitions from the preceding section: SIGS, Coordinate (exercise 105), and VAnimal. 


;  Exercise 114
; 
; Use the predicates from exercise 113 to check the space invader world program, the virtual pet program (exercise 106), and the editor program (A Graphical Editor). 


;  Exercise 115
; 
; Revise light=? so that the error message specifies which of the two arguments isn’t an element of TrafficLight. 


; Any -> Boolean
; Checks if the given value is a valid TrafficLight element
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define MESSAGE
  "Invalid input: expected a traffic light (red, green, or yellow).")

; Any Any -> Boolean
; Determines if both values are valid TrafficLight elements and checks if they are equal

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(check-error  (light=? "purple" "blue"))
(check-error  (light=? "bike" "country"))

(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (if (not (light? a-value))
          (error "Expected a traffic light, but 'a-value' is invalid.")
          (error "Expected a traffic light, but 'another-value' is invalid."))))
