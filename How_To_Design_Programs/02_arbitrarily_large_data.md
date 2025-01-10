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
