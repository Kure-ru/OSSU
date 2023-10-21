# Exercise 1: Revise a previous program as follows: Read and parse the “From” lines and pull out the addresses from the line. Count the number of messages from each person using a dictionary.

# After all the data has been read, print the person with the most commits by creating a list of (count, email) tuples from the dictionary. Then sort the list in reverse order and print out the person who has the most commits.

name = input("Enter file:")
if len(name) < 1:
    name = "mbox.txt"
handle = open(name)

d = dict()
# Read through mail log
for line in handle:
    # count the occurence of 3rd word
    if line.startswith("From "):
        words = line.split(" ")
        d[words[1]] = d.get(words[1], 0) + 1

# Create a list of (count, email) tuples from the dictionary. 
lst = list()
for key, value in list(d.items()):
    lst.append((value, key))

lst.sort(reverse=True)

print(lst[0][1], lst[0][0])
