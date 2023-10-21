# Write a program to read through a mail log, build a histogram using a dictionary to count how many messages have come from each email address, and print the dictionary.

name = input("Enter file name:")
if len(name) < 1:
    name = "mbox.txt"
handle = open(name)

# email counts
d = dict()
# Read through mail log
for line in handle:
    # count the occurence of 3rd word
    if line.startswith("From "): 
        words = line.split(" ")
        d[words[1]] = d.get(words[1], 0) + 1
print(d)



