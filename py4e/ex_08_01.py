# Write a function called chop that takes a list and modifies it, removing the first and last elements, and returns None. Then write a function called middle that takes a list and returns a new list that contains all but the first and last elements.

def chop(t):
    first = t[0]
    last = t[-1]
    chopped = t.remove(first)
    chopped = t.remove(last)
    return chopped

def middle(t):
    t.pop(0)
    t.pop(-1)
    return t