import datetime

def SolvePart2():
    count = 0

    with open('Day3Data.txt') as input:
        for line in input:
            # Split number into digit elements of a list
            digits = list(map(int, str(line.strip())))

            # Track the best 0 to 12 digit number respecting order
            best = [-1] * 13
            # 0 digits = 0
            best[0] = 0

            # Holy shit knowing stalin sort is usefull
            # We track the best pairs without breaking order instead of deleting the ones breaking order though 
            for digit in digits:
                length = 11

                # We also take length into account this time around, in a quite brute force manner
                while length >= 0:
                    candidate = best[length] * 10 + digit

                    if candidate > best[length + 1]:
                        best[length + 1] = candidate

                    length -= 1

            count += best[12]

    return count

# Benchmarking
average = 0

for i in range(1000):
    start = datetime.datetime.now()
    print(SolvePart2()) # 168617068915447
    end = datetime.datetime.now()
    time = end - start

    average += time.microseconds

microseconds = average / 1000
miliseconds = microseconds / 1000
seconds = miliseconds / 1000

print("AoC 2025 Day 3 Part 2")
print(f"De average is {seconds} seconden (of {miliseconds} miliseconden) (of {microseconds} microseconden)")