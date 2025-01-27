;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 161-180) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)

;  Exercise 161
; Translate the examples into tests and make sure they all succeed. Then change the function in figure 64 so that everyone gets $14 per hour.
; Now revise the entire program so that changing the wage for everyone is a single change to the entire program and not several. 


(define RATE 14)
(define MAX_TIME 100)

;Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* RATE h))

; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (* 28 RATE) '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons (* 4 RATE) (cons(* 2 RATE) '())))
(check-error (wage* (cons 45 (cons 4 (cons 110 '())))))

(define (wage* whrs)
  (cond [(empty? whrs) '()]
        [else (cons (wage (valid-hours? (first whrs)))
                    (wage* (rest whrs)))]))

;  Exercise 162
; No employee could possibly work more than 100 hours per week. To protect the company against fraud, the function should check that no item of the
; input list of wage* exceeds 100. If one of them does, the function should immediately signal an error. How do we have to change the function in
; figure 64 if we want to perform this basic reality check? 


; Number -> Number | Error
; produce an error if the working hour exceeds MAX_TIME
(check-expect (valid-hours? 35) 35)
(check-error (valid-hours? 105))

(define (valid-hours? h)
  (if (> h MAX_TIME)
      (error "valid-hours?: the working hours should not exceed 100")
      h))

;  Exercise 163
; Design convertFC. The function converts a list of measurements in Fahrenheit to a list of Celsius measurements. 


; List-of-Number -> List-of-Number
(check-expect (convertFC '()) '())
(check-expect (convertFC (list 32)) (list 0))
(check-expect (convertFC (list 32 212 98.6)) (list 0 100 37))
(check-expect (convertFC (list -40 -22 14)) (list -40 -30 -10))

(define (convertFC lof)
  (cond [(empty? lof) '()]
        [else
         (cons (convert (first lof)) (convertFC (rest lof)))]))

(define (convert t)
  (/ (- t 32) 1.8))

;  Exercise 164
; Design the function convert-euro, which converts a list of US$ amounts into a list of € amounts. Look up the current exchange rate on the web.


; List-of-amount -> List-of-amount
; converts a list of US$ amounts into a list of € amounts
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (list 100)) (list 98))
(check-expect (convert-euro (list 50 75 200)) (list 49 73.5 196))
(check-expect (convert-euro (list 1 0.5 0)) (list 0.98 .49 0))

(define (convert-euro loa)
  (cond [(empty? loa) '()]
        [else
         (cons (dollar->euro (first loa)) (convert-euro (rest loa)))]))

(define (dollar->euro d)
  (* d 0.98))

; List-of-amount Number -> List-of-amount
; converts a list of US$ amounts into a list of € amounts with r conversion rate
(check-expect (convert-euro* 0.85 '()) '()) 
(check-expect (convert-euro* 0.75 (list 100)) (list 75)) 
(check-expect (convert-euro* 1.1 (list 50 75 200)) (list 55 82.5 220))
(check-expect (convert-euro* 0.92 (list 20 40 60)) (list 18.4 36.8 55.2))  
(check-expect (convert-euro* 0.5 (list 10 25 50)) (list 5 12.5 25)) 

(define (convert-euro* r loa)
  (cond [(empty? loa) '()]
        [else
         (cons (* r (first loa)) (convert-euro* r (rest loa)))]))

;  Exercise 165
; Design the function subst-robot, which consumes a list of toy descriptions (one-word strings) and replaces all occurrences of "robot" with "r2d2"
; all other descriptions remain the same.
; Generalize subst-robot to substitute. The latter consumes two strings, called new and old, and a list of strings.
; It produces a new list of strings by substituting all occurrences of old with new. 


;; List of String -> List of String
;; consumes a list of toy descriptions (one-word strings) and replaces all occurrences of "robot" with "r2d2"
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (list "car" "doll" "train")) (list "car" "doll" "train"))
(check-expect (subst-robot (list "car" "robot" "train")) (list "car" "r2d2" "train"))
(check-expect (subst-robot (list "robot" "car" "robot" "doll" "robot")) (list "r2d2" "car" "r2d2" "doll" "r2d2"))

               
(define (subst-robot lot)
  (cond [(empty? lot) '()]
        [(string=? (first lot) "robot") (subst-robot (cons "r2d2" (rest lot)))]
        [else (cons (first lot) (subst-robot (rest lot)))]))

;; String String List of String -> List of String
;; produces a new list of strings by substituting all occurrences of old with new
(check-expect (substitute "cat" "dog" '()) '())
(check-expect (substitute "cat" "dog" (list "car" "bird" "train"))
              (list "car" "bird" "train"))
(check-expect (substitute "cat" "dog" (list "cat" "bird" "car"))
              (list "dog" "bird" "car"))

               
(define (substitute old new los)
  (cond [(empty? los) '()]
        [(string=? (first los) old) (substitute old new (cons new (rest los)))]
        [else (cons (first los) (substitute old new (rest los)))]))

;  Exercise 166
; Develop a data representation for paychecks.
; Assume that a paycheck contains two distinctive pieces of information: the employee’s name and an amount.
; Then design the function wage*.v3. It consumes a list of work records and computes a list of paychecks from it, one per record.
; In reality, a paycheck also contains an employee number. Develop a data representation for employee information and change the data definition for work records
; so that it uses employee information and not just a string for the employee’s name.
; Also change your data representation of paychecks so that it contains an employee’s name and number, too. Finally, design wage*.v4,
; a function that maps lists of revised work records to lists of revised paychecks.


;; Data definitions 
(define-struct work [employee employee-number rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number Number)
; interpretation (make-work n r h) combines the name & employee number
; with the pay rate r and the number of hours h

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

(define LOW1 '())
(define LOW2 (cons (make-work "Alice" 201 14.50 38) '()))
(define LOW3 (cons (make-work "Bob" 202 16.00 40)
                   (cons (make-work "Alice" 201 14.50 38) '())))
(define LOW4
  (cons (make-work "Charlie" 203 18.25 45)
        (cons (make-work "Diana" 204 19.50 42)
              (cons (make-work "Eve" 205 17.75 50) '()))))
(define LOW5
  (cons (make-work "Frank" 206 20.00 60)
        (cons (make-work "Grace" 207 15.75 35) '())))

(define-struct paycheck [employee-name employee-number amount])
; A Paycheck is a structure:
; (make-paycheck String Number Number)
; interp. a paycheck with the employee name
;         an employee number
;         and the amount of money they earned that week 

;; -----------------------------
;; Functions
; Low -> List-of-numbers
; computes the weekly wages for all weekly work records 

 
(define (wage*.v2 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v2 (first an-low))
                          (wage*.v2 (rest an-low)))]))
 
; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))

;; List-of-Work -> List-of-Paycheck
;; consumes a list of work records and computes a list of paychecks from it
(check-expect (wage*.v4 LOW1) '())
(check-expect (wage*.v4 LOW2)
              (cons (make-paycheck "Alice" 201 (* 14.50 38)) '()))
(check-expect (wage*.v4 LOW3)
              (cons (make-paycheck "Bob" 202 (* 16.00 40))
                    (cons (make-paycheck "Alice" 201 (* 14.50 38)) '())))
(check-expect (wage*.v4 LOW4)
              (cons (make-paycheck "Charlie" 203 (* 18.25 45))
                    (cons (make-paycheck "Diana" 204 (* 19.50 42))
                          (cons (make-paycheck "Eve" 205 (* 17.75 50)) '()))))
(check-expect (wage*.v4 LOW5)
              (cons (make-paycheck "Frank" 206 (* 20.00 60))
                    (cons (make-paycheck "Grace" 207 (* 15.75 35)) '())))

(define (wage*.v3 low)
  (cond [(empty? low) '()]
        [else (cons (make-paycheck (work-employee (first low))
                                   (wage.v2 (first low))) (wage*.v3 (rest low)))]))

(define (wage*.v4 low)
  (cond [(empty? low) '()]
        [else (cons (make-paycheck (work-employee (first low))
                                   (work-employee-number (first low))
                                   (wage.v2 (first low)))
                    (wage*.v4 (rest low)))]))

;  Exercise 167
; Design the function sum, which consumes a list of Posns and produces the sum of all of its x-coordinates.


;; List-of-posns -> Number
;; produces the sum of all x-coordinates in each posn in lop
(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 12.5 40)
                         (cons (make-posn 43 51.3) '())))
              (+ 12.5 43))


(define (sum lop)
  (cond [(empty? lop) 0]
        [else (+ (posn-x (first lop)) (sum (rest lop)))]))

;  Exercise 168
; Design the function translate. It consumes and produces lists of Posns. For each (make-posn x y) in the former,
; the latter contains (make-posn x (+ y 1)).


;; List-of-posns -> List-of-posns
;; produces a new list of posn with 1 added to each y-coordinate
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 42.4 20)
                               (cons (make-posn 72 34) '())))
              (cons (make-posn 42.4 21)
                    (cons (make-posn 72 35) '())))

(define (translate lop)
  (cond [(empty? lop) '()]
        [else (cons (make-posn (posn-x (first lop)) (+ (posn-y (first lop)) 1))
                    (translate (rest lop)))]))

;  Exercise 169
; Design the function legal. Like translate from exercise 168, the function consumes and produces a list of Posns. The result contains all those Posns
; whose x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200. 


;; List-of-posns -> List-of-posns
;; consumes and produces a list of Posns whose x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200.
(check-expect (legal (cons (make-posn 34 34) (cons (make-posn 43 43) '()))) (cons (make-posn 34 34) (cons (make-posn 43 43) '())))
(check-expect (legal (cons (make-posn 300 34) (cons (make-posn 23 300) '()))) '())
(check-expect (legal (cons (make-posn 45 -4) (cons (make-posn 300 34) (cons (make-posn 43 43) '())))) (cons (make-posn 43 43) '()))
(check-expect (legal (cons (make-posn 12 12) '())) (cons (make-posn 12 12) '()))

;(define (legal lop) empty)

(define (legal lop)
  (cond [(empty? lop) '()]
        [(legal? (first lop)) (cons (first lop) (legal (rest lop)))]
        [else (legal (rest lop))]))


;; posn -> Boolean
;; produce true if x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200.
(check-expect (legal? (make-posn 12 12)) true)
(check-expect (legal? (make-posn 105 12)) false)
(check-expect (legal? (make-posn 12 333)) false)

;(define (legal? p) false)

(define (legal? p)
  (and (<= (posn-x p) 100)
       (>= (posn-x p)   0)
       (<= (posn-y p) 200)
       (>= (posn-y p)   0)))

;  Exercise 170.
; Design the function replace. It consumes and produces a list of Phones. It replaces all occurrence of area code 713 with 281. 


(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999.

;; List-of-Phone -> List-of-Phone
;; produce a list of Phones with all occurrence of area code 713 replaced with 281
(check-expect (replace '()) '())
(check-expect (replace
               (cons (make-phone 321 871 7283) '()))
              (cons (make-phone 321 871 7283) '()))
(check-expect (replace
               (cons (make-phone 321 713 7283)
                     (cons (make-phone 713 874 7132) '())))
              (cons (make-phone 321 713 7283)
                    (cons (make-phone 281 874 7132) '())))

(define (replace lop)
  (cond [(empty? lop) '()]
        [else (cons (replace-area (first lop))
                    (replace (rest lop)))]))

(define (replace-area p)
  (if (= (phone-area p) 713)
      (make-phone 281 (phone-switch p) (phone-four p))
      p))
  
;  Exercise 171
; You know what the data definition for List-of-strings looks like. Spell it out. Make sure that you can represent Piet Hein’s poem as an instance of the
; definition where each line is represented as a string and another instance where each word is a string. Use read-lines and read-words to confirm your
; representation choices.


;; DATA DEFINITIONS

; An LLS is one of:
;   - '()
;   - (cons Los LLS)
; interp. a list of lines, each is a list of Strings

;; CONSTANTS


(define line0 (cons "TTT" '()))
(define line1 '())
(define line2 (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '()))))))
(define line3 (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '()))))))
(define line4 (cons "the" (cons "cryptic" (cons "admonishment" '()))))

(define poem (cons line0 (cons line1 (cons line2 (cons line3 (cons line4 '()))))))
 
(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))
(define lls2 (cons line0 (cons line1 (cons line2 '()))))
(define lls3 (cons line0 (cons line1 (cons line2 (cons line3 '())))))


;; FUNCTIONS

; LLS -> List-of-numbers
; determines the number of words on each line 
(check-expect (words-on-line lls0) '())
(check-expect (words-on-line lls1)
              (cons 1 (cons 0 '())))

(define (words-on-line lls)
  (cond
    [(empty? lls) '()]
    [else
     (cons (length (first lls)) ; a list of strings 
           (words-on-line (rest lls)))]))

; String -> List-of-numbers
; counts the words on each line in the given file
(define (file-statistic file-name)
  (words-on-line
   (read-words/line file-name)))

;  Exercise 172
; 
; Design the function collapse, which converts a list of lines into a string. The strings should be separated by blank spaces (" ").
; The lines should be separated with a newline ("\n").


;; LLS -> String
;; convert a LLS into a string, separates each string with blank spaces and each line with "\n"
(check-expect (collapse lls0) "")
(check-expect (collapse lls1) "TTT\n")
(check-expect (collapse poem) "TTT\n\nPut up in a place\nwhere it's easy to see\nthe cryptic admonishment")


(define (collapse lls)
  (cond [(empty? lls) ""]
        [else (string-append (collapse-line (first lls))
                             (if (empty? (rest lls)) "" "\n")
                             (collapse (rest lls)))]))
;; LoS -> String
; convert a LoS into a string, separates each string with blank spaces
(check-expect (collapse-line line0) "TTT")
(check-expect (collapse-line line1) "")
(check-expect (collapse-line line2) "Put up in a place")


(define (collapse-line l)
  (cond [(empty? l) ""]
        [else (string-append (first l)
                             (if (empty? (rest l)) "" " ")
                             (collapse-line (rest l)))]))

;  Exercise 173
; 
; Design a program that removes all articles from a text file. The program consumes the name n of a file, reads the file, removes the articles, and writes
; the result out to a file whose name is the result of concatenating "no-articles-" with n. For this exercise, an article is one of the following three
; words: "a", "an", and "the".


; LLS -> String
; removes all articles from a given LLS and concatene it into one string
(check-expect (remove-articles poem)  "TTT\n\nPut up in place\nwhere it's easy to see\ncryptic admonishment")

(define (remove-articles lls)
  (cond [(empty? lls) ""]
        [else (string-append (remove-articles-line (first lls))
                             (if (empty? (rest lls)) "" "\n")
                             (remove-articles (rest lls)))]))

(check-expect (remove-articles-line (cons "a" '())) "")
(check-expect (remove-articles-line (cons "bread" '())) "bread")
(check-expect (remove-articles-line (cons "the" (cons "bread"  (cons "an" '()))))  "bread ")

(define (remove-articles-line l)
  (cond [(empty? l) ""]
        [(or (string=? "a" (first l))
             (string=? "an" (first l))
             (string=? "the" (first l)))
         (remove-articles-line (rest l))]
        [else (string-append (first l)
                             (if (empty? (rest l)) "" " ")
                             (remove-articles-line (rest l)))]))

; Exercise 174
; 
; Design a program that encodes text files numerically. Each letter in a word should be encoded as a numeric three-letter string with a value between 0 and 256.
; Figure 69 shows our encoding function for single letters. Before you start, explain these functions.


; 1String -> String
; converts the given 1String to a 3-letter numeric String
 
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))
 
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))
 
; 1String -> String
; converts the given 1String into a String
 
(check-expect (code1 "z") "122")
 
(define (code1 c)
  (number->string (string->int c)))

; Exercise 175
; 
; Design a BSL program that simulates the Unix command wc. The purpose of the command is to count the number of 1Strings, words, and lines in a given file.
; \That is, the command consumes the name of a file and produces a value that consists of three numbers. 


(define-struct wc (lines words characters))
;; A WC (word count) is a structure:
;;   (make-wc Number Number Number)
;; interp. a file's word count

(define (f->wc f)
(count* (read-words/line f)))

;; String -> WC
;; produces a word count for the number of lines, letters and words in file f
(check-expect (count* lls0) (make-wc 0 0 0))
(check-expect (count* lls1) (make-wc 3 1 2))
(check-expect (count* lls2) (make-wc 16 6 3))
(check-expect (count* lls3) (make-wc 34 11 4))

(define (count* lls)
  (make-wc (count-letters lls)
            (count-words   lls)
            (count-lines   lls)))

;; LLS -> N
;; produces the number of lines in lls
(check-expect (count-lines lls0) 0)
(check-expect (count-lines lls1) 2)
(check-expect (count-lines lls2) 3)
(check-expect (count-lines lls3) 4)

(define (count-lines lls)
  (cond [(empty? lls) 0]
        [else (+ 1 (count-lines (rest lls)))]))

;; LLS -> N
;; produces the number of words in lls
(check-expect (count-words lls0) 0)
(check-expect (count-words lls1) 1)
(check-expect (count-words lls2) 6)
(check-expect (count-words lls3) 11)

(define (count-words lls)
  (cond [(empty? lls) 0]
        [else (+ (length (first lls))
                 (count-words (rest lls)))]))

;; LLS -> N
;; produces the number of letters in lls
(check-expect (count-letters lls0) 0)
(check-expect (count-letters lls1) 3)
(check-expect (count-letters lls2) 16)
(check-expect (count-letters lls3) 34)

(define (count-letters lls)
  (cond [(empty? lls) 0]
        [else (+ (count-letters-line (first lls))
                 (count-letters (rest lls)))]))

(define (count-letters-line l)
  (cond [(empty? l) 0]
        [else (+ (string-length (first l))
                 (count-letters-line (rest l)))]))

; Exercise 176
; Mathematics teachers may have introduced you to matrix calculations by now.
; In principle, matrix just means rectangle of numbers. Here is one possible data
; representation for matrices:


; A Matrix is one of: 
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length
 
; A Row is one of: 
;  – '() 
;  – (cons Number Row)

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

;  Exercise 177
; 
; Design the function create-editor. The function consumes two strings and produces an Editor. The first string is the text to the left of the cursor and
; the second string is the text to the right of the cursor. The rest of the section relies on this function. 


(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

(define good
  (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all
  (cons "a" (cons "l" (cons "l" '()))))
(define lla
  (cons "l" (cons "l" (cons "a" '()))))
 
; data example 1: 
(make-editor all good)
 
; data example 2:
(make-editor lla good)

; Lo1s -> Lo1s 
; produces a reverse version of the given list 
 
(check-expect
  (rev (cons "a" (cons "b" (cons "c" '()))))
  (cons "c" (cons "b" (cons "a" '()))))
 
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))

; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
 
(check-expect
  (add-at-end (cons "c" (cons "b" '())) "a")
  (cons "c" (cons "b" (cons "a" '()))))
 
(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else
     (cons (first l) (add-at-end (rest l) s))]))

;; String String -> Editor
;; produce an editor
(check-expect
 (create-editor "" "") (make-editor '() '()))
(check-expect
 (create-editor "good" "day")
 (make-editor (explode "good") (explode "day")))

(define (create-editor pre post)
  (make-editor (explode pre) (explode post)))

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))

; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor 
(define (editor-render e)
  (place-image/align
    (beside (editor-text (editor-pre e))
            CURSOR
            (editor-text (editor-post e)))
    1 1
    "left" "top"
    MT))

; Lo1s -> Image
; renders a list of 1Strings as a text image
(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))

(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))


 
; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "e")
  (create-editor "cde" "fgh"))

(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

; insert the 1String k between pre and post
(check-expect
  (editor-ins (make-editor '() '()) "e")
  (make-editor (cons "e" '()) '()))
 
(check-expect
  (editor-ins
    (make-editor (cons "d" '())
                 (cons "f" (cons "g" '())))
    "e")
  (make-editor (cons "d" (cons "e" '()))
               (cons "f" (cons "g" '()))))

;(define (editor-ins ed k)
;  (make-editor (cons k (editor-pre ed))
;               (editor-post ed)))

(define (editor-ins ed k)
  (make-editor (add-at-end (editor-pre ed) k) ; Add `k` at the end of `pre`
               (editor-post ed)))



; Exercise 179 Design the functions


; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible 
(check-expect
 (editor-lft (make-editor '() '()))
 (make-editor '() '()))
(check-expect
 (editor-lft
  (make-editor
   (cons "a" (cons "b" (cons "c" '())))
   (cons "d" (cons "e" (cons "f" '())))))
 (make-editor
  (cons "a" (cons "b" '()))
  (cons "c" (cons "d" (cons "e" (cons "f" '()))))))

; Helper function to get the last element of a list
(define (last lst)
  (if (empty? (rest lst))
      (first lst) ; The single element is the last one
      (last (rest lst)))) ; Recurse on the rest of the list

(define (editor-lft ed)
  (if (not (empty? (editor-pre ed)))
      (make-editor
       (reverse (rest (reverse (editor-pre ed)))) ; Remove the last element from `pre`
       (cons (last (editor-pre ed)) (editor-post ed))) ; Add the last element of `pre` to the front of `post`
      ed))


 
; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible 
(check-expect
 (editor-rgt (make-editor '() '()))
 (make-editor '() '()))
(check-expect
 (editor-rgt
  (make-editor
   (cons "a" (cons "b" (cons "c" '())))
   (cons "d" (cons "e" (cons "f" '())))))
 (make-editor
  (cons "a" (cons "b" (cons "c" (cons "d" '()))))
  (cons "e" (cons "f" '()))))

(define (editor-rgt ed)
  (if (not (empty? (editor-post ed)))
      (make-editor
       (add-at-end (editor-pre ed) (first (editor-post ed)))
       (rest (editor-post ed)))
      ed))


; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible 
(check-expect
 (editor-del (make-editor '() '()))
 (make-editor '() '()))
(check-expect
 (editor-del
  (make-editor
   (cons "a" (cons "b" (cons "c" '())))
   (cons "d" (cons "e" (cons "f" '())))))
 (make-editor
  (cons "a" (cons "b" '()))
  (cons "d" (cons "e" (cons "f" '())))))

(define (editor-del ed)
  (if (not (empty? (editor-pre ed)))
      (make-editor
       (reverse (rest (reverse (editor-pre ed)))) 
       (editor-post ed))
      ed)) 

;  Exercise 180. Design editor-text without using implode. 
