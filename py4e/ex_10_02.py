# Write a program to read through the mbox-short.txt and figure out the distribution by hour of the day for each of the messages. You can pull the hour out from the 'From ' line by finding the time and then splitting the string a second time using a colon.
# From stephen.marquard@uct.ac.za Sat Jan  5 09:14:16 2008
# Once you have accumulated the counts for each hour, print out the counts, sorted by hour as shown below.

name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"
handle = open(name)

d = dict()
# Read through mail log
for line in handle:
    # count the occurence of hours
    if line.startswith("From "):
        words = line.split(" ")
        d[words[6][:2]] = d.get(words[6][:2], 0) + 1


# Sort the dictionary by value
lst = list(d.items())
lst.sort()

for key, val in lst:
    print(key, val)
