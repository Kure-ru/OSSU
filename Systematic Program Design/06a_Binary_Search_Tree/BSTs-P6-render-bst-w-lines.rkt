;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname BSTs-P6-render-bst-w-lines) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; render-bst-w-lines-starter.rkt

(require 2htdp/image)

; PROBLEM:
; 
; Given the following data definition for a binary search tree,
; design a function that consumes a bst and produces a SIMPLE 
; rendering of that bst including lines between nodes and their 
; subnodes.
; 
; To help you get started, we've added some sketches below of 
; one way you could include lines to a bst.


;; Constants

(define TEXT-SIZE  14)
(define TEXT-COLOR "BLACK")

(define KEY-VAL-SEPARATOR ":")

(define MTTREE (rectangle 20 1 "solid" "white"))

(define NODE-W 50)
(define NODE-H 20)


;; Data definitions:

(define-struct node (key val l r))
;; A BST (Binary Search Tree) is one of:
;;  - false
;;  - (make-node Integer String BST BST)
;; interp. false means no BST, or empty BST
;;         key is the node key
;;         val is the node val
;;         l and r are left and right subtrees
;; INVARIANT: for a given node:
;;     key is > all keys in its l(eft)  child
;;     key is < all keys in its r(ight) child
;;     the same key never appears twice in the tree
; .

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST7 (make-node 7 "ruf" false false)) 
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             (make-node 50 "dug" false false)))
(define BST10
  (make-node 10 "why" BST3 BST42))
(define BST100 
  (make-node 100 "large" BST10 false))
#;
(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t)    ;Integer
              (node-val t)    ;String
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic-distinct: false
;;  - compound: (make-node Integer String BST BST)
;;  - self reference: (node-l t) has type BST
;;  - self reference: (node-r t) has type BST

;; Functions:

; 
; Here is a sketch of one way the lines could work. What 
; this sketch does is allows us to see the structure of
; the functions pretty clearly. We'll have one helper for
; the key value image, and one helper to draw the lines.
; Each of those produces a rectangular image of course.
; 
; .
; 
; And here is a sketch of the helper that draws the lines:
; .  
; where lw means width of left subtree image and
;       rw means width of right subtree image


;; Constants


;; Functions

;; BST -> Image
;; produce SIMPLE rendering of bst
;; ASSUME BST is relatively well balanced
(check-expect (render-bst false) MTTREE)
(check-expect (render-bst BST1)
              (above (render-key-value 1 "abc") 
                     (make-lines (image-width (render-bst false))
                                 (image-width (render-bst false)))
                     (beside (render-bst false)
                             (render-bst false))))

;(define (render-bst t) MTTREE)
(define (render-bst t)
  (cond [(false? t) MTTREE]
        [else
         (above
          (render-key-value (node-key t) (node-val t))
          (make-lines (image-width (render-bst (node-l t)))
                      (image-width (render-bst (node-r t))))
          (beside (render-bst (node-l t))
                  (render-bst (node-r t))))]))


;; Number String -> Image
;; renders the key and value of node
(check-expect (render-key-value 1 "abc")
              (text (string-append(number->string 1) KEY-VAL-SEPARATOR "abc") TEXT-SIZE TEXT-COLOR))

;(define (render-key-value key value) MTTREE)
(define (render-key-value key value)
  (text (string-append(number->string key) KEY-VAL-SEPARATOR value) TEXT-SIZE TEXT-COLOR))


;; Natural Natural -> Image
;; produce lines to l/r subtrees based on width of those subtrees
(check-expect (make-lines 60 130)
              (add-line (add-line (rectangle (+ 60 130) (/ 190 4) "solid" "white")
                                  (/ (+ 60 130) 2) 0
                                  (/ 60 2)         (/ 190 4)
                                  "black")
                        (/ (+ 60 130) 2) 0
                        (+ 60 (/ 130 2)) (/ 190 4)
                        "black"))


;(define (make-lines lw rw) MTTREE)

(define (make-lines lw rw)
  (add-line (add-line (rectangle (+ lw rw) (/ (+ lw rw) 4) "solid" "white")
                      (/ (+ lw rw) 2) 0
                      (/ lw 2) (/ (+ lw rw) 4)
                      TEXT-COLOR)
            (/ (+ lw rw) 2) 0
            (+ lw (/ rw 2)) (/ (+ lw rw) 4)
            TEXT-COLOR))            




