;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 001-010) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercice 1
;; Compute the distance of x, y to the origin (0.0)

(define x 12)
(define y 5)

(sqrt (+ (sqr x) (sqr y)))

;; -------------
;; Exercice 2
;; Create an expression that concatenates prefix and suffix and adds "_" between them.

(define prefix "hello")
(define suffix "world")

(string-append prefix "_" suffix)

;; -------------
;; Exercice 3
;; Create an expression that adds "_" at position i.

(define str "helloworld")
(define i 5)

(string-append (substring str 0 i) "_" (substring str i))

;; -------------
;; Exercice 4
;; Create an expression that deletes the ith position from str

(string-append (substring str 0 i) (substring str (+ 1 i))) 

;; -------------
;; Exercice 5
;; Create the image of a tree

(require 2htdp/image)

(above
 (overlay/xy (ellipse 60 30 "solid" "Medium Forest Green")
             -15 15
             (overlay/xy (ellipse 60 30 "solid" "Medium Forest Green")
                         30 0
                         (ellipse 60 30 "solid" "Medium Forest Green")))
 (rectangle 15 50 "solid" "brown"))

;; -------------
;; Exercice 6
;; Create an expression that counts the number of pixels in the image

(define cat . )

(* (image-width cat) (image-height cat))

;; -------------
;; Exercice 7

; Suppose you want to decide whether today is an appropriate day to go to the mall. You go to the mall
; either if it is not sunny or if today is Friday (because that is when stores post new sales items).


(define sunny #true)
(define friday #false)

(or (not sunny) friday)

;; -------------
;; Exercice 8

; Create a conditional expression that computes whether the image is tall or wide. An image should be labeled
; "tall" if its height is larger than or equal to its width; otherwise it is "wide". 


(if (>= (image-height cat) (image-width cat))
    "tall"
    "wide")

;; -------------
;; Exercice 9

; Create an expression that converts the value of in to a positive number. For a String, it determines how
; long the String is, for an Image, it uses the area, for a Number, it decrements the number by 1, unless
; it is already 0 or negative, for #true it uses 10 and for #false 20.


(define in #false)

(if (string? in)
    (string-length in)
    (if (image? in)
        (* (image-width in) (image-height in))
        (if (number? in)
            (if (<= in 0)
                in
                (- in 1))
            (if (and in #true)
                10
                20))))

;; -------------
;; Exercice 10
;; Now relax, eat, sleep, and then tackle the next chapter.