;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Genrec-P3-cantor |) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; cantor-line-starter.rkt

; 
; PROBLEM:
; 
; A cantor Set is another fractal with a nice simple geometry.
; The idea of a Cantor set is to have a bar (or rectangle) of
; a certain width w, then below that are two recursive calls each
; of 1/3 the width, separated by a whitespace of 1/3 the width.
; 
; So this means that the
;   width of the whitespace   wc  is  (/ w 3)
;   width of recursive calls  wr  is  (/ (- w wc) 2)
;   
; To make it look better a little extra whitespace is put between
; the bars.
; 
; 
; Here are a couple of examples (assuming a reasonable CUTOFF)
; 
; (cantor CUTOFF) produces:
; 
; .
; 
; (cantor (* CUTOFF 3)) produces:
; 
; .
; 
; And that keeps building up to something like the following. So
; as it goes it gets wider and taller of course.
; 
; .
; 
; 
; PROBLEM A:
; 
; Design a function that consumes a width and produces a cantor set of 
; the given width.
; 
; 
; PROBLEM B:
; 
; Add a second parameter to your function that controls the percentage 
; of the recursive call that is white each time. Calling your new function
; with a second argument of 1/3 would produce the same images as the old 
; function.
; 
; PROBLEM C:
; 
; Now you can make a fun world program that works this way:
;   The world state should simply be the most recent x coordinate of the mouse.
;   
;   The to-draw handler should just call your new cantor function with the
;   width of your MTS as its first argument and the last x coordinate of
;   the mouse divided by that width as its second argument.
;   
; 
; 


;; =================
;; Constants:

(define STEP (/ 1 3))
(define TRIVIAL-SIZE 5)
(define RECTANGLE-HEIGHT 20)
(define Y-SPACING (/ RECTANGLE-HEIGHT 2))

(check-expect (cantor 0 .5)
              (rectangle 0 RECTANGLE-HEIGHT "solid" "blue"))

(check-expect (cantor 32 0)
              (above (rectangle 32 RECTANGLE-HEIGHT "solid" "blue")
                     (rectangle 32 Y-SPACING "solid" "white")
                     (rectangle 32 RECTANGLE-HEIGHT "solid" "blue")
                     (rectangle 32 Y-SPACING "solid" "white")
                     (rectangle 32 RECTANGLE-HEIGHT "solid" "blue")
                     (rectangle 32 Y-SPACING "solid" "white")
                     (rectangle 32 RECTANGLE-HEIGHT "solid" "blue")))

(check-expect (cantor 32 1)
              (above (rectangle 32 RECTANGLE-HEIGHT "solid" "blue")
                     (rectangle 32 Y-SPACING "solid" "white")
                     (rectangle 32 RECTANGLE-HEIGHT "solid" "white")))

(check-expect (cantor 32 .5)
              (above (rectangle 32 RECTANGLE-HEIGHT "solid" "blue")
                     (rectangle 32 Y-SPACING "solid" "white")
                     (beside 
                      (above (rectangle 8 RECTANGLE-HEIGHT "solid" "blue")
                             (rectangle 8 Y-SPACING "solid" "white")
                             (beside 
                              (rectangle 2 RECTANGLE-HEIGHT "solid" "blue")
                              (rectangle 4 RECTANGLE-HEIGHT "solid" "white")
                              (rectangle 2 RECTANGLE-HEIGHT "solid" "blue")))
                      (rectangle 16 RECTANGLE-HEIGHT "solid" "white")
                      (above (rectangle 8 RECTANGLE-HEIGHT "solid" "blue")
                             (rectangle 8 Y-SPACING "solid" "white")
                             (beside 
                              (rectangle 2 RECTANGLE-HEIGHT "solid" "blue")
                              (rectangle 4 RECTANGLE-HEIGHT "solid" "white")
                              (rectangle 2 RECTANGLE-HEIGHT "solid" "blue"))))))
(define (cantor w r)
  (if (<= w TRIVIAL-SIZE)
      (rectangle w RECTANGLE-HEIGHT "solid" "blue") 
  (local [(define wc (* w r))
          (define ws (/ (- w wc) 2))
          (define ctr (rectangle wc RECTANGLE-HEIGHT "solid" "white"))
          (define l/r (cantor ws r))]
    (above (rectangle w RECTANGLE-HEIGHT "solid" "blue")
           (rectangle w Y-SPACING  "solid" "white")
           (beside l/r ctr l/r)))))
