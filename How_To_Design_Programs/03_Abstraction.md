# Abstraction

Data definitions and functions often repeat with small variations (e.g., List-of-Numbers vs. List-of-Strings).
This **repetition** is a sign that **abstraction** is needed.

Copying code leads to **duplicated mistakes** and an increased **risk** when making changes.

**Abstraction** means pulling out the common pattern and writing it once in a **generalized way**.

## 14 Similarities Everywhere

### 14.1 Similarities in Functions

**Functional abstraction** is combining similar functions by turning differences into **parameters**.

Identify repeated patterns and replace the differing parts with parameters.

```scheme
;; duplicated code
(define (contains-dog? l) ...)
(define (contains-cats? l) ...)

;; abstracted function
(define (contains? s l)
    (cond
    [(empty? l) #false]
    [else (or (string=? (first l) s)
              (contains? s (rest l)))]))
```

### 14.2 Different Similarities

A **higher-order function** is a function that **consumes other functions** as arguments.

```scheme
(define (extract R l t)
  (cond
    [(empty? l) '()]
    [else (cond
            [(R (first l) t)
             (cons (first l)
                   (extract R (rest l) t))]
            [else
             (extract R (rest l) t)])]))
```

### 14.3 Similarities in Data Definitions

A **parametric data definition** lets you write **one template** with a placeholder for the element type.

```scheme
; A [List-of ITEM] is one of:
; – '()
; – (cons ITEM [List-of ITEM])
```

`ITEM` is a **parameter** : a placeholder for whatever kind of data the list holds. You **instantiate** the definition by supplying a real type (lke `Number` or `String`) for `ITEM`.

```scheme
; [List-of Number] = list of numbers
; [List-of String] = list of strings
; [List-of IR] = list of inventory records
```

Like a function abstracts over _values_, **parametric data definitions** abstract away the type of _contents_.
