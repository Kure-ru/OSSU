# Exercise 1: Write a program which repeatedly reads numbers until the user enters “done”. Once “done” is entered, print out the total, count, and average of the numbers. If the user enters anything other than a number, detect their mistake using try and except and print an error message and skip to the next number.

numbers = []
# collect user input
while True:
    inp = input("Enter a number: ")
# if input is done print result
    if inp == 'done':
        print(sum(numbers), len(numbers), sum(numbers) / len(numbers))
        break
# if input is a number, add number to list
    try:
        num = int(inp)
        numbers.append(num)
        continue
    except: # print error message
        print('bad data')


