# Arbitrarily Large Data

**Fixed-size data** (like booleans, numbers, strings, and structures) is limited in scope and cannot represent undetermined number of pieces of information.

## 8 Lists

To handle arbitrarily large data, we use **self-referential data definitions**.

### 8.1 Creating Lists

In BSL, an **empty list** is represented with `'()`
The `cons` operation is used to construct lists by adding elements to an existing lists.

```scheme
(cons "Mercury" '())
```

We can construct lists with two items by using `cons` again.

```scheme
(cons "Venus" (cons "Mercury" '()))
```

A list is **self-referential**: it uses **recursion** in its definition to allow the list to grow indefinitely.

```scheme
; A List-of-names is one of:
; – '()
; – (cons String List-of-names)
```

### 8.2 What Is '(), What Is cons

`'()` is a **constant** representing the empty list. It is an **atomic value**, distinct from other types like numbers, Booleans or strings.
The predicate `empty?` recognizes `'()`

```scheme
> (empty? '())
#true

> (empty? 5)
#false

> (empty? "hello world")
#false

> (empty? (cons 1 '()))
#false

> (empty? (make-posn 0 0))
#false
```

`cons` is a **checked constructor** for creating lists. It creates a two-field structure:

1. the first field holds any value
2. the second field holds another list (either `'()` or a `cons` structure)
   Since a `cons` structure has two fields, it has two selectors `first` and `rest`.

**List primitives**

| **Primitive** | **Description**                              |
| ------------- | -------------------------------------------- |
| `'()`         | A special value representing the empty list. |
| `empty?`      | Predicate to check if a value is `'()`.      |
| `cons`        | Checked constructor to create lists.         |
| `first`       | Selector to retrieve the last added item.    |
| `rest`        | Selector to retrieve the remaining list.     |
| `cons?`       | Predicate to check if a value is a `cons`.   |

### 8.3 Programming with Lists

Since the data definition for lists has two clauses, the function's body must be a `cond` expression with two clauses.
List are **self-referential** so we need to use **recursion**. A **recursive** function means that the function is calling itself.

A well formed self-reference has:

- at least one **base case**
- at least one **self-reference case**

```scheme
(define (fn-for-lox lox)
  (cond [(empty? lox) (...)]                   ;BASE CASE
        [else (... (first lox)
                   (fn-for-lox (rest lox)))])) ;NATURAL RECURSION
```

### 8.4 Computing with Lists

Recursive functions on lists follow the [rules of algebra](./01i_beginning_student_language.md), **substitution** and **simplification**.

Each recursive call processes a smaller part of the list (the `rest`).
The function eventually stops when the base case (`empty?`) is reached.

## 9 Designing with Self-Referential Data Definitions

[**Design recipe**](./00_preface.md)

1. Data definition

If a problem statement is about information of **arbitrary size**, you need a self-referential data definition to represent it.

2. Header

When you formulate the purpose statement, focus on **what** the function computes, not **how** it goes about it.

```scheme
; List-of-strings -> Number
; counts how many strings alos contains
(define (how-many alos)
  0)
```

3. Examples

Make sure they cover all cases.

| **Given**                   | **Wanted** |
| --------------------------- | ---------- |
| `'()`                       | 0          |
| `(cons "a" '())`            | 1          |
| `(cons "b" (cons "a" '()))` | 2          |

4. Function template

- one cond clause per data clause
- selectors where the condition identifies a structure
- one natural recursion per self-reference.

5. Function definition

The last step is a _leap of faith_ to assume the recursion works.

6. Tests

Turn the examples into `check-expect` tests and run them

### 9.1 Finger Exercises: Lists

### 9.2: Non-Empty Lists

### 9.3 Natural Numbers

- `(make-list i x) → list?` Constructs a list of i copies of x.

```scheme
> (make-list 2 "hello")
(cons "hello" (cons "hello" '()))

> (make-list 3 true)
(cons true (cons true (cons true '())))

> (make-list 0 17)
'()
```

- Natural numbers

```scheme
; An N is one of:
; – 0
; – (add1 N)
; interpretation represents the counting numbers
```

Natural numbers are **recursive**, much like lists.

Here are some functions used with natural numbers

|             |                                                                 |
| ----------- | --------------------------------------------------------------- |
| `add1`      | adds 1 to a number, acts like a constructor for natural numbers |
| `sub1`      | subtracts 1                                                     |
| `zero?`     | predicate to check if a number is 0                             |
| `positive?` | predicate to check if a number is > 0                           |

### 9.4 Russian Dolls

### 9.5 Lists and World

### 9.6 A Note on Lists and Sets

**Sets** are about the membership of elements, where order and number of occurrences are irrelevant.
**Lists** are finite collections, but their size can be arbitrarily large.

BSL doesn't have built-in support for sets.

## 10 More on Lists

### 10.1 Functions that Produce Lists

### 10.2 Structures in Lists

Lists can hold **structures** which are more suitable for representing data with multiple attributes.

```scheme
(define-struct work [employee rate hours])
; A (piece of) Work is a structure:
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name
; with the pay rate r and the number of hours h

; Low (short for list of works) is one of:
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the
; hours worked for a number of employees
```

### 10.3 Lists in Lists, Files

`read-file` reads an entire text file as a single string.

```scheme
; String -> String
; produces the content of file f as a string
(define (read-file f) ...)

; String -> List-of-string
; produces the content of file f as a list of strings,
; one per line
(define (read-lines f) ...)

; String -> List-of-string
; produces the content of file f as a list of strings,
; one per word
(define (read-words f) ...)

; String -> List-of-list-of-string
; produces the content of file f as a list of list of
; strings, one list per line and one string per word
(define (read-words/line f) ...)

; The above functions consume the name of a file as a String
; argument. If the specified file does not exist in the
; same folder as the program, they signal an error.
```

### 10.4 A Graphical Editor, Revisited

## 11 Design by Composition

Programs require collaboration between `multiple` functions.

### 11.1 The `list` function

`list` consumes an arbitrary number of values and creates a list.

```scheme
(list 1 2 3)
;; is the same as
(cons 1 (cons 2 (cons 3 '())))
```

### 11.2 Composing Functions

#### functions should do one task

- break programs into multiple functions
- each function should handle one specific task
- use **auxiliary** functions when tasks depend on other data or need to be broken down

#### When to create auxiliary functions?

- domain-specific knowledge needed
- complexe case analysis
- self-referential data
- generalizing the functions

#### use a wish list

- write down function headers for functions you still need to write

### 11.3 Auxiliary Functions that Recur

When writing recursive functions (like sorting a list), you’ll often need **auxiliary functions** to handle specific sub-tasks — especially when inserting or processing elements one by one.

```scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sorting lists of numbers ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))

; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))
```

### 11.4 Auxiliary Functions that Generalize

General-purpose helper functions make your code cleaner, more reusable, and easier to test.

## 12 Projects: Lists

### 12.1 Real-World Data: Dictionaries

Real-world data sets (like dictionaries) are huge—hundreds of thousands of entries.

You must **test your code on small examples** first before running it on large data.

Then you **analyze performance** and optimize if needed.

```scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reading a dictionnary ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; On OS X:
(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend

; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))
```

### 12.2 Real-World Data: iTunes
