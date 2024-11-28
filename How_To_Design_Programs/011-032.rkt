;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 011-032) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/batch-io)

;  Exercise 11
; 
; Define a function that consumes two numbers, x and y, and that computes the distance of point (x,y) to the origin.


(define (compute-distance x y)
  (sqrt (+ (sqr x) (sqr y))))

;  Exercise 12
; 
; Define the function cvolume, which accepts the length of a side of an equilateral cube and computes its volume.
; If you have time, consider defining csurface, too.


(define (cvolume x)
  (* x x x))

(define (csurface x)
  (* 6 (sqr x))) 

;  Exercise 13
; 
; Define the function string-first, which extracts the first 1String from a non-empty string. 


(define (string-first str)
  (if (> (string-length str) 0)
      (substring str 0 1)
      ""))

;  Exercise 14
; 
; Define the function string-last, which extracts the last 1String from a non-empty string. 


(define (string-last str)
  (if (> (string-length str) 0)
      (substring str (- (string-length str) 1))
      ""))

;  Exercise 15
; 
; Define ==>. The function consumes two Boolean values, call them sunny and friday. Its answer is #true if sunny is false or friday
; is true. Note Logicians call this Boolean operation implication, and they use the notation sunny => friday for this purpose. 


(define (===> sunny friday)
  (or (not sunny) friday))

;  Exercise 16
; 
; Define the function image-area, which counts the number of pixels in a given image. 


(define (image-area img)
  (* (image-width img) (image-height img)))

;  Exercise 17
; 
; Define the function image-classify, which consumes an image and conditionally produces "tall" if the image is taller than wide,
; "wide" if it is wider than tall, or "square" if its width and height are the same.


(define (image-classify img)
  (if (= (image-height img) (image-width img))
      "square"
      (if (> (image-height img) (image-width img))
      "tall"
      "wide")))

;  Exercise 18
; 
; Define the function string-join, which consumes two strings and appends them with "_" in between.


(define (string-join str1 str2)
  (string-append str1 "_" str2))

;  Exercise 19
; 
; Define the function string-insert, which consumes a string str plus a number i and inserts "_" at the ith position of str.
; Assume i is a number between 0 and the length of the given string (inclusive). See exercise 3 for ideas. Ponder how string-insert copes with "". 


(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i)))

;  Exercise 20
; 
; Define the function string-delete, which consumes a string plus a number i and deletes the ith position from str. Assume i is a number between 0
; (inclusive) and the length of the given string (exclusive). See exercise 4 for ideas. Can string-delete deal with empty strings?


(define (string-delete str i)
  (string-append (substring str 0 i) (substring str (+ 1 i))))

; Exercise 21
; 
; Use DrRacket’s stepper to evaluate (ff (ff 1)) step-by-step. Also try (+ (ff 1) (ff 1)). Does DrRacket’s stepper reuse the results of computations? 


(define (ff x)
  (* 10 x))

; run with stepper
(ff (ff 1))
(+ (ff 1) (ff 1))

;  Exercise 22
; Use DrRacket’s stepper on this program fragment. Does the explanation match your intuition? 


(define (distance-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))

(distance-to-origin 3 4)

;  Exercise 23
; 
; The first 1String in "hello world" is "h". How does the following function compute this result?


(define (string-first-2 s)
  (substring s 0 1))

(string-first-2 "hello world")

