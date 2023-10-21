# Write a program that categorizes each mail message by which day of the week the commit was done. To do this look for lines that start with “From”, then look for the third word and keep a running count of each of the days of the week. At the end of the program print out the contents of your dictionary (order does not matter).

# Create dict
d = dict()
# Open file
fhand = open("mbox.txt")
# Find lines that start with "From"
for line in fhand:
    # count the occurence of 3rd word
    if line.startswith("From"):
        words = line.split(" ")
        if len(words) > 2:
            d[words[2]] = d.get(words[2], 0) + 1

# print out contents of dict
print(d)
