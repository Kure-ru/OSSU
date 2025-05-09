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

### 2.2 Computing

When a function is applied, DrRacket follows these steps:

1. Evaluate argument expressions
2. **Check that the number of argument** matches the number of function parameters.
3. **Substitute** the parameters with argument values and **compute** the result

### 2.3 Composing Functions

Programs are composed of:

- Main function
- Auxiliary (helper) functions

This structure makes programs **modular**, easier to understand and maintainable.

Each function handles a distinct part of the task, adhering to the principle: _Define one function per task_.

**Advantages of modularity** are that smaller functions are easier to design and debug. Changing to a specific part of the problem only require modifying the corresponding function.

### 2.4 Global Constants

Global constants store values that are:

- used frequently across functions
- unchanging throughout the program

Constants make programs easier to maintain and read.

Defining a global function:

```scheme
(define CONSTANT-NAME VALUE)
```

**Conventions**\
Use UPPERCASE names for global constants.\
Use meaningful names to clarify their purpose in the program.

**Advantages**

- Changing a constant value automatically updates all its uses in the program.
- Prevents errors by avoiding repetitive hardcoding of values.
- Readers can quickly identify constants and their purpose.

_For every constant mentioned in a problem statement, introduce one constant definition._

### 2.5 Programs

A **program** consists of:

- Function definitions
- Constant definitions

Programs are classified in two categories:

- Batch programs
- Interactive programs

A **batch program** takes all its inputs at once, processes them, and produces the output.

**Batch program I/O**

- `read-file`: reads the entire content of a file as a string
- `write-file`: writes a string to a file or outputs to `'stdout`

```scheme
> (write-file "sample.dat" "212")
"sample.dat"

> (read-file "sample.dat")
"212"
```

Example batch program: Fahrenheit to Celsius converter

```scheme
(define (C f)
  (* 5/9 (- f 32)))
```

```scheme
(define (convert in out)
  (write-file out            ;Writes the result to the output file.
    (string-append
      (number->string
        (C
          (string->number
            (read-file in))))))) ;Reads input file content
```

An **interactive program** responds to events (e.g. user inputs, clicks...). It maps events to specific functions (event handlers), and informs the operating system about how to handle events. It is often created for Graphical User Interfaces (GUI).

The Big-Bang mechanism is a framework to define interactive programs in BSL. Its key components are:

- initial state: starting point for the program
- event handlers: (`on-tick`, `on-key`, ...)
- render function: (`to-draw`) which converts state into a visual representation
- stop condition: (`stop-when`) which determines when the program ends.

## 3 How to Design Programs

Programming is about mastery of:

- a language with vocabulary, grammar, semantics
- how to get from a problem statement to a program

**Systematic design vs. "Garage programming"**\
Muddling through without structure often leads to limited, unsustainable programs.\
Programs need to be comprehensible, maintainable, and adaptable for other developers and your future self.

**Key aspects of good programming**\
Clear documentation about what the program does, its expected inputs and outputs\
Logical connections between the program and the problem statement to facilitate changes and debugging.

**The Design recipe**\
Systematic approach to create and organize programs based on **problem data**.

### 3.1 Designing Functions

A program transforms **information into data**, processes it, and converts it **back to information**.

The **Model-View-Controller** (MVC) design separates **data processing** (core computation) from **parsing** (information to data) and **rendering** (data to information).

A [**data definition**](./00_preface.md) defines how information in the program's domain is represented as data in the code. It names the data class, and explains what it represents.

```scheme
; A Temperature is a Number
; interpretation: represents Celsius degrees
```

**The design process**

1. Represent information as data

```scheme
; We use numbers to represent centimeters.
```

2. Write a signature, purpose, function header

```scheme
; << signature >>
; Number String Image -> Image

; << purpose (what does the function compute?) >>
; adds s to img,
; y pixels from the top and 10 from the left

; << header, simplistic function definition >>
(define (add-image y s img)
  (empty-scene 100 100))
```

