;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Search-P1-maze) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require racket/list) ;gets list-ref, take and drop

; 
; In this problem set you will design a program to check whether a given simple maze is
; solvable.  Note that you are operating on VERY SIMPLE mazes, specifically:
; 
;    - all of your mazes will be square
;    - the maze always starts in the upper left corner and ends in the lower right corner
;    - at each move, you can only move down or right
; 
; Design a representation for mazes, and then design a function that consumes a maze and
; produces true if the maze is solvable, false otherwise.
; 
; Solvable means that it is possible to start at the upper left, and make it all the way to
; the lower right.  Your final path can only move down or right one square at a time. BUT, it
; is permissible to backtrack if you reach a dead end.
; 
; For example, the first three mazes below are solvable.  Note that the fourth is not solvable
; because it would require moving left. In this solver you only need to support moving down
; and right! Moving in all four directions introduces complications we are not yet ready for.
; 
;     .    .    .    .
; 
; 
; Your function will of course have a number of helpers. Use everything you have learned so far
; this term to design this program. 
; 
; One big hint. Remember that we avoid using an image based representation of information unless
; we have to. So the above are RENDERINGs of mazes. You should design a data definition that
; represents such mazes, but don't use images as your representation.
; 
; For extra fun, once you are done, design a function that consumes a maze and produces a
; rendering of it, similar to the above images.
; 



;; Solve simple square mazes

;; Constants:


;; Convert 0-based row and column to Pos
(define (r-c->pos r c) (+ (* r 5) c))


(define START (r-c->pos 0 0))
(define END   (r-c->pos 4 4))


(define M1
  (list true  false false false false
        true  true  false true  true
        false true  false false false
        true true  false false false
        true  true  true true true))

(define M2
  (list true  true  true  true  true
        true  false false false true
        true  false false false true
        true  false false false true
        true  false false false true))

(define M3
  (list true  true  true  true  true
        true  false false false false
        true  false false false false
        true  false false false false
        true  true  true  true  true))

(define M4                            ;not solvable
  (list true  true  true  true  true
        true  false false false true
        true  false true  true  true
        true  false true  false false
        false false  true  true  true))

;; Positions of all the rows and columns

(define ROWS
  (list (list  0  1  2  3  4)
        (list  5  6  7  8  9)
        (list 10 11 12 13 14)
        (list 15 16 17 18 19)
        (list 20 21 22 23 24)))

(define COLS
  (list (list  0  1  2  3  4)
        (list  5  6  7  8  9)
        (list 10 11 12 13 14)
        (list 15 16 17 18 19)
        (list 20 21 22 23 24)))


;; Data definitions:

;; Maze is (listof Booleans) that is 25 elements long
;; interp. Visually a maze is a 5x5 array of squares, where each square has a row and a column number (r, c).
;; We represent it as a single flat list, in which the rows are layed out one after another
;; in a linear fashion. (Cf. interp. of Pos below)
;; True means that there is a path

;; Pos is Natural[0, 24]
;; interp. The position of each square in the maze. There are 25 of these for the 5 rows, 5 columns
;;    - the row    is (quotient  p 5)
;;    - the column is (remainder p 5)

;; Functions:

;; Maze Pos -> Boolean
;; produce true or false at given position on Maze.
(check-expect (read-square M1 (r-c->pos 0 4)) false)
(check-expect (read-square M3 (r-c->pos 4 3))  true)

;(define (read-square m p) false)
(define (read-square m p)
  (list-ref m p))


;; Maze -> Boolean
;; produce true if the maze is solvable (means that there is a path from start to end)
(check-expect (solve START M1) true)
(check-expect (solve START M2) true)
(check-expect (solve START M3) true)
(check-expect (solve START M4) false)

;(define (solve m) false)

(define (solve p m)
  (local [(define (solve--m p m)
            (if (solved? p)
                true
                (solve--lom (next-pos p m) m)))
          (define (solve--lom lop m)
            (cond
              [(empty? lop) false]
              [else
               (local [(define try (solve--m (first lop) m))]
                 (if (not (false? try))
                     try
                     (solve--lom (rest lop) m)))]))]
    (solve--m p m)))

;; Maze -> Boolean
;; produce true if maze is solved, which means p is at pos END
(check-expect (solved? (r-c->pos 4 4)) true)
(check-expect (solved? (r-c->pos 2 0)) false)

;(define (solved? p) false)
(define (solved? p)
  (= p (r-c->pos 4 4)))

;; Pos Maze -> (listof Pos)
;; produce list of next pos from pos
(check-expect (next-pos 0 M1) (list 5))
(check-expect (next-pos (r-c->pos 4 2) M1) (list 23))
(check-expect (next-pos (r-c->pos 3 4) M1) (list 20 24))

;(define (next-pos p) empty)

(define (next-pos p m)
  (keep-only-valid (move-pos p) m))

;; Pos -> Pos
;; produce list of position for next pos
(check-expect (move-pos 0) (list 1 5))
(check-expect (move-pos 7) (list (+ 1 7) (+ 5 7)))


;(define (move-pos p) empty)
(define (move-pos p)
  (list (+ 1 p) (+ 5 p)))

;; (listof Pos) Maze -> (listof Pos)
;; produce list of only valid pos
(check-expect (keep-only-valid (list 1 5) M1) (list 5))
(check-expect (keep-only-valid (list 7 8) M2) empty)
(check-expect (keep-only-valid (list 24 25) M2) (list 24))

(define (keep-only-valid lop m)
  (filter (lambda (pos) (valid-pos? pos m)) lop))

;; Pos Maze -> Boolean
;; produce true if pos is within the board, and the value is true
(check-expect (valid-pos? 25 M2) false)
(check-expect (valid-pos? 1 M1) false)
(check-expect (valid-pos? 5 M1) true)

;(define (valid-pos? pos m) false)

(define (valid-pos? pos m)
  (and (<= 0 pos 24)
       (read-square m pos)))

