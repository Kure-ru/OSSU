;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 181-194) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require 2htdp/image)

; Exercise 181
; Use list to construct the equivalent of these lists.


(check-expect (cons "a" (cons "b" (cons "c" (cons "d" '()))))
              (list "a" "b" "c" "d"))

(check-expect (cons (cons 1 (cons 2 '())) '())
              (list (list 1 2)))

(check-expect (cons "a" (cons (cons 1 '()) (cons #false '())))
              (list "a" (list 1) #false))

(check-expect (cons (cons "a" (cons 2 '())) (cons "hello" '()))
              (list (list "a" 2) "hello"))

(check-expect (cons (cons 1 (cons 2 '()))
                    (cons (cons 2 '())
                          '()))
              (list (list 1 2)
                    (list 2)))

; Exercise 182
; Use cons and '() to form the equivalent of these lists


(check-expect (list 0 1 2 3 4 5)
              (cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))))

(check-expect (list (list "he" 0) (list "it" 1) (list "lui" 14))
              (cons (cons "he" (cons 0 '())) 
                    (cons (cons "it" (cons 1 '())) 
                          (cons (cons "lui" (cons 14 '())) '()))))

(check-expect (list 1 (list 1 2) (list 1 2 3))
              (cons 1
                    (cons (cons 1 (cons 2 '()))
                          (cons (cons 1 (cons 2 (cons 3 '()))) '()))))


                    

; Exercise 183. On some occasions lists are formed with cons and list.
; Reformulate each of the following expressions using only cons or only list. Use check-expect to check your answers. 


(check-expect (cons "a" (list 0 #false))
              (list "a" 0 #false))

(check-expect (list (cons 1 (cons 13 '())))
              (list (list 1 13)))

(check-expect (cons (list 1 (list 13 '())) '())
              (list (list 1 (list 13 '()))))

(check-expect (list '() '() (cons 1 '()))
              (list (list) (list) (list 1)))

(check-expect (cons "a" (cons (list 1) (list #false '())))
              (list "a" (list 1) #false '()))

 
; Exercise 184.
; Determine the values of the following expressions:


(check-expect (list (string=? "a" "b") #false)
              (list #false #false))

(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
              (list 30 200 0.5))

(check-expect (list "dana" "jane" "mary" "laura")
              (list "dana" "jane" "mary" "laura"))

; Exercise 185.
; You know about first and rest from BSL, but BSL+ comes with even more selectors than that. Determine the values of the following expressions:


(check-expect (first (list 1 2 3))
              1)

(check-expect (rest (list 1 2 3))
              (list 2 3))

(check-expect (second (list 1 2 3))
              2)

;  Exercise 186.
; Take a second look at Intermezzo 1: Beginning Student Language, the intermezzo that presents BSL and its ways of formulating tests.
; One of the latter is check-satisfied, which determines whether an expression satisfies a certain property. Use sorted>? from
; exercise 145 to reformulate the tests for sort> with check-satisfied.



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

; List-of-numbers -> List-of-numbers
; produces a sorted version of l

(check-satisfied (sort> (list 1 2 0 3)) sorted>?)

(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

;  Exercise 187
; Design a program that sorts lists of game players by score


(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points

(check-expect
 (sort-gp (list (make-gp "Alice" 10)
                (make-gp "Bob" 5)
                (make-gp "Carol" 8)))
 (list (make-gp "Bob" 5)
       (make-gp "Carol" 8)
       (make-gp "Alice" 10)))


;; List-of-GamePlayer -> List-of-GamePlayer
;; takes a list of game players and returns it sorted by score increasing
(define (sort-gp logp)
  (cond [(empty? logp) '()]
        [else (insert-gp (first logp) (sort-gp (rest logp)))]))
 
; GamePlayer List-of-GamePlayer -> List-of-GamePlayer
; inserts gp into the sorted list of numbers logp
(define (insert-gp gp logp)
  (cond [(empty? logp) (cons gp '())]
        [else (if (<= (gp-score gp) (gp-score (first logp)))
                  (cons gp logp)
                  (cons (first logp) (insert-gp gp (rest logp))))]))


; Exercise 188
; Design a program that sorts lists of emails by date. 


(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time 

(check-expect
 (sort-email (list (make-email "Alice" 1746144005 "What's up?")
                   (make-email "Bob"   1746142001 "Hey!")
                   (make-email "Bob"   1746358130 "We need to talk...")))
 (list  (make-email "Bob"   1746142001 "Hey!")
        (make-email "Alice" 1746144005 "What's up?")
        (make-email "Bob"   1746358130 "We need to talk...")))

;; List-of-emails -> List-of-emails
;; takes a list of emails and returns it sorted by date
(define (sort-email loe)
  (cond [(empty? loe) '()]
        [else
         (insert-email (first loe) (sort-email (rest loe)))]))


;; Email List-of-emails -> List-of-emails
;; inserts an email into the sorted list of emails
(define (insert-email email loe)
  (cond [(empty? loe) (cons email '())]
        [else
         (if (<= (email-date email) (email-date (first loe)))
             (cons email loe)
             (cons (first loe) (insert-email email (rest loe))))]))  

         
; Exercise 189.
; Here is the function search.
; It determines whether some number occurs in a list of numbers. The function may have to traverse the entire list to find out that the number of interest
; isn’t contained in the list.
; Develop the function search-sorted, which determines whether a number occurs in a sorted list of numbers. The function must take advantage of the fact
; that the list is sorted.


; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))

(check-expect (search-sorted 3 (list 1 2 3 4 5)) #true)
(check-expect (search-sorted 6 (list 1 2 3 4 5)) #false)
(check-expect (search-sorted 1 (list 2 3 4 5)) #false)


;; List-of-numbers -> Boolean
;; ASSUME List-of-numbers is sorted; determines whether a number occurs in a sorted list of numbers
(define (search-sorted n alon)
  (cond [(or (empty? alon)
             (< n (first alon)))
         #false]
        [else (or (= (first alon) n)
                  (search-sorted n (rest alon)))]))

;  Exercise 190
; Design the prefixes function, which consumes a list of 1Strings and produces the list of all prefixes. A list p is a prefix of l if p and l are the
; same up through all items in p. For example, (list "a" "b" "c") is a prefix of itself and (list "a" "b" "c" "d").


(check-expect (prefixes '()) (list '()))
(check-expect (prefixes (list "a" "b" "c")) (list '() (list "a") (list "a" "b") (list "a" "b" "c")))

;; List-of-numbers -> List-of-numbers
; ;which consumes a list of 1Strings and produces the list of all prefixes

(define (prefixes alon)
  (cond [(empty? alon) (list '())]
        [else (cons '() (add-first (first alon) (prefixes (rest alon))))]))

(define (add-first n alon)
  (cond [(empty? alon) '()]
        [else (cons (cons n (first alon))
                    (add-first n (rest alon)))]))

; Exercise 191
; Adapt the second example for the render-poly function to connect-dots. 


(define triangle-p (list (make-posn 20 10) (make-posn 20 20) (make-posn 30 20)))
(define square-p (list (make-posn 20 10) (make-posn 20 10) (make-posn 20 20) (make-posn 10 20)))

; A Polygon is one of:
;   - (list Posn Posn Posn)
;   - (cons Posn Polygon)

; An NELoP is one of:
; - (cons Posn '())
; - (cons Posn NELoP)

; a plain background image
(define MT (empty-scene 50 50))


; Image Polygon - Image
; renders the given polygon p into img
(check-expect
 (render-poly MT triangle-p)
 (scene+line
  (scene+line
   (scene+line MT 20 10 20 20 "red")
   20 20 30 20 "red")
  30 20 20 10 "red"))


(define (render-poly img p)
  (render-line (connect-dots img p)
               (first p)
               (last p)))

; Image Posn Posn -> Image
; draws a red line from Posn p to Posn q into img
(define (render-line img p q)
  (scene+line
   img
   (posn-x p) (posn-y p) (posn-x q) (posn-y q)
   "red"))

; Image NELoP -> Image
; connects the dots in p by rendering lines in img
(define (connect-dots img p)
  (cond
    [(empty? (rest p)) MT]
    [else (render-line
           (connect-dots img (rest p))
           (first p)
           (second p))]))

;  Exercise 192
; Argue why it is acceptable to use last on Polygons. Also argue why you may adapt the template for connect-dots to last:


; Polygon -> Posn
; extracts the last item from p
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))

;  Exercise 193
; Here are two more ideas for defining render-poly
; render-poly could cons the last item of p onto p and then call connect-dots.
; render-poly could add the first item of p to the end of p via a version of add-at-end that works on Polygons.


(check-expect
 (render-poly-1 MT triangle-p)
 (scene+line
  (scene+line
   (scene+line MT 20 10 20 20 "red")
   20 20 30 20 "red")
  30 20 20 10 "red"))

(define (render-poly-1 img p)
  (connect-dots img (add-at-end (first p) p)))

(define (add-at-end pos p)
  (cond [(empty? (rest p))
         (cons (first p) (cons pos '()))]
        [else
         (cons (first p) (add-at-end pos (rest p)))]))

;  Exercise 194
; Modify connect-dots so that it consumes an additional Posn to which the last Posn is connected. Then modify render-poly to use this new version of connect-dots.


(check-expect
 (render-poly-2 MT triangle-p)
 (scene+line
  (scene+line
   (scene+line MT 20 10 20 20 "red")
   20 20 30 20 "red")
  30 20 20 10 "red"))

(define (render-poly-2 img p)
  (connect-dots-1 img p (first p)))

(define (connect-dots-1 img p pos)
  (cond
    [(empty? (rest p)) (render-line img (first p) pos)]
    [else (render-line
           (connect-dots-1 img (rest p) pos)
           (first p)
           (second p))]))