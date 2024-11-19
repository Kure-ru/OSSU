;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Helpers-L1-arrange-images) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; arrange-images-starter.rkt (problem statement)

; 
; PROBLEM:
; 
; In this problem imagine you have a bunch of pictures that you would like to 
; store as data and present in different ways. We'll do a simple version of that 
; here, and set the stage for a more elaborate version later.
; 
; (A) Design a data definition to represent an arbitrary number of images.
; 
; (B) Design a function called arrange-images that consumes an arbitrary number
;     of images and lays them out left-to-right in increasing order of size.
;     


;; Constants

(define BLANK (square 0 "solid" "white"))

;;for testing
(define I1 (rectangle 10 20 "solid" "blue"))
(define I2 (rectangle 20 30 "solid" "red"))
(define I3 (rectangle 30 40 "solid" "green"))


;; ----------------
;; Data Definition

;; ListOfImages is one of:
;; - empty
;; - (cons Image ListOfImages)
;; interp. a list of images

(define LOI0 empty)
(define LOI1 (cons (rectangle 20 50 "solid" "pink") empty))
(define LOI2 (cons (circle 10 "solid" "red") (cons (rectangle 20 50 "solid" "pink") empty)))

#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else (... (first loi)
                   (fn-for-loi (rest loi)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Image ListOfImage)
;;  - self-reference: (rest loi) is ListOfImage

;; ----------------
;; Functions:

;; ListOfImage -> Image
;; sort images in increasing order of size and then lay them out left to right
(check-expect (arrange-images empty) BLANK)
(check-expect (arrange-images (cons I1 (cons I2 empty)))
              (beside I1
                      I2
                      BLANK))
(check-expect (arrange-images (cons I2 (cons I1 empty)))
              (beside I1
                      I2
                      BLANK))

;(define (arrange-images loi) BLANK) ;stub

(define (arrange-images loi)
  (layout-images (sort-images loi)))

;; ListOfImage -> Image
;; place images beside each other in order of list
(check-expect (layout-images empty) BLANK)
(check-expect (layout-images (cons I1 (cons I2 empty)))
              (beside I1
                      I2
                      BLANK))

;(define (layout-images loi) BLANK)   ;stub

(define (layout-images loi)
  (cond [(empty? loi) BLANK]
        [else (beside (first loi)
                      (layout-images (rest loi)))]))

;; ListOfImage -> ListOfImage
;; sort images in increasing order of size (area)
;; !!!
(check-expect (sort-images empty) empty)
(check-expect (sort-images (cons I1 (cons I2 empty)))
              (cons I1 (cons I2 empty)))
(check-expect (sort-images (cons I2 (cons I1 empty)))
              (cons I1 (cons I2 empty)))
(check-expect (sort-images (cons I3 (cons I1(cons I2 empty))))
              (cons I1 (cons I2 (cons I3 empty))))

;(define (sort-images loi) loi)   ;stub

(define (sort-images loi)
  (cond [(empty? loi) empty]
        [else (insert (first loi)
                      (sort-images (rest loi)))])) ;result of natural recursion will be sorted

;; Image ListOfImage -> ListOfImage
;; insert img in proper place in loi (in increasing order of size)
;; ASSUME: lst is already sorted
(check-expect (insert I1 empty) (cons I1 empty))
(check-expect (insert I1 (cons I2 (cons I3 empty))) (cons I1 (cons I2 (cons I3 empty))))
(check-expect (insert I2 (cons I1 (cons I3 empty))) (cons I1 (cons I2 (cons I3 empty))))
(check-expect (insert I3 (cons I1 (cons I2 empty))) (cons I1 (cons I2 (cons I3 empty))))

;(define (insert img loi) lst) ;stub

(define (insert img loi)
  (cond [(empty? loi) (cons img empty)]
        [else
         (if (larger? img (first loi))
             (cons (first loi)
                   (insert img
                           (rest loi)))
             (cons img loi))]))

;; Image Image -> Boolean
;; produce true if img1 is larger than img2 (by area)
(check-expect (larger? (rectangle 3 4 "solid" "red") (rectangle 2 6 "solid" "red")) false)
(check-expect (larger? (rectangle 5 4 "solid" "red") (rectangle 2 6 "solid" "red")) true)
(check-expect (larger? (rectangle 3 5 "solid" "red") (rectangle 2 6 "solid" "red")) true)
(check-expect (larger? (rectangle 3 4 "solid" "red") (rectangle 2 6 "solid" "red")) false)
(check-expect (larger? (rectangle 3 4 "solid" "red") (rectangle 2 7 "solid" "red")) false)
                                  
;(define (larger? img1 img2) true) ;stub

(define (larger? img1 img2)
  (> (* (image-width img1) (image-height img1))
     (* (image-width img2) (image-height img2))))