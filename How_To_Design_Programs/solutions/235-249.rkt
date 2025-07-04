;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 235-249) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 235
; Use the contains? function to define functions that search for "atom", "basic", and "zoo", respectively. 



;; String LoS -> Boolean
;; determines whether l contains the string s
(define (contains? s l)
  (cond
    [(empty? l) false]
    [else (or (string=? (first l) s)
              (contains? s (rest l)))]))

;; LoS -> Boolean
;; does l contain "atom"
(define (contains-atom? l)
  (contains? "atom" l))

; Exercise 236
; Create test suites for the following two functions



(check-expect (add1* '()) '())
(check-expect (add1* (list 1)) (list 2))
(check-expect (add1* (list 4 6 2 98 1)) (list 5 7 3 99 2))

(check-expect (plus5 '()) '())
(check-expect (plus5 (list 1)) (list 6))
(check-expect (plus5 (list 4 6 2 0 1)) (list 9 11 7 5 6))

(check-expect (add* 1 '()) (add1* '()))
(check-expect (add* 1 (list 1)) (add1* (list 1)))
(check-expect (add* 1 (list 4 6 2 98 1)) (add1* (list 4 6 2 98 1)))
(check-expect (add* 5 (list 1)) (plus5 (list 1)))
(check-expect (add* 5 (list 4 6 2 0 1)) (plus5 (list 4 6 2 0 1)))

; Number Lon -> Lon
; add n number to each item on l
(define (add* n l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (+ n (first l))
       (add* n (rest l)))]))


; Lon -> Lon
; adds 1 to each item on l
(define (add1* l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (add1 (first l))
       (add1* (rest l)))]))

; Lon -> Lon
; adds 5 to each item on l
(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (+ (first l) 5)
       (plus5 (rest l)))]))

;  Exercise 237
; Evaluate (squared>? 3 10) and (squared>? 4 10) in DrRacket. How about (squared>? 5 10)? 


; Number Number -> Boolean
; is the area of a square with side x larger than c
(define (squared>? x c)
  (> (* x x) c))

(squared>? 3 10)
(squared>? 4 10)
(squared>? 5 10)

;  Exercise 238
; Abstract the two functions in figure 89 into a single function. Both consume
; non-empty lists of numbers (Nelon) and produce a single number. The left one
; produces the smallest number in the list, and the right one the largest.


(define long-inf
  (list 25 24 23 22 21 20 19 18 17 16 15 14 13
      12 11 10 9 8 7 6 5 4 3 2 1))

(define long-sup
  (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
      17 18 19 20 21 22 23 24 25))

; Nelon -> Number
; determines the smallest 
; number on l
(define (inf l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (< (first l)
            (inf (rest l)))
         (first l)
         (inf (rest l)))]))
    

; Nelon -> Number
; determines the largest 
; number on l
(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (> (first l)
            (sup (rest l)))
         (first l)
         (sup (rest l)))]))

; Nelon -> Number
; determines the number on l
; that satisfies the comparison function c

(define (find-n l c)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (c (first l)
            (find-n (rest l)))
         (first l)
         (find-n (rest l)))]))


; Exercise 239
; A list of two items is another frequently used form of data in ISL programming. Here is a data definition with two parameters:
; ; A [List X Y] is a structure: 
; ;   (cons X (cons Y '()))
; 
; Instantiate this definition to describe the following classes of data:
; pairs of Numbers,
; pairs of Numbers and 1Strings, and
; pairs of Strings and Booleans.



; A [List Number Number] is a structure: 
;   (cons Number (cons Number '()))
(list 14 54)

; A [List Number 1Strings] is a structure: 
;   (cons Number (cons 1Strings '()))
(list 0 "a")

; A [List String Boolean] is a structure: 
;   (cons String (cons Boolean'()))
(list "sunny" true)

;  Exercise 240
; Here are two strange but similar data definitions.
; Both define nested forms of data: one is about numbers and the other about strings. Make examples for both. Abstract over the two. Then instantiate the
; abstract definition to get back the originals. 


; Both data definitions rely on this structure-type definition:
(define-struct layer [stuff])

; An LStr is one of: 
; – String
; – (make-layer LStr)
(make-layer (make-layer (make-layer (list "apple" "banana" "cherry"))))    


; An LNum is one of: 
; – Number
; – (make-layer LNum)
(make-layer (make-layer (make-layer (list 87 3 1 -4))))

; An L-of-Any is one of: 
; – Any
; – (make-layer L-of-Any)

;  Exercise 241
; Compare the definitions for NEList-of-temperatures and NEList-of-Booleans. Then formulate an abstract data definition NEList-of. 


; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 

; An NEList-of-Booleans is one of: 
; – (cons Boolean '())
; – (cons Boolean NEList-of-Booleans)
; interp. non-empty lists of booleans

; An NEList-of-Any is one of: 
; – (cons Any '())
; – (cons Any NEList-of-Any)
; interp. non-empty lists of Any

;  Exercise 242
; Here is one more parametric data definition:
; ; A [Maybe X] is one of: 
; ; – #false 
; ; – X


; String [List-of String] -> [Maybe [List-of String]]
; returns the remainder of los starting with s 
; #false otherwise

(check-expect (occurs "a" (list "b" "a" "d" "e"))
              (list "d" "e"))
(check-expect (occurs "a" (list "b" "c" "d")) #false)

(define (occurs s los)
  (cond [(empty? los) #false]
        [(string=? s (first los)) (rest los)]
        [else (occurs s (rest los))]))

;  Exercise 243
; Assume the definitions area in DrRacket contains
; (define (f x) x)
; 
; Identify the values among the following expressions:


; (cons f '())                       
; (f f)         
; (cons f (cons 10 (cons (f 10) '())))

;  Exercise 244. Argue why the following sentences are now legal:
; (define (f x) (x 10))
; 
; (define (f x) (x f))
; 
; (define (f x y) (x 'a y 'b))
; 
; Explain your reasoning. 


;  Exercise 245
; Develop the function=at-1.2-3-and-5.775? function. Given two functions from numbers to numbers, the function determines
; whether the two produce the same results for 1.2, 3, and -5.775.


(define (square x) (* x x))
(define (abs-squared x) (* (abs x) (abs x)))

(check-expect (function=at-1.2-3-and-5.775? square abs-squared) true)
(check-expect (function=at-1.2-3-and-5.775? square add1) false)

(define (function=at-1.2-3-and-5.775? f1 f2)
  (and (= (f1 1.2) (f2 1.2))
       (= (f1 -3) (f2 -3))
       (= (f1 -5.775) (f2 -5.775))))
