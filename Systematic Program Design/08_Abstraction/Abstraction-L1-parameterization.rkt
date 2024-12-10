;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Abstraction-L1-psrameterization) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; parameterization-starter.rkt

(define (area r)
  (* pi (sqr r)))

(area 4) ;area of circle radius 4
(area 6) ;area of circle radius 6

;; ====================

;; String (listof String) -> Boolean
;; produce true if los includes s
(check-expect (contains? "UBC" empty) false)
(check-expect (contains? "UBC" (cons "McGill" empty)) false)
(check-expect (contains? "UBC" (cons "UBC" empty)) true)
(check-expect (contains? "UBC" (cons "McGill" (cons "UBC" empty))) true)
(check-expect (contains? "Toronto" (cons "UBC" (cons "McGill" empty))) false)

(define (contains? s los)
  (cond [(empty? los) false]
        [else
         (if (string=? (first los) s)
             true
             (contains? s (rest los)))]))

;; ====================

;; (X -> Y) (listof X) -> (listof Y)
;; given fn and (list n0 n1 ...) produce (list (fn n0) (fn n1) ...)
(check-expect (map2 sqr empty) empty)
(check-expect (map2 sqr (list 2 4)) (list 4 16))
(check-expect (map2 sqrt (list 16 9)) (list 4 3))
(check-expect (map2 abs (list 2 -3 4)) (list 2 3 4))
(check-expect (map2 string-length (list "a" "bb" "ccc")) (list 1 2 3))

(define (map2 fn lon)
  (cond [(empty? lon) empty]
        [else
         (cons (fn (first lon))
               (map2 fn (rest lon)))]))

;; ====================

;;(X -> Boolean ) (listof X) -> (listof X)
;; filter list to contain only those elements for which pred produces true
(check-expect (filter2  positive? empty) empty)
(check-expect (filter2  negative? (list 1 -2 3 -4)) (list -2 -4))
(check-expect (filter2  positive? (list 1 -2 3 -4)) (list 1 3))
(check-expect (filter2 false? (list false true false false true)) (list false false false))

(define (filter2 pred lon)
  (cond [(empty? lon) empty]
        [else
         (if (pred (first lon))
             (cons (first lon)
                   (filter2 pred (rest lon)))
             (filter2 pred (rest lon)))]))