# Fixed-Size Data

## 1 Arithmetic

### 1.1 The Arithmetic of Numbers

**Arithmetic operations** include:

- basic operations `+` , `-` , `*` , `/`
- advanced operations `gcd`, `log`, `abs`, `sqr`, ...

**Different types of numbers**: Natural numbers, Integers, Rational numbers, Real numbers...

**Special Constants**:

- `pi` (≈ 3.14159)
- `e` (Euler's constant, ≈ 2.718)

**Precision**:

- Exact Numbers (e.g. `(/ 4 6)` results in `2/3`)
- Inexact Numbers - approximated when precision is not possible (e.g. `sqrt 2` ≈ 1.4142135623730951).
  The prefix `#i` indicates inexactness.

```scheme
> (cos pi)
#i-1.0
```

### 1.2 The Arithmetic of Strings

Strings allow programs to deal with symbolic information (name, colors, text) in an intuitive way. It avoids the need to encode such information as numbers. (e.g. `1 = "hello"`)

A **String** is a sequence of characters enclosed in **double quotes**

```scheme
"hello"      "red"      "day 4 BSL"
```

`string-append` concatenates multiple strings into one.

```scheme
(string-append "what a " "lovely " "day" )
; "what a lovely day"
```

### 1.3 Mixing It Up

Operations on Strings with mixed data types.

- `string-length`: takes a string an returns its length as a number

```scheme
(string-length "hello") ;5
```

- `string-ith`: extracts the character (1String) at position `i` from a string (0-based index)

```scheme
(string-ith "hello" 1) ;"e
```

- `number->string`: converts a number into a string

```scheme
(number->string 42) ;"42"
```

- `substring`: Extracts the substring starting at `i` up to `j`

```scheme
(substring "hello world" 1 5) ;"ello"
(substring "hello world" 4)   ;"o world"
```

### 1.4 The Arithmetic of Images

Images are rectangular pieces of data.To work with images, add the library: `(require 2htdp/image)`.

Images are **values**, just like numbers or strings, and can be manipulated with various operations.

**Basic shapes**

```scheme
(circle r mode color)          ; Circle with radius r, mode, and color
(rectangle w h mode color)     ; Rectangle with width w, height h, mode, and color
(ellipse rx ry mode color)     ; Ellipse with radii rx and ry
(triangle size mode color)     ; Equilateral triangle
(line x1 y1 color)             ; Line from two points
(text str size color)          ; Text image with string, font size, and color
```

**Image properties**

- `image-width`: returns the width of an image in pixels
- `image-height`: returns the height of an image in pixels

```scheme
(image-width (circle 10 "solid" "red")) ;20
```

**Image composition**

- Images have an **anchor point**, typically at the center
- `overlay`: layers images on top of each other at their anchor point
- `overlay/xy`: offsets one image by `(x, y)` pixels before layering
- `overlay/align`: aligns anchor points to specific parts of the rectangle

```scheme
(overlay (square 4 "solid" "orange") (circle 6 "solid" "yellow"))
(overlay/xy (circle 6 "solid" "yellow") 10 10 (square 4 "solid" "orange"))
```

**Scene manipulation**

- `empty-scene`: creates a blank rectangle of a specified width and height
- `place-image`: places an image at a specific position in a scene
- `scene+line`: draws a line in a scene using coordinates and a color

```scheme
(place-image (circle 6 "solid" "yellow") 10 10 (empty-scene 20 20))
```

### 1.5 The Arithmetic of Booleans

Booleans are primitive data used to represent decisions or states. There are two possible values:

- `#true`
- `#false`

**Boolean operations**

- `or`: checks if _any_ of the given values is `#true`
- `and`: checks if _all_ of the given values are `#true`
- `not`: returns the opposite of the given Boolean

```scheme
(or #true #false)  ;#true
(and #true #false) ;#false
(not #false)       ;#true
```

### 1.6 Mixing It Up with Booleans

**The `if` expression**

The `if` expression enables conditional computations in BSL.

```scheme
(if <condition> <true-result> <false-result>)
```

E.g.

```scheme
(if (= x 0)
    0          ;if condition is true, return 0
    (/ 1 x))   ;if condition is false, evaluate (/ 1 x)
```

**Comparison primitives** \

- Comparison operators: `<`, `<=`, `>`, `>=`, `=`

**String comparisons**

- `string=?`: checks if two strings are equal

```scheme
(string=? "hello" "world") ;#false
```

- `string<=?` and `string>=?`: determine alphabetical order of string

```scheme
(string<=? "apple" "banana") ;#true
```

### 1.7 Predicates: Know Thy Data

**Using predicates**\
A **predicate** is a function that checks whether a value belongs to a specific data type, returning a Boolean.

```scheme
(number? 4)          ;#true
(number? "fortytwo") ;#false
```

Common predicates include: `number?`, `string?`, `image?`, `boolean?`

**Predicates for Numbers**\
Numbers are classified in two ways:

- by construction: `integer?`, `rational?`, `real?`, `complex?`
- by exactness: `exact?`, `inexact?`

## 2 Functions and Programs

### 2.1 Functions

In BSL, functions are **defined** using the `(define)` construct. A function consists of:

- A **name**
- One or more **variables** (inputs or parameters)
- A **body** (an expression that computes the output)

```scheme
(define (FunctionName Variable ... Variable)
  Expression)
```

Once a function is defined, it can be **applied** by calling its name and passing the appropriate number of arguments. The number of arguments must match the number of parameters in the definition.

```scheme
(sum 4 5)   ;9 (4 + 5)
```