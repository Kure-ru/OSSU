;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Mutual-Ref-P1-image-organizer) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; image-organizer-starter.rkt

; 
; PROBLEM:
; 
; Complete the design of a hierarchical image organizer.  The information and data
; for this problem are similar to the file system example in the fs-starter.rkt file. 
; But there are some key differences:
;   - this data is designed to keep a hierchical collection of images
;   - in this data a directory keeps its sub-directories in a separate list from
;     the images it contains
;   - as a consequence data and images are two clearly separate types
;   
; Start by carefully reviewing the partial data definitions below.  
; 



;; =================
;; Data definitions:

(define-struct dir (name sub-dirs images))
;; Dir is (make-dir String ListOfDir ListOfImage)
;; interp. An directory in the organizer, with a name, a list
;;         of sub-dirs and a list of images.

;; ListOfDir is one of:
;;  - empty
;;  - (cons Dir ListOfDir)
;; interp. A list of directories, this represents the sub-directories of
;;         a directory.

;; ListOfImage is one of:
;;  - empty
;;  - (cons Image ListOfImage)
;; interp. a list of images, this represents the sub-images of a directory.
;; NOTE: Image is a primitive type, but ListOfImage is not.


; 
; PART A:
; 
; Annotate the type comments with reference arrows and label each one to say 
; whether it is a reference, self-reference or mutual-reference.
; 
; PART B:
; 
; Write out the templates for Dir, ListOfDir and ListOfImage. Identify for each 
; call to a template function which arrow from part A it corresponds to.
; 


#;
(define (fn-for-dir d)
  (... (dir-name d)
       (fn-for-lod (dir-sub-dirs d))
       (fn-for-loi (dir-images d))))
#;
(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-dir (first lod))
              (fn-for-lod (rest lod)))]))
#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))

;; =================
;; Constants:

(define I1 (square 10 "solid" "red"))
(define I2 (square 10 "solid" "green"))
(define I3 (rectangle 13 14 "solid" "blue"))
(define D4 (make-dir "D4" empty (list I1 I2)))
(define D5 (make-dir "D5" empty (list I3)))
(define D6 (make-dir "D6" (list D4 D5) empty))

;; =================
;; Functions:
  
; 
; PROBLEM B:
; 
; Design a function to calculate the total size (width* height) of all the images 
; in a directory and its sub-directories.
; 


;; Dir -> Integer
;; ListOfDir -> Integer
;; ListOfImage -> Integer
;; produce the sum all all images size (width* height) in a given directory and its subs directory
(check-expect (sum-images--loi (list I1)) (image-area I1))
(check-expect (sum-images--loi (list I1 I2)) (+ (image-area I1) (image-area I2)))
(check-expect (sum-images--lod empty) 0)
(check-expect (sum-images--dir D6) (+ (image-area I1) (image-area I2) (image-area I3)))

;(define (sum-images--dir d) 0)
;(define (sum-images--lod lod) 0)
;(define (sum-images--loi loi) 0)

(define (sum-images--dir d)
  (if (empty? (dir-sub-dirs d))
      (sum-images--loi (dir-images d))
      (sum-images--lod (dir-sub-dirs d))))

(define (sum-images--lod lod)
  (cond [(empty? lod) 0]
        [else
         (+ (sum-images--dir (first lod))
            (sum-images--lod (rest lod)))]))

(define (sum-images--loi loi)
  (cond [(empty? loi) 0]
        [else
         (+ (image-area (first loi))
            (sum-images--loi (rest loi)))]))

;; Image -> Natural
;; produce the area of a given image
(check-expect (image-area I1) (* 10 10))

;(define (image-area img) 0)

(define (image-area img)
  (* (image-width img) (image-height img)))

; 
; PROBLEM C:
; 
; Design a function to produce rendering of a directory with its images. Keep it 
; simple and be sure to spend the first 10 minutes of your work with paper and 
; pencil!
; 


;; Dir -> Image
;; ListOfDir -> Image
;; ListOfImage -> Image
;; produce an image of a given directory an its images
(define MT (square 0 "solid" "white"))
(define TEXT-SIZE 14)
(define TEXT-COLOR "black")

(check-expect (render--loi empty) MT)
(check-expect (render--lod empty) MT)
(check-expect (render--loi (list I1 I2)) (beside I1 I2 MT))
(check-expect (render--dir D4)
              (above (text "D4" TEXT-SIZE TEXT-COLOR)
                      (render--loi (list I1 I2)))) 
(check-expect (render--dir D6)
              (above (text "D6" TEXT-SIZE TEXT-COLOR)
                      (beside (render--dir D4)
                             (render--dir D5)
                             MT)))

;(define (render--dir   d) MT)
;(define (render--lod lod) MT)
;(define (render--loi loi) MT)

(define (render--dir d)
  (above (text (dir-name d) TEXT-SIZE TEXT-COLOR)
          (render--lod (dir-sub-dirs d))
          (render--loi (dir-images d))))

(define (render--lod lod)
  (cond [(empty? lod) MT]
        [else
         (beside (render--dir (first lod))
                (render--lod (rest lod)))]))

(define (render--loi loi)
  (cond [(empty? loi) MT]
        [else
         (beside (first loi)
              (render--loi (rest loi)))]))