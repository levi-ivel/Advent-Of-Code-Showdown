function SolvePart1()
    local counter = 0
    for line in io.lines('Day2Data.txt') do
        counter = counter + 1
    end
    return counter 
end

-- Benchmarking
local average = 0

for i = 0, 1000 do
    local timestart = os.clock()
    
    print(SolvePart1())
    print()
    
    local time = os.clock() - timestart
    average = average + time
    print(time)
    print()
end

average = average / 1000
local seconds = average
local milliseconds = seconds * 1000
local microseconds = milliseconds * 1000

print("AoC 2025 Day 1 Part 1")
print(string.format("De average is: %f seconden, (of %f milliseconden), (of %f microseconden)", 
    seconds, milliseconds, microseconds))
