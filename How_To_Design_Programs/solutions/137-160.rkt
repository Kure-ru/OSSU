;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 137-160) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


;  Exercise 137
; Compare the template for contains-flatt? with the one for how-many. Ignoring the function name, they are the same. Explain the similarity. 


(define (how-many alos)
  (cond
    [(empty? alos) 0]                     ;base case
    [else (+ (how-many (rest alos)) 1)])) ;recursive case

;  Exercise 138
; Here is a data definition for representing sequences of amounts of money.
; Create some examples to make sure you understand the data definition. 


; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

(define LOA0  '())
(define LOA1 (cons 3 '()))
(define LOA2 (cons 43 (cons 3 '())))

;  Exercise 139
; Design the function pos?, which consumes a List-of-numbers and determines whether all numbers are positive numbers.
; In other words, if (pos? l) yields #true, then l is an element of List-of-amounts.
; 
; Also design checked-sum. The function consumes a List-of-numbers. It produces their sum if the input also belongs to List-of-amounts
; otherwise it signals an error.


; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

(define LON0  '())
(define LON1 (cons 3 '()))
(define LON2 (cons -43 (cons 3 '())))
(define LON3 (cons 1 (cons 2 (cons 3 '()))))
(define LON4 (cons 1 (cons 2 (cons -3 '()))))


;; (listof Number) -> Boolean
;; produce true if all numbers are positive
(check-expect (pos? LON0)  true)
(check-expect (pos? LON1)  true)
(check-expect (pos? LON2) false)
(check-expect (pos? LON3)  true)
(check-expect (pos? LON4) false)

;(define (pos? lon) false)

(define (pos? lon)
  (cond [(empty? lon) true]
        [else
         (and (positive? (first lon))
              (pos? (rest lon)))]))

;; (listof Number) -> Number | Error
;; produce sum of list of number if all numbers are positive, produce error otherwise
(check-expect (checked-sum LON0)  0)
(check-expect (checked-sum LON1)  3)
(check-error (checked-sum LON2))
(check-expect (checked-sum LON3)  6)
(check-error (checked-sum LON4))

;(define (checked-sum lon) 0)

(define (checked-sum lon)
  (cond [(empty? lon) 0]
        [(pos? lon) (+ (first lon)
                       (checked-sum (rest lon)))]
        [else
         (error "checked-sum: expected a List-of-amounts, given a List-of-numbers.")]))

;  Exercise 140
; 
; Design the function all-true, which consumes a list of Boolean values and determines whether all of them are #true.
; Now design one-true, a function that consumes a list of Boolean values and determines whether at least one item on the list is #true. 


;; (listof Boolean) -> Boolean
;; consumes a list of Boolean values and determines whether all of them are #true.
(check-expect (all-true? '())  true)
(check-expect (all-true? (cons true (cons true (cons true '()))))  true)
(check-expect (all-true? (cons true (cons true (cons false '())))) false)

(define (all-true? lob)
  (cond [(empty? lob) true]
        [else
         (and (first lob)
              (all-true? (rest lob)))]))


;; (listof Boolean) -> Boolean
;; consumes a list of Boolean values and determines whether at least one item on the list is #true. 
(check-expect (one-true '())  false)
(check-expect (one-true (cons true (cons true (cons true '()))))  true)
(check-expect (one-true (cons false (cons false (cons true '())))) true)
(check-expect (one-true (cons false (cons false (cons false '())))) false)

(define (one-true lob)
  (cond [(empty? lob) false]
        [else
         (or (first lob)
             (one-true (rest lob)))]))

;  Exercise 141
; 
; If you are asked to design the function cat, which consumes a list of strings and appends them all into one long string,
; you are guaranteed to end up with this partial definition. Guess a function that can create the desired result from the values computed by the sub-expressions.


; List-of-string -> String
; concatenates all strings in l into one long string
 
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
 (cat (cons "ab" (cons "cd" (cons "ef" '()))))
 "abcdef")
 
(define (cat l)
  (cond
    [(empty? l) ""]
    [else
     (string-append (first l)
                    (cat (rest l)))]))

;  Exercise 142
; Design the ill-sized? function, which consumes a list of images loi and a positive number n. It produces the first image on loi that is not an n by n square
; if it cannot find such an image, it produces #false.


; ImageOrFalse is one of:
; – Image
; – #false

(define LOS0 '())
(define LOS1 (cons (rectangle 25 15 "solid" "purple") '()))
(define LOS2 (cons (rectangle 25 15 "solid" "purple")
                   (cons (square 5 "solid" "yellow") '())))
(define LOS3 (cons (square 5 "solid" "orange")
                   (cons (circle 25 "solid" "purple")
                         (cons (square 5 "solid" "yellow") '()))))
(define LOS4 (cons (square 5 "solid" "orange") 
                   (cons (square 5 "solid" "yellow") '())))
(define LOS5 (cons (square 6 "solid" "orange")
                   (cons (ellipse 25 15 "solid" "purple")
                         (cons (square 5 "solid" "yellow") '()))))

;; (listof Image) PositiveNumber -> ImageOrFalse
;; produces the first image on loi that is not an n by n square, false otherwise
(check-expect (ill-sized? LOS0 5) false)
(check-expect (ill-sized? LOS1 5) (rectangle 25 15 "solid" "purple"))
(check-expect (ill-sized? LOS2 5) (rectangle 25 15 "solid" "purple"))
(check-expect (ill-sized? LOS3 5) (circle 25 "solid" "purple"))
(check-expect (ill-sized? LOS4 5) false)
(check-expect (ill-sized? LOS5 5) (square 6 "solid" "orange"))
(check-expect (ill-sized? LOS5 6) (ellipse 25 15 "solid" "purple"))

;(define (ill-sized? loi n) false)

(define (ill-sized? loi n)
  (cond [(empty? loi) false]
        [(not (= (* (image-width  (first loi)) (image-height (first loi)))
                 (sqr n)))
         (first loi)]
        [else (ill-sized? (rest loi) n)]))

;  Exercise 143
; 
; Determine how average behaves in DrRacket when applied to the empty list. Then design checked-average, a function that produces an informative error
; message when it is applied to '(). 


; A List-of-temperatures is one of: 
; – '()
; – (cons CTemperature List-of-temperatures)
 
; A CTemperature is a Number greater than -273.


; List-of-temperatures -> Number
; computes the average temperature
(check-expect
 (average (cons 1 (cons 2 (cons 3 '())))) 2)


(define (average alot)
  (/ (sum alot) (how-many2 alot)))
 
; List-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum alot)
  (cond [(empty? alot) 0]
        [else (+ (first alot) (sum (rest alot)))]))

; List-of-temperatures -> Number or Error
; produce an error message if given list is empty
(check-error (checked-average '()))
(check-expect (checked-average (cons 5 '())) 5)
(check-expect
 (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)

(define (checked-average alot)
  (if (empty? alot)
      (error "checked-average: The input list is empty. Cannot calculate the average.")
      (average alot)))

;  Exercise 144
; 
; Will sum and how-many work for NEList-of-temperatures even though they are designed for inputs from List-of-temperatures?
; If you think they don’t work, provide counter-examples. If you think they would, explain why. 


; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 

; NEList-of-temperatures -> Number
; computes the average temperature 
 
(check-expect (average2 (cons 1 (cons 2 (cons 3 '()))))
              2)
 
(define (average2 ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

; NEList-of-temperatures -> Number
; computes the sum of the given temperatures 
(check-expect
 (sum2 (cons 1 (cons 2 (cons 3 '())))) 6)

;(define (sum ne-l) 0)
(define (sum2 ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum2 (rest ne-l)))]))


;  Exercise 145
; Design the sorted>? predicate, which consumes a NEList-of-temperatures and produces #true if the temperatures are sorted in descending order.
; That is, if the second is smaller than the first, the third smaller than the second, and so on. Otherwise it produces #false.


; NEList-of-temperatures -> Boolean
; produces true if the temperatures are sorted in descending order
(check-expect (sorted>? (cons 1 (cons 2'()))) false)
(check-expect (sorted>? (cons 3 (cons 2'()))) true)
(check-expect (sorted>? (cons 0 (cons 3 (cons 2 '())))) false)
          
;(define (sorted>? ne-l) false) 

(define (sorted>? ne-l)
  (cond [(empty? (rest ne-l)) true]
        [(>= (first ne-l) (first (rest ne-l))) (sorted>? (rest ne-l))]
        [else false]))

;  Exercise 146
; Design how-many for NEList-of-temperatures. Doing so completes average, so ensure that average passes all of its tests, too.


 
; NEList-of-temperatures -> Number 
; counts the temperatures on the given list 
(define (how-many2 ne-l)
  (cond
    [(empty? (rest ne-l)) 1]                      ;base case
    [else (+ (how-many2 (rest ne-l)) 1)]))        ;recursive case

;  Exercise 147
; Develop a data definition for NEList-of-Booleans, a representation of non-empty lists of Boolean values.
; Then redesign the functions all-true and one-true from exercise 140. 



; An NEList-of-Booleans is one of: 
; – (cons Boolean '())
; – (cons Boolean NEList-of-Booleans)
; interp. non-empty lists of booleans

(define LOB1 (cons #t '()))
(define LOB2 (cons #f '()))
(define LOB3 (cons #f (cons #t (cons #f '()))))
(define LOB4 (cons #t (cons #t (cons #t '()))))
(define LOB5 (cons #f (cons #f (cons #f '()))))

;; List-of-boolean -> Boolean
;; produce true if all elements of ne-l is true
(check-expect (all-true LOB1) #t)
(check-expect (all-true LOB2) #f)
(check-expect (all-true LOB3) #f)
(check-expect (all-true LOB4) #t)
(check-expect (all-true LOB5) #f)

(define (all-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else
     (and (first ne-l)
          (all-true (rest ne-l)))]))

;; List-of-boolean -> Boolean
;; produce true if one of the elements of ne-l is true
(check-expect (one-true2 LOB1) #t)
(check-expect (one-true2 LOB2) #f)
(check-expect (one-true2 LOB3) #t)
(check-expect (one-true2 LOB4) #t)
(check-expect (one-true2 LOB5) #f)

(define (one-true2 ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else
     (or (first ne-l)
         (one-true2 (rest ne-l)))]))

;  Exercise 148
; Compare the function definitions from this section (sum, how-many, all-true, one-true) with the corresponding function definitions from the preceding sections.
; Is it better to work with data definitions that accommodate empty lists as opposed to definitions for non-empty lists? Why? Why not? 


;  Exercise 149
; Does copier function properly when you apply it to a natural number and a Boolean or an image? Or do you have to design another function? Read Abstraction for an answer.


;  Exercise 150
; Design the function add-to-pi. It consumes a natural number n and adds it to pi without using the primitive + operation.
; Once you have a complete definition, generalize the function to add, which adds a natural number n to some arbitrary number x without using +. 


; N -> Natural
; produce (+ n pi) without using +
 
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
 
(define (add-to-pi n)
  (cond [(zero? n) pi]
        [else (add1 (add-to-pi (sub1 n)))]))

; N -> Natural
; add a natural number n to some number x without using +
(check-expect (add 3 7) 10)

(define (add n x)
  (cond [(zero? n) x]
        [else (add (sub1 n) (add1 x))]))

;  Exercise 151
; Design the function multiply. It consumes a natural number n and multiplies it with a number x without using *.


; N -> Natural
; multiply a natural number n with a number x without using *
(check-expect (multiply 0 6) 0)
(check-expect (multiply 5 0) 0)
(check-expect (multiply 2 3) 6)
(check-expect (multiply 4 5) 20)

(define (multiply n x)
  (cond [(zero? n) 0]
        [else (+ x (multiply (sub1 n) x))]))

;  Exercise 152
; Design two functions: col and row.
; 
; The function col consumes a natural number n and an image img. It produces a column—a vertical arrangement—of n copies of img.
; The function row consumes a natural number n and an image img. It produces a row—a horizontal arrangement—of n copies of img. 


(define IMG (square 10 "outline" "black"))

; Natural Image -> Image

;(define (col n img) (square 0 "outline" "white"))
(check-expect (col 0 IMG) empty-image)
(check-expect (col 1 IMG) (above IMG empty-image))
(check-expect (col 3 IMG) (above IMG IMG IMG empty-image))

(define (col n img)
  (cond [(zero? n) empty-image]
        [else (above img
                     (col (sub1 n) img))]))


; Natural Image -> Image
(check-expect (row 0 IMG) empty-image)
(check-expect (row 1 IMG) (beside IMG empty-image))
(check-expect (row 3 IMG) (beside IMG IMG IMG empty-image))

(define (row n img)
  (cond [(zero? n) empty-image]
        [else (beside img (row (sub1 n) img))]))

;  Exercise 153
; The goal of this exercise is to visualize the result of a 1968-style European student riot. Here is the rough idea. A small group of students meets to make
; paint-filled balloons, enters some lecture hall, and randomly throws the balloons at the attendees. Your program displays how the balloons color the seats in the lecture hall.


(define ROWS 18)
(define COLS 8)
(define WIDTH 10)
(define CASE (square WIDTH "outline" "black"))
(define GRID (col ROWS (row COLS CASE)))
(define MTS (empty-scene (* WIDTH COLS) (* WIDTH ROWS)))
(define HALL (overlay GRID MTS))
(define BALLOON (circle 5 "solid" "red"))

;; List-of-Posn -> Image
;; consumes a lop and produces an image of MTS with red dots added
;; as specified by each Posn
(check-expect (add-balloons '()) HALL)
(check-expect (add-balloons
               (cons (make-posn 5 10) '()))
              (place-image BALLOON 5 10 HALL))
(check-expect (add-balloons
               (cons (make-posn 5 10)
                     (cons (make-posn 50 120) '())))
              (place-image BALLOON 5 10
                           (place-image BALLOON 50 120 HALL)))

;(define (add-balloons lop) MTS)

(define (add-balloons lop)
  (cond [(empty? lop) HALL]
        [else (place-image BALLOON
                           (posn-x (first lop))
                           (posn-y (first lop))
                           (add-balloons (rest lop)))]))


;  Exercise 154
; Design the function colors. It consumes a Russian doll and produces a string of all colors, separated by a comma and a space. Thus our example should produce
; "yellow, green, red"


(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)

(define L1 (make-layer "green" "red"))
(define L2 (make-layer "yellow" (make-layer "green" "red")))
(define L3 (make-layer "pink" (make-layer "black" "white")))


(define RD3 (overlay
             (overlay
              (overlay/offset (circle 10 "solid" "white")
                              0 15
                              (isosceles-triangle 50 50 "solid" "white"))
              (overlay/offset (circle 15 "solid" "black")
                              0 15
                              (isosceles-triangle 60 60 "solid" "black")))
             (overlay/offset (circle 20 "solid" "pink")
                             0 15
                             (isosceles-triangle 70 70 "solid" "pink"))))


; RD -> Number
; how many dolls are a part of an-rd
(check-expect (depth "red") 1)
(check-expect
 (depth
  (make-layer "yellow" (make-layer "green" "red")))
 3)

(define (depth an-rd)
  (cond
    [(string? an-rd) 1]
    [else (+ (depth (layer-doll an-rd)) 1)]))

;; RD -> String
;; consumes a Russian doll and produces a string of all colors
(check-expect (rd-color L1) "green, red")
(check-expect (rd-color L2) "yellow, green, red")

;(define (color rd) empty)

(define (rd-color rd)
  (cond [(string? rd) rd]
        [else (string-append (layer-color rd)
                             ", "
                             (rd-color (layer-doll rd)))]))

;  Exercise 155
; 
; Design the function inner, which consumes an RD and produces the (color of the) innermost doll.
; Use DrRacket’s stepper to evaluate (inner rd) for your favorite rd. 


;; RD -> String
;; consumes an RD and produces the (color of the) innermost doll
(check-expect (inner L1) "red")
(check-expect (inner L2) "red")
(check-expect (inner L3) "white")

;(define (inner rd) "")

(define (inner rd)
  (cond [(string? rd) rd]
        [else (rd-color (layer-doll rd))]))

;  Exercise 156
; Equip the program in figure 61 with tests and make sure it passes those.
; Explain what main does. Then run the program via main. 


(define HEIGHT 80) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))
 
; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))

; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interp. the collection of shots fired 

; A Shot is a Number
; interp. represents the shot's y-coordinate

; A ShotWorld is List-of-numbers. 
; interp. each number on such a list
;   represents the y-coordinate of a shot

(define SW0 '())
(define SW1 (cons 5 '()))
(define SW2 (cons 77 (cons 13 '())))
(define SW3 (cons -1 (cons 34 (cons 65 '()))))

;ShotWorld -> ShotWorld
; ShotWorld -> ShotWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))


; ShotWorld -> Image
; adds the image of a shot for each  y on w 
; at (MID,y} to the background image
(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))

;(define (to-image w) BACKGROUND)

(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))

; ShotWorld -> ShotWorld
; moves each shot on w up by one pixel
(check-expect (tock SW1) (cons 4 '()))
(check-expect (tock SW2) (cons 76 (cons 12 '())))
(check-expect (tock SW3) (cons 33 (cons 64 '())))

(define (tock w)
  (cond [(empty? w) '()]
        [else
         (if (negative? (first w))
             (tock (rest w))
             (cons (sub1 (first w)) (tock (rest w))))]))

; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world if the player presses the space bar
(check-expect (keyh SW1 " ") (cons HEIGHT SW1))
(check-expect (keyh SW1 "a") SW1)
(check-expect (keyh SW1 "up") SW1)
(check-expect (keyh SW2 " ") (cons HEIGHT SW2))
(check-expect (keyh SW2 "down") SW2)

(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))

;  Exercise 157
; Experiment to determine whether the arbitrary decisions concerning constants are easy to change.
; For example, determine whether changing a single constant definition achieves the desired outcome:
; change the height of the canvas to 220 pixels;
; change the width of the canvas to 30 pixels;
; change the x location of the line of shots to “somewhere to the left of the middle”;
; change the background to a green rectangle; and
; change the rendering of shots to a red elongated rectangle.
; Also check whether it is possible to double the size of the shot without changing anything else or to change its color to black. 


;  Exercise 158
; If you run main, press the space bar (fire a shot), and wait for a goodly amount of time, the shot disappears from the canvas.
; When you shut down the world canvas, however, the result is a world that still contains this invisible shot.


;  Exercise 159
; Turn the solution of exercise 153 into a world program. Its main function, dubbed riot, consumes how many balloons the students want to throw
; its visualization shows one balloon dropping after another at a rate of one per second. The function produces the list of Posns where the balloons hit.



; Natural Image -> Image
;(define (col n img) (square 0 "outline" "white"))
(check-expect (col 0 IMG) empty-image)
(check-expect (col 1 IMG) (above IMG empty-image))
(check-expect (col 3 IMG) (above IMG IMG IMG empty-image))

(define (col n img)
  (cond [(zero? n) empty-image]
        [else (above img
                     (col (sub1 n) img))]))


; Natural Image -> Image
(check-expect (row 0 IMG) empty-image)
(check-expect (row 1 IMG) (beside IMG empty-image))
(check-expect (row 3 IMG) (beside IMG IMG IMG empty-image))

(define (row n img)
  (cond [(zero? n) empty-image]
        [else (beside img (row (sub1 n) img))]))

;; Constants

(define IMG (square 10 "outline" "black"))
(define ROWS 18)
(define COLS 8)
(define WIDTH 10)
(define CASE (square WIDTH "outline" "black"))
(define GRID (col ROWS (row COLS CASE)))
(define MTS (empty-scene (* WIDTH COLS) (* WIDTH ROWS)))
(define HALL (overlay GRID MTS))
(define BALLOON (circle 5 "solid" "red"))

;; -------------------
;; Data Definitions

(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons 
; must yet be thrown and added to lob

(define P1 (make-pair 2 '()))
(define P2
  (make-pair 1 (cons (make-posn 100 120) '())))
(define P3
  (make-pair 3
             (cons (make-posn 40 90)
                   (cons (make-posn 80 50)
                         (cons (make-posn 120 155) '())))))
(define P4 (make-pair 0 (cons (make-posn 100 200) '())))


;; Functions

;; Pair -> Pair
;; lecture hall riot
;; run with (riot N)
(define (riot n)
  (big-bang (make-pair n '())
    [to-draw    render-balloons]
    [on-tick    new-balloon 1]))


;; Pair -> Image
;; consumes a Pair and produces an image of MTS with balloons added
;; as specified by each lob in the Pair
(check-expect (render-balloons P1) HALL)
(check-expect (render-balloons P2)
              (place-image BALLOON 100 120 HALL))
(check-expect
 (render-balloons P3)
 (place-image BALLOON 40 90
              (place-image BALLOON 80 50
                           (place-image BALLOON 120 155 HALL))))

(define (render-balloons p)
  (add-balloons (pair-lob p)))


;; List-of-Posn -> Image
;; consumes a lop and produces an image of MTS with red dots added
;; as specified by each Posn
(check-expect (add-balloons '()) HALL)
(check-expect (add-balloons
               (cons (make-posn 5 10) '()))
              (place-image BALLOON 5 10 HALL))
(check-expect (add-balloons
               (cons (make-posn 5 10)
                     (cons (make-posn 50 120) '())))
              (place-image BALLOON 5 10
                           (place-image BALLOON 50 120 HALL)))

;(define (add-balloons lop) MTS)

(define (add-balloons lop)
  (cond [(empty? lop) HALL]
        [else (place-image BALLOON
                           (posn-x (first lop))
                           (posn-y (first lop))
                           (add-balloons (rest lop)))]))

;; Pair -> Pair
;; while balloon# > 0, add a new balloon at random pos to lob
(define (new-balloon b)
  (throw b (make-posn (random (image-width HALL))
                      (random (image-height HALL)))))



;; Pair Posn -> Pair
;; add a new balloon to lob and subtract one balloon from pair
(check-expect (throw P1 (make-posn 50 130))
              (make-pair 1 (cons (make-posn 50 130) '())))
(check-expect (throw P2 (make-posn 20 25))
              (make-pair 0 (cons (make-posn 20 25)
                                 (cons (make-posn 100 120) '()))))
(check-expect
 (throw P3 (make-posn 75 80))
 (make-pair
  2 (cons (make-posn 75 80)
          (cons (make-posn 40 90)
                (cons (make-posn 80 50)
                      (cons (make-posn 120 155) '()))))))

(define (throw p pos)
  (cond [(zero? (pair-balloon# p)) p]
        [else (make-pair (sub1 (pair-balloon# p)) (cons pos (pair-lob p)))]))

;  Exercise 160
; Design the functions set+.L and set+.R, which create a set by adding a number x to some given set s for the left-hand and right-hand data definition, respectively. 



(define S1 (cons 1 (cons 2 '())))
; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)
; 
; Son is used when it 
; applies to Son.L and Son.R
(check-expect (set+.L  S1 3) (cons 3 (cons 1  (cons 2 '()))))

;(define (set+.L s n) empty)

(define (set+.L s n)
  (cond [(empty? s) empty]
        [else (cons n s)]))

; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s


(check-expect (set+.R  S1 3) (cons 3 (cons 1  (cons 2 '()))))
(check-expect (set+.R  S1 1) S1)
(check-expect (set+.R  S1 2) S1)

;(define (set+.R s n) empty)

(define (set+.R s n)
  (cond [(empty? s) empty]
        [(not (member n s)) (cons n s)]
        [else s]))
