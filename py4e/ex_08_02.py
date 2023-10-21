fhand = open("mbox-short.txt")
count = 0
for line in fhand:
    words = line.split()
    # Guardian pattern
    if len(words) < 3 or words[0] != "From":
        continue
    print(words[2])
