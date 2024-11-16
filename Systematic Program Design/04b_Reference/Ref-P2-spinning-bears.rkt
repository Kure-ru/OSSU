;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ref-P2-spinning-bears) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; spinning-bears-starter.rkt

(require 2htdp/image)
(require 2htdp/universe)

; PROBLEM:
; 
; In this problem you will design another world program. In this program the changing 
; information will be more complex - your type definitions will involve arbitrary 
; sized data as well as the reference rule and compound data. But by doing your 
; design in two phases you will be able to manage this complexity. As a whole, this problem 
; will represent an excellent summary of the material covered so far in the course, and world 
; programs in particular.
; 
; This world is about spinning bears. The world will start with an empty screen. Clicking
; anywhere on the screen will cause a bear to appear at that spot. The bear starts out upright,
; but then rotates counterclockwise at a constant speed. Each time the mouse is clicked on the 
; screen, a new upright bear appears and starts spinning.
; 
; So each bear has its own x and y position, as well as its angle of rotation. And there are an
; arbitrary amount of bears.
; 
; To start, design a world that has only one spinning bear. Initially, the world will start
; with one bear spinning in the center at the screen. Clicking the mouse at a spot on the
; world will replace the old bear with a new bear at the new spot. You can do this part 
; with only material up through compound. 
; 
; Once this is working you should expand the program to include an arbitrary number of bears.
; 
; Here is an image of a bear for you to use: .


;; =================
;; Constants:

(define BEAR-IMG .)
(define ROTATION-SPEED 5)

(define WIDTH 600)
(define HEIGHT 300)
(define MTS (empty-scene WIDTH HEIGHT))

;; =================
;; Data definitions:

(define-struct bear (x y a))
;; Bear is (make-bear Number Number Number)
;; interp. a bear that is rotated at an angle a

(define B1 (make-bear 300 150 0))
(define B2 (make-bear 45 10 90))

#;
(define (fn-for-bear b)
  (... (bear-x b)
       (bear-y b)
       (bear-a b)))

;; Template rules used:
;;  - compound: 3 fields

;; ListOfBear is one of:
;;  - empty
;; - (cons Bear ListOfBear)

(define LOB0 empty)
(define LOB1 (cons (make-bear 300 150 0) empty))
(define LOB2 (cons (make-bear 45 10 90) (cons (make-bear 300 150 0) empty)))

#;
(define (fn-for-lob lob)
  (cond [(empty? lob) (...)]
        [else (... (fn-for-bear (first lob))
                   (fn-for-lob (rest lob)))]))
                   
;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Bear ListOfBear)
;;  - reference: (first lob) is Bear 
;;  - self-reference: (rest lob) is ListOfBear                      

;; =================
;; Functions:

;; ListOfBear -> ListOfBear
;; world with spinning bears, clicking on the screeen adds a new bear; start the world with (main LOB1)
;; 
(define (main b)
  (big-bang b                   ; ListOfBear
    (on-tick   rotate-bears)     ; ListOfBear -> ListOfBear
    (to-draw   render-bears)     ; ListOfBear -> Image
    (on-mouse  handle-mouse)))  ; ListOfBear Integer Integer MouseEvent -> ListOfBear

;; Bear -> Bear
;; produce a rotated bear by ROTATION-SPEED
(check-expect (rotate-bear (make-bear 45 70 0)) (make-bear 45 70 5))
(check-expect (rotate-bear (make-bear 300 150 90)) (make-bear 300 150 95))

;(define (rotate-bear b) BEAR-IMG) ;stub
;<use template from Bear>
(define (rotate-bear b)
  (make-bear (bear-x b) (bear-y b) (+ 5 (bear-a b))))

;; ListOfBear -> ListOfBear
;; rotate all the bears
(check-expect (rotate-bears LOB1)  (cons (make-bear 300 150 5) empty))
(check-expect (rotate-bears LOB2)  (cons (make-bear 45 10 95) (cons (make-bear 300 150 5) empty)))

(define (rotate-bears lob)
  (cond [(empty? lob) empty]
        [else (cons (rotate-bear (first lob))
               (rotate-bears (rest lob)))]))

;; ListOfBear -> Image
;; render a list of images of a bear, at x and y position and rotated by a
(check-expect (render-bears LOB0) MTS)
(check-expect (render-bears LOB1) (place-image (rotate 0 BEAR-IMG) 300 150 MTS))
(check-expect (render-bears LOB2) (place-image (rotate 90 BEAR-IMG) 45 10
                                               (place-image (rotate 0 BEAR-IMG) 300 150 MTS)))
          

;(define (render-bears lob) MTS) ;stub
;<use template from ListOfBear>
(define (render-bears lob)
  (cond [(empty? lob) MTS]
        [else
         (render-bear-on (first lob) (render-bears (rest lob)))]))

;; Bear -> Image Image
;; render an image of a bear, at x and y position and rotated by a
(check-expect (render-bear-on B1 MTS) (place-image (rotate (bear-a B1) BEAR-IMG) (bear-x B1) (bear-y B1) MTS))
(check-expect (render-bear-on B2 MTS) (place-image (rotate (bear-a B2) BEAR-IMG) (bear-x B2) (bear-y B2) MTS))

;(define (render-bear b) MTS) ;stub
;<use template from Bear>
(define (render-bear-on b img)
  (place-image (rotate (bear-a b) BEAR-IMG) (bear-x b) (bear-y b) img))

; ListOfBear Integer Integer MouseEvent -> ListOfBear
;; clicking on the screen makes a new bear appear at x y coordinates
(check-expect (handle-mouse LOB1 34 78 "move")        LOB1 )
(check-expect (handle-mouse LOB1 23 200 "button-down") (cons (make-bear 23 200 0) LOB1))

(define (handle-mouse lob x y me)
  (cond [(mouse=? me "button-down") (cons (make-bear x y 0) lob)]
        [else lob]))