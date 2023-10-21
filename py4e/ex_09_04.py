name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"
handle = open(name)

d = dict()
# Read through mail log
for line in handle:
    # count the occurence of 3rd word
    if line.startswith("From "):
        words = line.split(" ")
        d[words[1]] = d.get(words[1], 0) + 1

# Loop through dictionnary to find most prolific writer
max_key = None
max_val = None

for key, val in d.items():
    if max_val is None or val > max_val:
        max_val = val
        max_key = key

print(max_key, max_val)
