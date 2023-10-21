score = input("Enter Score: ")
try:
    value = float(score)
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

except:
    print("Bad score. Please enter a value between 0.0 and 1.0")
