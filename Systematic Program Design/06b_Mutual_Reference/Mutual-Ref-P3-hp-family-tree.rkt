;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Mutual-Ref-P3-hp-family-tree) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

;; hp-family-tree-starter.rkt

; In this problem set you will represent information about descendant family 
; trees from Harry Potter and design functions that operate on those trees.
; 
; To make your task much easier we suggest two things:
;   - you only need a DESCENDANT family tree
;   - read through this entire problem set carefully to see what information 
;     the functions below are going to need. Design your data definitions to
;     only represent that information.
;   - you can find all the information you need by looking at the individual 
;     character pages like the one we point you to for Arthur Weasley.
; 


; PROBLEM 1:
; 
; Design a data definition that represents a family tree from the Harry Potter 
; wiki, which contains all necessary information for the other problems.  You 
; will use this data definition throughout the rest of the homework.
; 


(define-struct wizard (name wand patronus kids))
;; Wizard is (make-wizard String String String ListOfWizard)
;; interp. A Wizards with first name, their children, their patronus and their wand material

#;
(define (fn-for-wizard w)
  (... (wizard-name w)
       (wizard-wand w)
       (wizard-patronus w)
       (fn-for-low (wizard-kids w))))

;;ListOfWizard is one of:
;; - empty
;; - (cons Wizard ListOfWizard)
;; interp. a list of Wizards

#;
(define (fn-for-low low)
  (cond [(empty? low) (...)]
        [else
         (... (fn-for-wizard (first low))
              (fn-for-low (rest low)))]))

; PROBLEM 2: 
; 
; Define a constant named ARTHUR that represents the descendant family tree for 
; Arthur Weasley. You can find all the infomation you need by starting 
; at: http://harrypotter.wikia.com/wiki/Arthur_Weasley.
; 
; You must include all of Arthur's children and these grandchildren: Lily, 
; Victoire, Albus, James.
; 
; 
; Note that on the Potter wiki you will find a lot of information. But for some 
; people some of the information may be missing. Enter that information with a 
; special value of "" (the empty string) meaning it is not present. Don't forget
; this special value when writing your interp.
; 


(define HARRY (make-wizard "Harry" "Holly" "Stag" empty))
(define ARTHUR
  (make-wizard "Arthur" "" "Weasel"
               (list (make-wizard "Bill" "" "" (list (make-wizard "Victoire"  "" "" empty)      
                                                     (make-wizard "Dominique" "" "" empty)   
                                                     (make-wizard "Louis"     "" "" empty)))   
                     (make-wizard "Charlie" "ash" "" empty)
                     (make-wizard "Percy" "" "" (list (make-wizard "Molly" "" "" empty)          
                                                      (make-wizard "Lucy"  "" "" empty)))
                     (make-wizard "Fred"    ""    "" empty)
                     (make-wizard "George"  ""    "" (list (make-wizard "Fred" "" "" empty)     
                                                           (make-wizard "Roxanne"  "" "" empty)))
                     (make-wizard "Ron"     "ash" "Jack Russell Terrier" (list (make-wizard "Rose" "" "" empty)  
                                                                               (make-wizard "Hugo" "" "" empty)))
                     (make-wizard "Ginny"   ""    "horse" 
                                  (list (make-wizard "James" "" "" empty)
                                        (make-wizard "Albus" "" "" empty)
                                        (make-wizard "Lily"  "" "" empty))))))

; PROBLEM 3:
; 
; Design a function that produces a pair list (i.e. list of two-element lists)
; of every person in the tree and his or her patronus. For example, assuming 
; that HARRY is a tree representing Harry Potter and that he has no children
; (even though we know he does) the result would be: (list (list "Harry" "Stag")).
; 
; You must use ARTHUR as one of your examples.
; 


;;ListOfPair is one of:
;; - empty
;; (cons (list String String) ListOfPair)
;; interp. represents a list of person and their patronus

#;
(define (fn-for-lop lop)
  (cond [(empty? lop) (...)]
        [else
         (... (first lop)
              (first (rest (first lop)))
              (fn-for-lop (rest lop)))]))

;; Wizard -> ListOfPair
;; ListOfWizard -> ListOfPair
;; produce a pair list of every person in the tree and their patronus.
(check-expect (patronus-low empty) empty)
(check-expect (patronus-wizard HARRY) (list (list "Harry" "Stag")))
(check-expect (patronus-wizard ARTHUR)  (list
                                         (list "Arthur" "Weasel")
                                         (list "Bill" "")
                                         (list "Victoire" "")
                                         (list "Dominique" "")
                                         (list "Louis" "")
                                         (list "Charlie" "")
                                         (list "Percy" "")
                                         (list "Molly" "")
                                         (list "Lucy" "")
                                         (list "Fred" "")
                                         (list "George" "")
                                         (list "Fred" "")
                                         (list "Roxanne" "")
                                         (list "Ron" "Jack Russell Terrier")
                                         (list "Rose" "")
                                         (list "Hugo" "")
                                         (list "Ginny" "horse")
                                         (list "James" "")
                                         (list "Albus" "")
                                         (list "Lily" "")))


;(define (patronus-wizard w) empty)
;(define (patronus-low w) empty)

(define (patronus-wizard w)
  (cons (list (wizard-name w) (wizard-patronus w))
        (patronus-low (wizard-kids w))))

(define (patronus-low low)
  (cond [(empty? low) empty]
        [else
         (append (patronus-wizard (first low))
                 (patronus-low (rest low)))]))

; PROBLEM 4:
; 
; Design a function that produces the names of every person in a given tree 
; whose wands are made of a given material. 
; 
; You must use ARTHUR as one of your examples.
; 


;; Wizard String -> ListOfNames
;; produce the names of every person whose wand are made of a given material
(check-expect (wand-material--low empty  "Holly") empty)
(check-expect (wand-material--wizard HARRY "Holly") (list "Harry"))
(check-expect (wand-material--wizard (make-wizard "a" "b" "c" empty) "x") empty)
(check-expect (wand-material--wizard (make-wizard "a" "b" "c" empty) "b") (list "a"))                                           
(check-expect (wand-material--wizard ARTHUR "ash") (list "Charlie" "Ron"))

;(define (wand-material--wizard low wand) empty)
;(define (wand-material--low low wand) empty)

(define (wand-material--wizard w wand)
  (if (string=? wand  (wizard-wand w))
      (cons (wizard-name w)  (wand-material--low (wizard-kids w) wand))
      (wand-material--low (wizard-kids w) wand)))

(define (wand-material--low low wand)
  (cond [(empty? low) empty]
        [else (append (wand-material--wizard (first low) wand)
             (wand-material--low (rest low) wand))]))