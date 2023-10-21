# Rewrite the grade program from the previous chapter using a function called computegrade that takes a score as its parameter and returns a grade as a string.

def computegrade(value):
    if value > 1 or value < 0:
            print("Bad score")
    else:
        if value >= 0.9:
            print("A")
        elif value >= 0.8:
            print("B")
        elif value >= 0.7:
            print("C")
        elif value >= 0.6:
            print("D")
        elif value < 0.6:
            print("F")

score = input("Enter Score: ")
try:
    value = float(score)
    computegrade(value)
except:
    print("Bad score. Please enter a value between 0.0 and 1.0")