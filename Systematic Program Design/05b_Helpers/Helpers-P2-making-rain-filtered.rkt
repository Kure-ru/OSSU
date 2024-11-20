;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Helpers-P2-making-rain-filtered) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; making-rain-filtered-starter.rkt

; 
; PROBLEM:
; 
; Design a simple interactive animation of rain falling down a screen. Wherever we click,
; a rain drop should be created and as time goes by it should fall. Over time the drops
; will reach the bottom of the screen and "fall off". You should filter these excess
; drops out of the world state - otherwise your program is continuing to tick and
; and draw them long after they are invisible.
; 
; In your design pay particular attention to the helper rules. In our solution we use
; these rules to split out helpers:
;   - function composition
;   - reference
;   - knowledge domain shift
;   
;   
; NOTE: This is a fairly long problem.  While you should be getting more comfortable with 
; world problems there is still a fair amount of work to do here. Our solution has 9
; functions including main. If you find it is taking you too long then jump ahead to the
; next homework problem and finish this later.
; 
; 


;; Make it rain where we want it to.

;; =================
;; Constants:

(define WIDTH  600)
(define HEIGHT 600)

(define SPEED 5)

(define DROP .)

(define MTS (rectangle WIDTH HEIGHT "solid" "light blue"))

;; =================
;; Data definitions:

(define-struct drop (x y))
;; Drop is (make-drop Integer Integer)
;; interp. A raindrop on the screen, with x and y coordinates.

(define D1 (make-drop 10 30))
(define D2 (make-drop 3 6))
(define D3 (make-drop 65 HEIGHT))



#;
(define (fn-for-drop d)
  (... (drop-x d) 
       (drop-y d)))

;; Template Rules used:
;; - compound: 2 fields


;; ListOfDrop is one of:
;;  - empty
;;  - (cons Drop ListOfDrop)
;; interp. a list of drops

(define LOD1 empty)
(define LOD2 (cons (make-drop 10 20) (cons (make-drop 3 6) empty)))
(define LOD3 (cons (make-drop 200 HEIGHT)(cons (make-drop 10 20) (cons (make-drop 3 6) empty))))

#;
(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-drop (first lod))
              (fn-for-lod (rest lod)))]))

;; Template Rules used:
;; - one-of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Drop ListOfDrop)
;; - reference: (first lod) is Drop
;; - self reference: (rest lod) is ListOfDrop

;; =================
;; Functions:

;; ListOfDrop -> ListOfDrop
;; start rain program by evaluating (main empty)
(define (main lod)
  (big-bang lod
    (on-mouse handle-mouse)   ; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
    (on-tick  next-drops)     ; ListOfDrop -> ListOfDrop
    (to-draw  render-drops))) ; ListOfDrop -> Image


;; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
;; if mevt is "button-down" add a new drop at that position
(check-expect (handle-mouse empty 34 70 "button-down")  (cons (make-drop 34 70) empty))
(check-expect (handle-mouse (cons (make-drop 34 70) empty) 140 0 "button-down")  (cons (make-drop 140 0) (cons (make-drop 34 70) empty)))
(check-expect (handle-mouse (cons (make-drop 34 70) empty) 140 0 "move") (cons (make-drop 34 70) empty))

;(define (handle-mouse lod x y mevt) empty) ; stub

(define (handle-mouse lod x y me)
  (cond [(mouse=? me "button-down") (cons (make-drop x y) lod)]
        [else lod]))


;; ListOfDrop -> ListOfDrop
;; produce filtered and ticked list of drops
(check-expect (next-drops empty) empty)
(check-expect (next-drops (cons (make-drop 3 4)
                                (cons (make-drop 90 HEIGHT)
                                      empty)))
              (cons (make-drop 3 (+ SPEED 4))
                    empty))

;(define (next-drops lod) empty) ; stub
(define (next-drops lod)
  (tick-drops (filter-drops lod)))
   
;; ListOfDrop -> ListOfDrop
;; filter list of drops
(check-expect (filter-drops LOD1) empty)
(check-expect (filter-drops LOD2) LOD2)
(check-expect (filter-drops LOD3) LOD2)

;(define (filter-drops lod) empty)
(define (filter-drops lod)
  (cond [(empty? lod) empty]
        [else
         (if (filter-drop? (first lod))
             (filter-drops (rest lod))
             (cons (first lod) (filter-drops (rest lod))))]))

;; Drop -> Boolean
;; produce true if the drop is outside of the screen
(check-expect (filter-drop? D1) false)
(check-expect (filter-drop? D3) true)

;(define (filter-drop? d) false) ; stub
(define (filter-drop? d)
  (>=  (drop-y d) HEIGHT))

;; ListOfDrop -> ListOfDrop
;; change y position of drops in the list
(check-expect (tick-drops empty) empty)
(check-expect (tick-drops (cons (make-drop 300 0) empty)) (cons (make-drop 300 (+ SPEED 0)) empty))
(check-expect (tick-drops (cons (make-drop 65 120) (cons (make-drop 45 24) empty))) (cons (make-drop 65 (+ SPEED 120)) (cons (make-drop 45 (+ SPEED 24)) empty))) 

;(define (tick-drops lod) empty)
(define (tick-drops lod)
  (cond [(empty? lod) empty]
        [else
         (cons (tick-drop (first lod))
              (tick-drops (rest lod)))]))

;; Drop -> Drop
;; change y position of a single drop by adding SPEED
(check-expect (tick-drop (make-drop 300 0)) (make-drop 300 (+ SPEED 0)))
(check-expect (tick-drop (make-drop 65 120)) (make-drop 65 (+ SPEED 120)))

;(define (tick-drop d) D1)
(define (tick-drop d)
 (make-drop (drop-x d) (+ SPEED (drop-y d))))

;; ListOfDrop -> Image
;; Render the drops onto MTS
(check-expect (render-drops LOD1) MTS)
(check-expect (render-drops LOD2) (place-image DROP 10 20
                                               (place-image DROP 3 6 MTS)))

;(define (render-drops lod) MTS) ; stub
(define (render-drops lod)
  (cond [(empty? lod) MTS]
        [else
         (render-drop-on (first lod) (render-drops (rest lod)))]))

;; Drop Image -> Image
;; Render an image of the drop at x and y position
(check-expect (render-drop-on D1 MTS) (place-image DROP 10 30 MTS))
(check-expect (render-drop-on D2 MTS) (place-image DROP  3  6 MTS))

;(define (render-drop-on d img) empty-image) ; stub
(define (render-drop-on d img)
  (place-image DROP (drop-x d) (drop-y d) img))
