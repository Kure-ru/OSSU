# User input
annual_salary = int(input("Enter your annual salary: "))
portion_saved = float(input("Enter the percent of your salary to save, as a decimal: "))
total_cost = int(input("Enter the cost of your dream home: "))

portion_down_payment = 0.25
current_savings = 0 
total_months = 0

saved_salary = (annual_salary * portion_saved) / 12

def calculate_investment(savings):
    r = 0.04
    return savings * r / 12

while current_savings < portion_down_payment * total_cost:
    # increase total of months
    total_months += 1
    # calculate investment
    current_savings = current_savings + calculate_investment(current_savings)
    # savings increase by return on investment + % of monthly salary
    current_savings = current_savings + saved_salary
    
# print number of months
print(f'Number of months: {total_months}')

