;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Mutual-Ref-P2-find-person) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; find-person-starter.rkt

; 
; The following program implements an arbitrary-arity descendant family 
; tree in which each person can have any number of children.
; 
; PROBLEM A:
; 
; Decorate the type comments with reference arrows and establish a clear 
; correspondence between template function calls in the templates and 
; arrows in the type comments.
; 


;; Data definitions:

(define-struct person (name age kids))

;; Person is (make-person String Natural ListOfPerson)
;; interp. A person, with first name, age and their children
(define P1 (make-person "N1" 5 empty))
(define P2 (make-person "N2" 25 (list P1)))
(define P3 (make-person "N3" 15 empty))
(define P4 (make-person "N4" 45 (list P3 P2)))

(define (fn-for-person p)
  (... (person-name p)			;String
       (person-age p)			;Natural  
       (fn-for-lop (person-kids p))))   


;; ListOfPerson is one of:
;;  - empty
;;  - (cons Person ListOfPerson)
;; interp. a list of persons
#;
(define (fn-for-lop lop)
  (cond [(empty? lop) (...)]
        [else
         (... (fn-for-person (first lop))   
              (fn-for-lop (rest lop)))]))


;; Functions:

; PROBLEM B:
; 
; Design a function that consumes a Person and a String. The function
; should search the entire tree looking for a person with the given 
; name. If found the function should produce the person's age. If not 
; found the function should produce false.


;; Person String -> Integer or false
;; Person String -> Integer or false
;; search the given tree for a person with the given name, produce age if found; false otherwise
(check-expect (find--lop "N1" empty) false)
(check-expect (find--person "N2" P1) false)
(check-expect (find--person "N1" P1) 5)
(check-expect (find--lop "N3" (cons P1 (cons P2 (cons P3 empty)))) 15) 
(check-expect (find--lop "N4" (cons P1 (cons P2 (cons P3 empty)))) false) 
(check-expect (find--person "N1" P2) 5)
(check-expect (find--person "N3" P2) false)
(check-expect (find--person "N2" P4) 25)
(check-expect (find--person "N1" P4) 5)

;(define (find--person name p) false)
;(define (find--lop    name p) false)

(define (find--person name p)
  (if (string=? name (person-name p))
      (person-age p)		
      (find--lop name (person-kids p))))

(define (find--lop name lop)
  (cond [(empty? lop) false]
        [else
         (if (not (false? (find--person name (first lop))))
             (find--person name (first lop))
             (find--lop name (rest lop)))]))
