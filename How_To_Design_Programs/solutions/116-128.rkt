;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 116-128) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;  Exercise 116
; Take a look at the following sentences.
; Explain why they are syntactically legal expressions.


; x
; x is a variable

; (= y z)
; primitive application

; (= (= y z) 0)
; the expression (= y z) produces a Boolean
; the outer = compares the result with 0

;  Exercise 117
; Consider the following sentences.
; Explain why they are syntactically illegal. 


; (3 + 4)
; operators must precede their arguments (+ 3 4)

; number?
; all primitives nust be used in a valid application

; (x)
; x is not defined as a function

;  Exercise 118
; Take a look at the following sentences.
; Explain why they are syntactically legal definitions. 


; (define (f x) x)
; defines a funtion f with one parameter x and the body (x)

; (define (f x) y)
; defines a funtion f with one parameter x and the body (y)

; (define (f x y) 3)
; defines a funtion f with one parameter x and the constant 3 as the body

;  Exercise 119
; Consider the following sentences.
; Explain why they are syntactically illegal. 


; (define (f "x") x)
; function parameter should be a variable, not a String

; (define (f x y z) (x))
; x is a parameter and not a function

;  Exercise 120
; Discriminate the legal from the illegal sentences.
; Explain why the sentences are legal or illegal. Determine whether the legal ones belong to the category expr or def. 


; (x)
; illegal. x is not defined as a function

; (+ 1 (not x))
; legal (expr)

; (+ 1 2 3)
; legal (expr)


; Exercise 121
; Evaluate the following expressions step-by-step
; 
; (+ (* (/ 12 8) 2/3)
;    (- 20 (sqrt 4)))
;  
; (cond
;   [(= 0 0) #false]
;   [(> 0 1) (string=? "a" "a")]
;   [else (= (/  1 0) 9)])
;  
; (cond
;   [(= 2 0) #false]
;   [(> 2 1) (string=? "a" "a")]
;   [else (= (/  1 2) 9)])


;  Exercise 122
; Suppose the program contains these definitions:
; (define (f x y)
;   (+ (* 3 x) (* y y)))
; Show how DrRacket evaluates the following expressions, step-by-step:
; (+ (f 1 2) (f 2 1))
; 
; (f 1 (* 2 3))
; 
; (f (f 1 (* 2 3)) 19)


;  Exercise 123
; Write down a rule that shows how to reformulate
; (if exp-test exp-then exp-else)
; as a cond expression. 


;(cond [exp-test exp-then]
;      [else exp-else])

;  Exercise 124
; Evaluate the following program, step-by-step:
; (define PRICE 5)
; (define SALES-TAX (* 0.08 PRICE))
; (define TOTAL (+ PRICE SALES-TAX))
; 
; Does the evaluation of the following program signal an error?
; (define COLD-F 32)
; (define COLD-C (fahrenheit->celsius COLD-F))
; (define (fahrenheit->celsius f)
;  (* 5/9 (- f 32)))
; 
; How about the next one?
; (define LEFT -100)
; (define RIGHT 100)
; (define (f x) (+ (* 5 (expt x 2)) 10))
; (define f@LEFT (f LEFT))
; (define f@RIGHT (f RIGHT))


;  Exercise 125
; Discriminate the legal from the illegal sentences:


;(define-struct oops [])                   ;legal
;(define-struct child [parents dob date])  ;legal
;(define-struct (child person) [dob date]) ;illegal, cannot use parenthesis inside define-struct

;  Exercise 126
; Identify the values among the following expressions, assuming the definitions area contains these structure type definitions:


(define-struct point [x y z])
(define-struct none  [])

(make-point 1 2 3)
(make-point (make-point 1 2 3) 4 5)
(make-point (+ 1 2) 3 4)                      ;(make-point 3 3 4)
(make-none)
(make-point (point-x (make-point 1 2 3)) 4 5) ;(make-point 1 4 5)


;  Exercise 127
; 
; Suppose the program contains.
; (define-struct ball [x y speed-x speed-y])
; 
; Predict the results of evaluating the following expression:


(define-struct ball [x y speed-x speed-y])

(number? (make-ball 1 2 3 4))                    ;#false
(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3))   ;3
(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3))         ;6
;(ball-x (make-posn 1 2))                        ;error
;(ball-speed-y 5)                                ;error

;  Exercise 128
; Copy the following tests into DrRacket’s definitions area.
; Validate that all of them fail and explain why. 


;(check-member-of "green" "red" "yellow" "grey")      ;"green" is not a member of "red" "yellow" "grey"

;(check-within (make-posn #i1.0 #i1.1)                ;result is not within epsilon, 0.01
;              (make-posn #i0.9 #i1.2)  0.01)

;(check-range #i0.9 #i0.6 #i0.8)                      ;result is not in the range

;(check-random (make-posn (random 3) (random 9))      ;the order is different in the constructors
;              (make-posn (random 9) (random 3)))

;(check-satisfied 4 odd?)                             ;4 is an even number
