;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 129-136) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;  Exercise 129
; 
; Create BSL lists that represent
; - a list of celestial bodies, say, at least all the planets in our solar system
; - a list of items for a meal, for example, steak, french fries, beans, bread, water, Brie cheese, and ice cream
; - a list of colors.


(cons "Mercury"
      (cons "Venus"
            (cons "Earth"
                  (cons "Mars"
                        (cons "Jupiter"
                              (cons "Saturn"
                                    (cons "Uranus"
                                          (cons "Neptune"
                                                (cons "Pluto"
                                                      (cons "Moon" '()))))))))))

(cons "Pizza"
      (cons "Garlic Bread"
            (cons "Salad"
                  (cons "Soup"
                        (cons "Juice"
                              (cons "Cheddar Cheese"
                                    (cons "Cake"
                                          (cons "Coffee" '()))))))))

(cons "red"
      (cons "orange"
            (cons "yellow"
                  (cons "green"
                        (cons "blue"
                              (cons "cyan"
                                    (cons "magenta" '())))))))


;  Exercise 130
; Create an element of List-of-names that contains five Strings. 


(cons "Alpha"
      (cons "Bravo"
            (cons "Charlie"
                  (cons "Delta"
                        (cons "Echo" '())))))


;  Exercise 131
; Provide a data definition for representing lists of Boolean values.
; The class contains all arbitrarily long lists of Booleans.


;; A List-of-boolean is one of:
;; - '()
;; - (cons Boolean List-of-boolean)
;; interp. a list of Booleans

;  Exercise 132
; Use DrRacket to run contains-flatt? in this example:
; (cons "Fagan"
;   (cons "Findler"
;     (cons "Fisler"
;       (cons "Flanagan"
;         (cons "Flatt"
;           (cons "Felleisen"
;             (cons "Friedman" '())))))))
; What answer do you expect? 


; List-of-names -> Boolean
; determines whether "Flatt" occurs on alon
(check-expect
 (contains-flatt? (cons "X" (cons "Y"  (cons "Z" '()))))
 #false)
(check-expect
 (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
 #true)
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))

;  Exercise 133
; Here is another way of formulating the second cond clause in contains-flatt?:
; ... (cond
;       [(string=? (first alon) "Flatt") #true]
;       [else (contains-flatt? (rest alon))]) ...
; 
; Explain why this expression produces the same answers as the or expression in the version of figure 47. Which version is better? Explain. 


;  Exercise 134
; Develop the contains? function, which determines whether some given string occurs on a given list of strings.


;; String (listof String) -> Boolean
;; produce true if a given string str is contained by a list of string los
(check-expect (contains? "bob" empty) false)
(check-expect (contains? "bob" (cons "alfred" (cons "bob" '()))) true)
(check-expect (contains? "charles" (cons "alfred" (cons "bob" '()))) false)

;(define (contains? str los) false)

(define (contains? str los)
  (cond [(empty? los) false]
        [else (or
               (string=?  str (first los))
               (contains? str (rest  los)))]))

;  Exercise 135
; Use DrRacket’s stepper to check the calculation for
; (contains-flatt? (cons "Flatt" (cons "C" '())))
; 
; Also use the stepper to determine the value of
; (contains-flatt?
;   (cons "A" (cons "Flatt" (cons "C" '()))))
; What happens when "Flatt" is replaced with "B"? 


;  Exercise 136
; Validate with DrRacket’s stepper
; (our-first (our-cons "a" '())) == "a"
; (our-rest (our-cons "a" '())) == '()
