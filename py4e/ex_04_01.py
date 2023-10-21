# Exercise 1: Run the program on your system and see what numbers you get. Run the program more than once and see what numbers you get.
import random

# The random function is only one of many functions that handle random numbers. The function randint takes the parameters low and high, and returns an integer between low and high (including both).
print(random.randint(5, 10))

# To choose an element from a sequence at random, you can use choice:
t = [1, 2, 3]
print(random.choice(t))