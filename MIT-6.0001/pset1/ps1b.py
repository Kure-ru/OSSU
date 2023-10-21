# Get user input
annual_salary = int(input("Enter your annual salary: "))
portion_saved = float(input("Enter the percent of your salary to save, as a decimal: "))
total_cost = int(input("Enter the cost of your dream home: "))
semi_annual_raise = float(input("Enter the semiannual raise, as a decimal: "))

# Initialize state variables
portion_down_payment = 0.25
current_savings = 0 
total_months = 0


def calculate_investment(savings):
    r = 0.04
    return savings * r / 12

# Loop until enough savings for down payment
while current_savings < portion_down_payment * total_cost:
    # Calculate monthly savings
    saved_salary = (annual_salary * portion_saved) / 12
    # increase total of months
    total_months += 1
    # calculate investment
    current_savings = current_savings + calculate_investment(current_savings)
    # savings increase by return on investment + % of monthly salary
    current_savings = current_savings + saved_salary
    # salary increase every 6 months
    if total_months % 6 == 0:
        annual_salary = annual_salary + (annual_salary * semi_annual_raise)

# print number of months
print(f'Number of months: {total_months}')