3. Add functional examples

```scheme
; Number -> Number
; computes the area of a square with side len
; given: 2, expect: 4
; given: 7, expect: 49
(define (area-of-square len) 0)
```

4. Take _inventory_ - replace the function's body by with a _template_.

```scheme
(define (area-of-square len)
   (... len ...))
```

5. Write executable expressions and function definitions

```scheme
(define (area-of-square len)
  (sqr len))
```

6. Test the function on the examples from 3.

```scheme
> (area-of-square 2)
4
> (area-of-square 7)
49
```

### 3.2 Finger Exercises: Functions

### 3.3 Domain Knowledge

**Domain knowledge** is essential for writing the body of a fonction. It encompasses:

- external domain knowledge (mathematics, biology, music, art...)
- programming library knowledge

Problems that demand domain knowledge often emerge from analyzing **data definitions**.

### 3.4 From Functions to Programs

Programs often consist of several functions and constants, not just a single function.

Constants can simplify functions by providing **global**, reusable values.

Maintain a _wish list_ of all the functions needed to complete the program. Each entry should include:

- function name
- signature
- purpose statement

Tackle function from the _wish list_ systematically. If a function reveals the need for additionnal helper functions, add them to the _wish list_. When the list is empty, you are done.

### 3.5 On Testing

Testing helps identify and prevent bugs. Automated testing ensures consistent and efficient verification of program functionality.

```scheme
; Number -> Number
; converts Fahrenheit temperatures to Celsius
(check-expect (f2c -40) -40)
(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)

(define (f2c f)
  (* 5/9 (- f 32)))
```

This automated approach is known as **unit testing**.

### 3.6 Designing World Programs

World programs are build with the `2htdp/universe` library.

> Wish list for designing world programs

```scheme
; WorldState: data that represents the state of the world (cw)

; WorldState -> Image
; when needed, big-bang obtains the image of the current
; state of the world by evaluating (render cw)
(define (render ws) ...)

; WorldState -> WorldState
; for each tick of the clock, big-bang obtains the next
; state of the world from (clock-tick-handler cw)
(define (clock-tick-handler cw) ...)

; WorldState String -> WorldState
; for each keystroke, big-bang obtains the next state
; from (keystroke-handler cw ke); ke represents the key
(define (keystroke-handler cw ke) ...)

; WorldState Number Number String -> WorldState
; for each mouse gesture, big-bang obtains the next state
; from (mouse-event-handler cw x y me) where x and y are
; the coordinates of the event and me is its description
(define (mouse-event-handler cw x y me) ...)

; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw)
(define (end? cw) ...)
```

**Sample Problem**: Design a program that moves a car from left to right on the world canvas, three pixels per clock tick.

1. Define constants

```scheme
(define WIDTH-OF-WORLD 200)

(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle ... WHEEL-RADIUS ... "white"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
```

2. Define world state

```scheme
; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car
```

