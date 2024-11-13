;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Compound-P10-simple-text-editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; simple-text-editor-starter.rkt

;  
;  In this problem, you will be designing a simple one-line text editor.
;  
;  The constants and data definitions are provided for you, so make sure 
;  to take a look through them after completing your own Domain Analysis. 
;  
;  Your text editor should have the following functionality:
;  - when you type, characters should be inserted on the left side of the cursor 
;  - when you press the left and right arrow keys, the cursor should move accordingly  
;  - when you press backspace (or delete on a mac), the last character on the left of 
;    the cursors should be deleted
;  



(require 2htdp/image)
(require 2htdp/universe)

;; A simple editor

;; Constants
;; =========

(define WIDTH 300)
(define HEIGHT 20)
(define MTS (empty-scene WIDTH HEIGHT))

(define CURSOR (rectangle 2 14 "solid" "red"))

(define TEXT-SIZE 14)
(define TEXT-COLOUR "black")

;; Data Definitions
;; ================

(define-struct editor (pre post))
;; Editor is (make-editor String String)
;; interp. pre is the text before the cursor, post is the text after
(define E0 (make-editor "" ""))
(define E1 (make-editor "a" ""))
(define E2 (make-editor "" "b"))

#;
(define (fn-for-editor e)
  (... (editor-pre e)
       (editor-post e)))


;; =================
;; Functions:

;; Editor -> Editor
;; start the world with (main (make-editor "" ""))
;; 
(define (main e)
  (big-bang e                    ; Editor
    (to-draw   render-editor)   ; Editor -> Image
    (on-key    handle-key)))    ; Editor KeyEvent -> Editor

;; Editor -> Image
;; render editor with proper input
(check-expect (render-editor E0) (place-image/align(beside
                                              (text "" TEXT-SIZE TEXT-COLOUR)
                                              CURSOR
                                              (text "" TEXT-SIZE TEXT-COLOUR))
                                             8 (/ HEIGHT 2)
                                             "left" "center"
                                             MTS))

(check-expect (render-editor E1) (place-image/align(beside
                                              (text "a" TEXT-SIZE TEXT-COLOUR)
                                              CURSOR
                                              (text "" TEXT-SIZE TEXT-COLOUR))
                                             8 (/ HEIGHT 2)
                                             "left" "center"
                                             MTS))

(check-expect (render-editor E2) (place-image/align(beside
                                              (text "" TEXT-SIZE TEXT-COLOUR)
                                              CURSOR
                                              (text "b" TEXT-SIZE TEXT-COLOUR))
                                             8 (/ HEIGHT 2)
                                             "left" "center"
                                             MTS))

;(define (render-editor e) MTS) ;stub
;template from editor
(define (render-editor e)
  (place-image/align(beside (text (editor-pre e) TEXT-SIZE TEXT-COLOUR)
                      CURSOR
                      (text (editor-post e) TEXT-SIZE TEXT-COLOUR))
              8 (/ HEIGHT 2)
             "left" "center"
              MTS))


;; Editor KeyEvent -> Editor
;; Input or delete text, navigate cursor left/right
(check-expect (handle-key E1 "\b") E0)
(check-expect (handle-key E1 "left") (make-editor "" "a"))
(check-expect (handle-key E2 "right") (make-editor "b" ""))
(check-expect (handle-key E1 "b") (make-editor "ab" ""))


(define (handle-key e ke)
  (cond [(key=? ke "\b")
         (if (positive? (string-length (editor-pre e)))
         (make-editor (substring (editor-pre e) 0 (- (string-length (editor-pre e)) 1))
                      (editor-post e))
         e)]   ;delete char
        [(key=? ke "left")
         (if (positive? (string-length (editor-pre e)))
         (make-editor (substring (editor-pre e) 0 (- (string-length (editor-pre e)) 1))
                      (string-append (substring (editor-pre e) (- (string-length (editor-pre e)) 1))
                                     (editor-post e)))
         e)]   ;cursor left
        [(key=? ke "right")
         (if (positive? (string-length (editor-post e)))
             (make-editor (string-append (editor-pre e) (substring (editor-post e) 0 1))
                          (substring (editor-post e) 1))
             e)]   ;cursor right
        [else 
        (make-editor (string-append (editor-pre e) ke) (editor-post e))])) ;input char