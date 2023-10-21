name = input("Enter file:")
if len(name) < 1:
    name = "mbox.txt"
handle = open(name)

d = dict()
# Read through mail log
for line in handle:
    # count domain names
    if line.startswith("From "):
        print(line)
        words = line.split(" ")
        address = words[1]
        atpos = address.find('@')
        domain = address[atpos + 1:]
        print(domain)
        d[domain] = d.get(domain, 0) + 1

print(d)
