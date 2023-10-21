# Write a program which prompts the user for a Celsius temperature, convert the temperature to Fahrenheit, and print out the converted temperature.
inp = input('Enter a Celsius temperature: ')
celsius = float(inp)
fahrenheit = celsius * 8 + 32
print(fahrenheit)