3. Design functions to form a valid [big-bang](https://docs.racket-lang.org/teachpack/2htdpuniverse.html#%28form._world._%28%28lib._2htdp%2Funiverse..rkt%29._big-bang%29%29) expression.

```scheme
; WorldState -> Image
; places the image of the car x pixels from
; the left margin of the BACKGROUND image
(define (render x)
  BACKGROUND)

; WorldState -> WorldState
; adds 3 to x to move the car right
(define (tock x)
  x)
```

4. Create a `main` function to launch the world program.

```scheme
; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]))
```

You can launch the program with `(main 13)` to watch the car start at 13 pixels from the left margin.

### 3.7 Virtual Pet Worlds

## 4 Intervals, Enumerations, and Itemizations

### 4.1 Programming with Conditionals

`cond` is a construct for writing conditional (multi-branch) logic in a clean, readable way.

```scheme
(cond [question-expression answer-expression] ...)
(cond [question-expression answer-expression]
      ...
      [else answer-expression])
```

Example:

```scheme
(define (next traffic-light-state)
  (cond
    [(string=? "red" traffic-light-state) "green"]
    [(string=? "green" traffic-light-state) "yellow"]
    [(string=? "yellow" traffic-light-state) "red"]))
```

### 4.2 Computing Conditionally

DrRacket checks conditions one by one in order.

- If a condition evaluates to `#true`, it executes the corresponding result and stops.
- If no conditions evaluate to`#true`, the `else` clause (if present) is executed.

### 4.3: Enumerations

An enumeration defines a **collection of data** as a **finite** number of pieces of data.

```scheme
; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three
; possible states that a traffic light may assume
```

Use enumerations when:

- A data type has a **finite** set of **distinct values**.
- Each possible value needs to be **handled explicitly**.

```scheme
; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))
```

### 4.4 Intervals

An **interval** describes a range of numbers with specified boundaries. Boundaries can be **inclusive** (closed) or **exclusive** (open).

- Closed boundary: includes the boundary value `[3, 5]`
- Open boundary: excludes the boundary value `(3, 5)`

### 4.5 Itemizations

**Itemization** combine intervals, enumerations and individual data elements into a single cohesive definition.

```scheme
; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)
```

### 4.6 Designing with Itemizations

Design recipe rules:

1. A data definition must use distinct _clauses_ for each sub-class of data.
2. Signature, purpose statement, function header
3. Examples: pick at least one example from each sub-class in the data definition. If a sub class is a finite range, pick examples from the boundaries of the range and its interior.
4. The template mirrors the organization of sub-classes with a [cond](https://docs.racket-lang.org/htdp-langs/beginner.html#%28form._%28%28lib._lang%2Fhtdp-beginner..rkt%29._cond%29%29)

### 4.7 Finite State Worlds

A _Finite State Machine_ (FSM) or _Finite State Automaton_ (FSA) is a system with a limited set of states and specific transitions between them.It is composed of:

- **states**: different configurations of the system
- **transitions**: define how the system moves from one state to another
- **triggers**: external factors that cause transitions

Use a **data definition** to represent the states of a FSM. (see [4.3: Enumerations](#43-enumerations))

Write functions to handle state transitions and render states.

## 5 Adding Structure

### 5.1 From Positions to `posn` Structures

DrRacket uses `posn` structures to combine two number into a single value, representing a position.

```scheme
(make-posn 3 4)   ;x = 3 ;y = 4
```

`posn` structures are treated like other basic data types. They can be consumed and produced by both primitive operation and functions.

### 5.2 Computing with `posns`

`posn` structures represent Cartesian points or positions on a plane, similar to how positions are represented in mathematics.

To retrieve the x-coordinate or y-coordinate from a `posn`:

```scheme
(define p (make-posn 31 26))
(posn-x p) ;31
(posn-y p) ;26
```

### 5.3 Programming with `posn`

### 5.4 Defining Structure Types

The syntax for defining a new structure type is `(define-struct StructureName [FieldName...])`

E.g.

```scheme
(define-struct entry [name phone email])
```

A structure type definition defines simultaneously:

- one **constructor**, a function that creates **structure instances**

```scheme
(make-entry "Al Abe" "666-7771" "lee@x.me")
```

- one **selector**, which extracts the value of the field from a structure instance

```scheme
(entry-name  x)
(entry-phone x)
(entry-email x)
```

- one **structure predicate**, which distinguishes instances from all other kinds of values

```scheme
(entry? x)
```

### 5.5 Computing with Structures

Structures can have **arbitrary** numbers of fields.

### 5.6 Programming with Structures

Structures provide a way to represent more complex data in a program.
Eample of an _updater_ / _functional setter_ function.

```scheme
(define (x+ p)
  (posn-up-x p (+ (posn-x p) 3)))
```

Use **consistent** field meanings for a structure within a program.
Break down tasks into **helper functions**, especially when dealing with nested structures.
Follow the **design recipe** to manage conplexity.

### 5.7 The Universe of Data

Every programming language has a _universe of data_, which includes all built-in data and data any program may create.
This universe is **infinite** because it includes all numbers, strings and other possible data combinations.

Data definitions help specify and restrict parts of the data universe.
Structures expand the universe with new combinations.

### 5.8 Designing with Structures

Structures group related pieces of information into a single entity. When designing functions that consume structures, the **design recipe** is as follows:

1. Define a structure using `define-struct` along with a **dat definition** and examples

```scheme
(define-struct ball (x y))
;; Ball is (make-ball Number Number)
;; interp. a ball at position x, y

(define BALL-1 (make-ball 6 10)) ;example of a Ball
```

2. Use the **selectors** for each field of the structure. The function template should include **all selectors** for the given structure type.

```scheme
#;
(define (fn-for-ball b)
  (... (ball-x b)     ;Number
       (ball-y b)))   ;Number
;; Template rules used:
;;  - compound: 2 fields
```

### 5.9 Structure in the World

When a world program must track multiple pieces of data, use a **structure** with fields for each independent element of information.

```scheme
;; For a space game with a UFO and a tank:

(define-struct space-game [ufo tank])
; A SpaceGame is a structure:
;   (make-space-game Posn Number).
; interpretation (make-space-game (make-posn ux uy) tx)
; describes a configuration where the UFO is
; at (ux,uy) and the tank's x-coordinate is tx
```

### 5.10 A Graphical Editor

### 5.11 More Virtual Pets

## 6 Itemizations and Structures

### 6.1 Designing with Itemizations, Again

An _itemization_ describes **data comprised of 2 or more subclasses, at least one of which is not a distinct item**.

1. Structure definition
2. Type comment that defines a new type name and describes how to form data of that type
3. An interpretation that describes the correspondence between information and data
4. One or more examples of the data.
5. A template for a 1 argument function operating on data of this type.

```scheme
;; Bird is one of:
;;  - false
;;  - Number
;; interp. false means no bird, number is x position of bird

(define B1 false)
(define B2 3)

#;
(define (fn-for-bird b)
  (cond [(false? b) (...)]
        [(number? b) (... b)]))
;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: false
;;  - atomic non-distinct: Number
```

### 6.2 Mixing Up Worlds

### 6.3 Input Errors

**Predicates** help verify that input data matches expected types. They are crucial when designing functions for mixed or unpredictable data, especially when sharing programs with others.

**Checked functions** include explicit input validation. Use predicates such as `number?` or `string?` to test data types.
Signal invalid input errors with informative messages using the `error` function.

```scheme
; Any -> Number
; computes the area of a disk with radius v,
; if v is a number
(define (checked-area-of-disk v)
  (cond
    [(number? v) (area-of-disk v)]
    [else (error "area-of-disk: number expected")]))
```

The `Any` type refers to any BSL value and is open-ended.

### 6.4 Checking the World

World programs handle multiple events (e.g. clock ticks, mouse clicks, keystrokes, rendering), increasing complexity.
Errors may not surface immediately when incorrect data is passed between event-handling functions, leading to hard-to-diagnose bugs.

The `big-bang` function in BSL offers a `check-with` clause to validate world states after every event.

```scheme
(define (main s0)
  (big-bang s0 ... [check-with number?] ...))
```

Any invalid state stops the program and provides an error message.

### 6.5 Equality Predicates

An **equality predicate** is a function that compares two elements of the same collection of data.

```scheme
; TrafficLight TrafficLight -> Boolean
; are the two (states of) traffic lights equal

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)

(define (light=? a-value another-value)
  (string=? a-value another-value))
```

If inputs of unexpected types are provide, the program may produce runtime errors.

```scheme
> (light=? "beans" 10)
string=?:expects a string as 2nd argument, given 10
```

Ensure inputs belong to the expected data collection before comparing them

```scheme
; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))
```