;  Exercise 24
; 
; Here is the definition of ==>: y
; Use the stepper to determine the value of (==> #true #false). 


(define (==>2 x y)
  (or (not x) y))

(==>2 #true #false)

; Exercise 25
; 
; Take a look at this attempt to solve exercise 17. Does stepping through an application suggest a fix? 


(define (image-classify2 img)
  (cond
    [(>= (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [(<= (image-height img) (image-width img)) "wide"]))

;  Exercise 26
; 
; What do you expect as the value of this program.
; Confirm your expectation with DrRacket and its stepper. 


(define (string-insert2 s i)
  (string-append (substring s 0 i)
                 "_"
                 (substring s i)))
 
(string-insert2 "helloworld" 6)


; Sample Problem The owner of a monopolistic movie theater in a small town has complete freedom in setting ticket prices. The more he charges, the fewer people can afford
; tickets. The less he charges, the more it costs to run a show because attendance goes up. In a recent experiment the owner determined a relationship between the price of a
; ticket and average attendance.
; 
; At a price of $5.00 per ticket, 120 people attend a performance. For each 10-cent change in the ticket price, the average attendance changes by 15 people. That is, if the
; owner charges $5.10, some 105 people attend on the average. If the price goes down to $4.90, average attendance increases to 135. Let’s translate this idea into a
; mathematical formula:
; 
; .
; 
; Stop! Explain the minus sign before you proceed.
; Unfortunately, the increased attendance also comes at an increased cost. Every performance comes at a fixed cost of $180 to the owner plus a variable cost of $0.04 per attendee.
; 
; The owner would like to know the exact relationship between profit and ticket price in order to maximize the profit.


; Exercise 27
; 
; Our solution to the sample problem contains several constants in the middle of functions. As One Program, Many Definitions already points out, it is
; best to give names to such constants so that future readers understand where these numbers come from. Collect all definitions in DrRacket’s definitions area and change
; them so that all magic numbers are refactored into constant definitions. 


;(define BASE-ATTENDEES 120)
;(define BASE-PRICE 5.0)
;(define AVG-ATTENDANCE-CHANGE 15)
;(define BASE-CHANGE 0.1)
;(define FIXED-COST 180)
;(define VARIABLE-COST 0.04)
;
;(define (attendees ticket-price)
;  (- BASE-ATTENDEES (* (- ticket-price BASE-PRICE) (/ AVG-ATTENDANCE-CHANGE BASE-CHANGE))))
;
;(define (revenue ticket-price)
;  (* ticket-price (attendees ticket-price)))
;
;(define (cost ticket-price)
;  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))
;
;(define (profit ticket-price)
;  (- (revenue ticket-price)
;     (cost ticket-price)))

;  Exercise 28
; 
; Determine the potential profit for these ticket prices: $1, $2, $3, $4, and $5. Which price maximizes the profit of the movie theater? Determine the best ticket price
; to a dime. 


;(profit 1)
;(profit 2)
;(profit 3)
;(profit 4)
;(profit 5)

;  Exercise 29
; 
; After studying the costs of a show, the owner discovered several ways of lowering the cost. As a result of these improvements, there is no longer a fixed cost
; a variable cost of $1.50 per attendee remains.


;(define BASE-ATTENDEES 120)
;(define BASE-PRICE 5.0)
;(define AVG-ATTENDANCE-CHANGE 15)
;(define BASE-CHANGE 0.1)
;(define FIXED-COST 0)
;(define VARIABLE-COST 1.50)
;
;(define (attendees ticket-price)
;  (- BASE-ATTENDEES (* (- ticket-price BASE-PRICE) (/ AVG-ATTENDANCE-CHANGE BASE-CHANGE))))
;
;(define (revenue ticket-price)
;  (* ticket-price (attendees ticket-price)))
;
;(define (cost ticket-price)
;  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))
;
;(define (profit ticket-price)
;  (- (revenue ticket-price)
;     (cost ticket-price)))
;
;(profit 1)
;(profit 2)
;(profit 3)
;(profit 4)
;(profit 5)

;  Exercise 30
; 
; Define constants for the price optimization program at the movie theater so that the price sensitivity of attendance (15 people for every 10 cents) becomes a computed
; constant. 


(define BASE-ATTENDEES 120)
(define BASE-PRICE 5.0)
(define AVG-ATTENDANCE-CHANGE 15)
(define BASE-CHANGE 0.1)
(define FIXED-COST 0)
(define VARIABLE-COST 1.50)
(define PRICE-SENSITIVITY (/ AVG-ATTENDANCE-CHANGE BASE-CHANGE))

(define (attendees ticket-price)
  (- BASE-ATTENDEES (* (- ticket-price BASE-PRICE) PRICE-SENSITIVITY)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 1)
(profit 2)
(profit 3)
(profit 4)
(profit 5)

; Exercise 31
; 
; Recall the letter program from Composing Functions. Create appropriate files, launch main, and check whether it delivers the expected letter in a given file.


(define (letter fst lst signature-name)
  (string-append
    (opening fst)
    "\n\n"
    (body fst lst)
    "\n\n"
    (closing signature-name)))
 
(define (opening fst)
  (string-append "Dear " fst ","))
 
(define (body fst lst)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))
 
(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                        (read-file in-lst)
                        (read-file in-signature))))

;(main "fst.txt" "lst.txt" "sig.txt" 'stdout)
;(main "fst.txt" "lst.txt" "sig.txt" "letter-output.txt")

;  Exercise 32
; 
; Most people no longer use desktop computers just to run applications but also employ cell phones, tablets, and their cars’ information control screen.
; Soon people will use wearable computers in the form of intelligent glasses, clothes, and sports gear. In the somewhat more distant future, people may come
; with built-in bio computers that directly interact with body functions. Think of ten different forms of events that software applications on such computers will have
; to deal with. 

