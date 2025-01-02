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

## BSL Errors

A **syntax error** occurs when a program violates the grammar rules of BSL.

A **run-time error** happens when a syntactically correct program attempts an invalid operation, e.g.

```scheme
> (/ 1 0)
/:division by zero
```

A **stuck state** occurs when evaluation rules cannot proceed further because of invalid operations.

Function can be written to intentionally raise errors for invalid inputs.

```scheme
(define (checked-area-of-disk v)
  (cond
    [(number? v) (area-of-disk v)]
    [else (error "number expected")]))
```

## Boolean expressions

`and` and `or` are **keywords**, not function applications. They require two expressions as arguments

```scheme
  expr	 	=	 	...
 	 	|	 	(and expr expr)
 	 	|	 	(or expr expr)
```

`and` evaluates left to right, and stops evaluation if the first expression is `#false`. `and` **short-circuits** evaluation.

```scheme
(define (check n r)
  (and (not (= n 0)) (= (/ 1 n) r)))
```

`or` stops evaluation if the first expression is `#true`.

## Constant Definitions

Constant definitions are shaped similarly to function definition but are differentiated by the second component of the definition.

```scheme
definition = ...
            | (define name expr)
```

A constant definition with a **literal constant** simply acts as a substitution.

```scheme
(define RADIUS 5)
```

If the right-hand side is an **expression**, it is evaluated immediately using preceding definitions.

```scheme
(define DIAMETER (* 2 RADIUS))  ;; == (define DIAMETER 10)
```

If the constant is called before being defined, you would get an error explaining that _"this function is not defined"_.

## Structure Type Definitions

The structure type definition creates a new structure type.

```scheme
  definition	 	=	 	...
 	 	|	 	(define-struct name [name ...])
```

Here is a simple example.

```scheme
(define-struct point [x y z])
```

The `define-struct` definition introduces several functions automatically.

- **constructor**: a function to create structure instances>

```scheme
(make-point 1 2 -1)
```

- **selector**: functions to access individual components of a structure

```scheme
(point-x (make-point V U W)) == V
(point-y (make-point V U W)) == U
(point-z (make-point V U W)) == W
```

- **predicate**: a dunction to check if a value is of a particular structure type

```scheme
(point? (make-point U V W)) == #true
(point? X)                  == #false
```

## BSL Tests

Testing expressions are used to validate the correctness of your code by comparing expected outcomes with actual results.

```scheme
; check-expect compares the outcome and the expected value with equal?
(check-expect 3 3)

; check-member-of compares the outcome and the expected values with equal?
; if one of them yields #true, the test succeeds
(check-member-of "green" "red" "yellow" "green")

; check-within compares the outcome and the expected value with a predicate
;  like equal? but allows for a tolerance of epsilon for each inexact number
(check-within (make-posn #i1.0 #i1.1) (make-posn #i0.9 #i1.2) 0.2)

; check-range is like check-within
; but allows for a specification of an interval
(check-range 0.9 #i0.6 #i1.0)

; check-error checks whether an expression signals (any) error
(check-error (/ 1 0))

; check-random evaluates the sequences of calls to random in the
; two expressions such that they yield the same number
(check-random (make-posn (random 3) (random 9))
              (make-posn (random 3) (random 9)))

; check-satisfied determines whether a predicate produces #true
; when applied to the outcome, that is, whether outcome has a certain property
(check-satisfied 4 even?)
```

## BSL Error Messages

Error messages consists of three parts:

- the code fragments that signal the error message;
- the error message; and
- an explanation with a suggestion on how to fix the mistake.
