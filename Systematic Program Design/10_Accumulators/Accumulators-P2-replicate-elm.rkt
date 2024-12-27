;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Accumulators-P2-replicate-elm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; replicate-elm-starter.rkt

; 
; PROBLEM:
; 
; Design a function that consumes a list of elements and a natural n, and produces 
; a list where each element is replicated n times. 
; 
; (replicate-elm (list "a" "b" "c") 2) should produce (list "a" "a" "b" "b" "c" "c")
; 


;; (listof X) Natural -> (listof X)
;; produce a list where each element is replicated n times
(check-expect (replicate-elm (list "a" "b" "c") 2) (list "a" "a" "b" "b" "c" "c")) 

;(define (replicate-elm lox n) empty)

(define (replicate-elm lox0 n)
  (local [(define (replicate-elm lox acc)
            (cond [(empty? lox) empty]
                  [else
                   (if (zero? acc)
                       (replicate-elm (rest lox) n) 
                       (cons (first lox) (replicate-elm lox (sub1 acc))))]))]
    (replicate-elm lox0 n)))