import datetime

def SolvePart1():
    count = 0

    with open('Day3Data.txt') as input:
        for line in input:
            # Split number into digit elements of a list
            digits = list(map(int, str(line.strip())))

            # Track the best two-digit number respecting order
            first = digits[0]
            best = 0

            # Holy shit knowing stalin sort is usefull
            # We track the best pairs without breaking order instead of deleting the ones breaking order though 
            for digit in digits:
                candidate = first * 10 + digit

                if candidate > best:
                    best = candidate

                if digit > first:
                    first = digit

            count += best

    return count

# Benchmarking
average = 0

for i in range(1000):
    start = datetime.datetime.now()
    print(SolvePart1()) # 16993
    end = datetime.datetime.now()
    time = end - start

    average += time.microseconds

microseconds = average / 1000
miliseconds = microseconds / 1000
seconds = miliseconds / 1000

print("AoC 2025 Day 3 Part 1")
print(f"De average is {seconds} seconden (of {miliseconds} miliseconden) (of {microseconds} microseconden)")