;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 2-One-Of-P2-merge) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; merge-starter.rkt

; Problem:
; 
; Design the function merge. It consumes two lists of numbers, which it assumes are 
; each sorted in ascending order. It produces a single list of all the numbers, 
; also sorted in ascending order. 
; 
; Your solution should explicitly show the cross product of type comments table, 
; filled in with the values in each case. Your final function should have a cond 
; with 3 cases. You can do this simplification using the cross product table by 
; recognizing that there are subtly equal answers. 
; 
; Hint: Think carefully about the values of both lists. You might see a way to 
; change a cell content so that 2 cells have the same value.
; 


;; Data definition

;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)

(define LON0 empty)
(define LON1 (list 9))
(define LON2 (list 3 6))
(define LON3 (list 1 7 8))

#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else (... (fist lon)
                   (fn-for-lon (rest lon)))]))

;; Function definition

;; ListOfNumber ListOfNumber -> ListOfNumber
;; produce a list of numbers from lsta and lstb, in ascending order
;; ASSUME that lsta and lstb are sorted
(check-expect (merge empty empty) empty)
(check-expect (merge empty LON1) LON1)
(check-expect (merge LON2 empty) LON2)
(check-expect (merge LON1 LON2) (list 3 6 9))
(check-expect (merge LON2 LON3) (list 1 3 6 7 8))

;(define (merge lsta lstb))

(define (merge lsta lstb)
  (cond [(empty? lsta) lstb]
        [(empty? lstb) lsta]
        [else (if (< (first lsta) (first lstb))
                  (cons (first lsta) (merge (rest lsta) lstb))
                  (cons (first lstb) (merge lsta (rest lstb))))]))

