# Write a program to open the file romeo.txt and read it line by line. For each line, split the line into a list of words using the split function. For each word, check to see if the word is already in the list of unique words. If the word is not in the list of unique words, add it to the list. When the program completes, sort and print the list of unique words in alphabetical order.

uniqueWords = []

# Open the file
fname = input("Enter file name: ")
fhand = open(fname)
# iterate through the words
for line in fhand:
    words = line.split()
    # if word is not in the list, add it
    for word in words:
        if word not in uniqueWords:
            uniqueWords.append(word)
# sort in alphabetical order and print the list
uniqueWords.sort()
print(uniqueWords)
