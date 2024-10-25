try:
 n = int(input("How old are you? "))
 percent = round(n*100/80, 1)
 print("You've gone through", percent, "% of your life!")
except ValueError:
 print("Oops, must enter a number.")
except ZeroDivisionError:
 print("Division by zero.")
except:
 print("Something went very wrong.")