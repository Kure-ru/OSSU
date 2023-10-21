# Use the file name mbox-short.txt as the file name
fname = input("Enter file name: ")
fh = open(fname)
dspam_values = 0
count = 0
for line in fh:
    if not line.startswith("X-DSPAM-Confidence:"):
        continue
    count += 1
    start = line.find(" ")
    value = float(line[start + 1 :])
    dspam_values += value
print("Average spam confidence:", dspam_values / count)
