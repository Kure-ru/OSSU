# Encapsulate this code in a function named count, and generalize it so that it accepts the string and the letter as arguments.

def countLetter(word, char):
    count = 0
    for letter in word:
        if letter == char:
            count = count + 1
    print(count)

countLetter('banana', 'a')