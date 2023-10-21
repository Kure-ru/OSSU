# Get user input
starting_salary = int(input("Enter the starting salary: "))

# Initialize state variables
semi_annual_raise = 0.7
investment_return = 0.04
house_cost = 1000000
down_payment = 0.25 * house_cost
lower_bound = 0
upper_bound = 10000
months = 36
current_savings = 0
steps = 0


def calculate_investment(savings):
    return savings * investment_return / 12


# Calculate 36 months of savings with the saving rate
def calculate_savings(rate, salary):
    current_savings = 0
    for i in range(months):
        # Calculate monthly savings
        monthly_saved_salary = (salary * rate) / 12
        # calculate investment
        current_savings = current_savings + calculate_investment(current_savings)
        # savings increase by return on investment + % of monthly salary
        current_savings = current_savings + monthly_saved_salary
        if i % 6 == 0:
            salary = salary + (salary * semi_annual_raise)
    return current_savings

# portion of salary saved ranges from 0 to 10 000
while upper_bound - lower_bound > 1:
    current_savings = 0
    mid_rate = (lower_bound + upper_bound) / 2 / 10000 # # Convert saving_range to a decimal percentage
    current_savings = calculate_savings(mid_rate, starting_salary)
    #  check if portion is within 100 dollars of required down payment
    if abs(current_savings - down_payment) < 100:
        print("Best savings rate:", mid_rate)
        print("Steps in bisection search:", steps)
        break
    elif current_savings < down_payment:
        lower_bound = mid_rate * 10000  # Adjust the lower bound
    else:
        upper_bound = mid_rate * 10000  # Adjust the upper bound
    steps += 1

if upper_bound - lower_bound <= 1:
    print("It is not possible to pay the down payment in three years.")



