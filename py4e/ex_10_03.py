# Write a program that reads a file and prints the letters in decreasing order of frequency. Your program should convert all the input to lower case and only count the letters a-z. Your program should not count spaces, digits, punctuation, or anything other than the letters a-z. Find text samples from several different languages and see how letter frequency varies between languages. Compare your results with the tables at https://wikipedia.org/wiki/Letter_frequencies.

# Write a program that reads the words in words.txt and stores them as keys in a dictionary. It doesn’t matter what the values are. Then you can use the in operator as a fast way to check whether a string is in the dictionary.

import string 

# Create a dictionary
letter_counts = dict()

# Open words.txt
with open('words.txt') as file:
    text = file.read()

# remove punctuation and convert to lower case
    text = text.translate(str.maketrans('', '', string.punctuation))
    text = text.lower()

# Loop through the words
for line in text:
    chars = ([*line])
    for char in chars:
        if char.isalpha():
            if char in letter_counts:
                letter_counts[char] += 1
            else:
                letter_counts[char] = 1

# Sort the dictionary by frequency
sorted_counts = sorted(letter_counts.items(), key=lambda x: x[1], reverse=True)

for count in sorted_counts:
    print(count[0], count[1])
