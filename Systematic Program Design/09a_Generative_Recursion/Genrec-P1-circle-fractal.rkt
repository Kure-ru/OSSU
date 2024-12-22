;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Genrec-P1-circle-fractal) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; circle-fractal-starter.rkt

; 
; PROBLEM :
; 
; Design a function that will create the following fractal:
; 
;             .
; 
;             
; 
; Each circle is surrounded by circles that are two-fifths smaller. 
; 
; You can build these images using the convenient beside and above functions
; if you make your actual recursive function be one that just produces the
; top leaf shape. You can then rotate that to produce the other three shapes.
; 
; You don't have to use this structure if you are prepared to use more
; complex place-image functions and do some arithmetic. But the approach
; where you use the helper is simpler.
; 
; Include a termination argument for your design.


;; =================
;; Constants:

(define STEP (/ 2 5))
(define TRIVIAL-SIZE 5)

;; Number -> Image
;; Draw a fractal of a given size with circles
(check-expect (draw-leaf (/ TRIVIAL-SIZE 2))
              (circle (/ TRIVIAL-SIZE 2) "solid" "blue"))
(check-expect (draw-leaf TRIVIAL-SIZE)
              (circle TRIVIAL-SIZE "solid" "blue"))
(check-expect (draw-leaf (/ TRIVIAL-SIZE STEP))
              (local [(define center (circle (/ TRIVIAL-SIZE STEP) "solid" "blue"))
                      (define leaf (circle TRIVIAL-SIZE "solid" "blue"))]
                (above leaf
                       (beside leaf center leaf))))
(check-expect (draw-leaf (/ TRIVIAL-SIZE (sqr STEP)))
              (local [(define center (circle (/ TRIVIAL-SIZE (sqr STEP)) "solid" "blue"))
                      (define leaf (draw-leaf (/ TRIVIAL-SIZE STEP)))]
                (above leaf
                       (beside (rotate 90 leaf) center (rotate -90 leaf)))))

;(define (draw-leaf n) (circle 0 "solid" "white")) 

(define (draw-leaf n)
  (cond [(<= n TRIVIAL-SIZE) (circle n "solid" "blue")]
        [else
         (local [(define leaf (draw-leaf (* STEP n)))
                 (define center (circle n "solid" "blue"))]
           (above leaf
                  (beside (rotate 90 leaf) center (rotate -90 leaf))))]))

;; Number -> Image
(check-expect (draw-fractal (/ TRIVIAL-SIZE STEP))
              (local [(define center (circle (/ TRIVIAL-SIZE STEP) "solid" "blue"))
                      (define leaf (circle TRIVIAL-SIZE "solid" "blue"))]
                (above leaf
                       (beside leaf center leaf)
                       leaf)))
(check-expect (draw-fractal (/ TRIVIAL-SIZE (sqr STEP)))
              (local [(define center (circle (/ TRIVIAL-SIZE (sqr STEP)) "solid" "blue"))
                      (define leaf-center (circle (/ TRIVIAL-SIZE STEP) "solid" "blue"))
                      (define leaf-leaf (circle TRIVIAL-SIZE "solid" "blue"))
                      (define top-leaf (above leaf-leaf
                                              (beside leaf-leaf leaf-center leaf-leaf)))]
                (above top-leaf
                       (beside (rotate 90 top-leaf) center (rotate -90 top-leaf))
                       (rotate 180 top-leaf))))


;(define (draw-fractal n) (circle 0 "solid" "white"))
  
(define (draw-fractal n)
  (local [(define top-leaf (draw-leaf (* STEP n)))
          (define center (circle n "solid" "blue"))]
    (above top-leaf
           (beside (rotate 90 top-leaf) center (rotate -90 top-leaf))
           (rotate 180 top-leaf))))