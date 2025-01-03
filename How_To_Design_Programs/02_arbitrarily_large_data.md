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
