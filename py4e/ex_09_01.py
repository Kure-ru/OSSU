# Write a program that reads the words in words.txt and stores them as keys in a dictionary. It doesn’t matter what the values are. Then you can use the in operator as a fast way to check whether a string is in the dictionary.

# Create a dictionary
wordsDict = dict()

# Open words.txt
fhand = open('words.txt')

# Loop through the words
for line in fhand:
    words = line.split(' ')
    for word in words:
        wordsDict[word] = ''

# Check for words in the dictionary 
print('fast' in wordsDict)
print('armchair' in wordsDict)