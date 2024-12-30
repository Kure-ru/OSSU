# Intermezzo 1: Beginning Student Language

## BSL Vocabulary

- A **name** is a sequence of characters not including a space of the following `` , ' ` ( ) [ ] { } | ; #``

  - a _primitive_ is a name to which BSL assigns meaning (e.g. `+` or `sqrt`)
  - a _variable_ is a name without preassigned meaning

- A **value** is one of:
  - a _number_, can include integers, fractions, decimals, complex numbers, and numbers in other bases
  - a _boolean_, `#true` or `#false`
  - a _string_, a sequence of characters enclosed in double quotes (e.g. `"hello world"`)
  - an _image_ is a png, jpg, tiff... without a precise definition

## BSL Grammar

A BSL program consists of definitions (`def`) and expressions (`expr`) which can be written in sequence.

**Definitions** start with the keyword `define`, followed by a function name, parameters, and a body (= an expression).

```scheme
(define name expression)
```

**Expressions** have different types:

- **Atomic expressions**, like numbers, strings or Booleans
- **Compound expressions**:
  - **primitive applications**: you can use primitives like `+` or `sqrt` with arguments
  - **function applications**: apply a function to arguments (e.g. `(f x)`)
  - **conditionals** which come in two forms:
    - `cond`
    - `if`

It is necessary to follow the shape of the expression.

```scheme
;; examples of illegal expressions

(f define) ;misuses define
(cond x)   ;improper cond format
((f 2) 10) ;neither conditional nor application
```

BSL allows flexibility with whitespace, but it must separate elements in a sequence.
Proper formatting and whitespace usage improve code readability.

> Keep in mind that two kinds of readers study your BSL programs: people and DrRacket.

## BSL Meaning

When DrRacket evaluates an expression, it uses the laws of arithmetic and algebra to obtain a **value**.

```scheme
(+ 1 1) == 2
(- 2 1) == 1

(not #true)        == #false
(string=? "a" "a") == #true
```

When a function is applied, its body is **evaluated** with **arguments** substituted for **parameters**.

```scheme
(define (poly x y)
  (+ (expt 2 x) y))
        ⬇️
(poly 3 5) == (+ (expt 2 3) 5) ... == (+ 8 5) == 13
```

When evaluating `cond` expressions, when a condition evaluates to `#false`, that line is removed.

```scheme
(cond                    == (cond
  [#false ...]               ; first line removed
  [condition2 answer2]       [condition2 answer2]
  ...)                       ...)
```

## Meaning and Computing

The **stepper** is a tool in DrRacket that simulates the evaluation process step by step. It helps understand how language constructs work by breaking down the evaluation process.
