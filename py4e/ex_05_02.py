#Write another program that prompts for a list of numbers as above and at the end prints out both the maximum and minimum of the numbers instead of the average.

largest = None
smallest = None
while True:
    num = input("Enter a number: ")
    if num == "done":
        break
    try:
        value = int(num)
        if largest == None:
            largest = value
            smallest = value
        else:
            if value > largest:
                largest = value
            if value < smallest:
                smallest = value
    except:
        print("Invalid input")

print("Maximum is", largest)
print("Minimum is", smallest)
