function SolvePart1()
    local counter = 0
    local input = io.open('Day2Data.txt')

    if input then
        local line = input:read()
        if line then
            -- Separate by comma
            for field in line:gmatch('([^,]+)') do
                -- Get first and last number of each range
                local first, last = field:match("(%d+)%-(%d+)")
                first = tonumber(first)
                last = tonumber(last)

                local lastDigit = #tostring(last)

                -- Shoutout to https://www.quora.com/What-is-the-sum-of-all-numbers-between-two-given-numbers and https://stackoverflow.com/questions/16344284/how-to-generate-a-list-of-palindrome-numbers-within-a-given-range and https://www.geeksforgeeks.org/dsa/generate-palindromic-numbers-less-n/ and https://www.geeksforgeeks.org/dsa/sum-first-k-even-length-palindrome-numbers/

                -- Using only even digits
                for digit = 1, math.floor(lastDigit / 2) do
                    -- Make a base that mirrors numbers of that digit count
                    local base = 10^digit + 1

                    -- Get the min and max valuess that can form palindromes and fit in the range
                    local minValue = math.max(math.ceil(first / base), 10^(digit-1))
                    local maxValue = math.min(math.floor(last / base), 10^digit - 1)

                    -- If a valid range is found
                    if minValue <= maxValue then
                        -- Get the amount of numbers in the range
                        local count = maxValue - minValue + 1

                        -- Calculate the sum of al numbers in tge range
                        local sum = (minValue + maxValue) * count / 2

                        -- Multiply by the base to get the total sum of the palindromes
                        local total = base * sum

                        counter = counter + total
                    end
                end
            end
        end
    end
    input:close()
    return counter
end

-- Benchmarking
local average = 0

for i = 1, 1000 do
    local timestart = os.clock()
    
    print(SolvePart1()) -- 12586854255
    print()
    
    local time = os.clock() - timestart
    average = average + time
    print(time * 1000000)
end

average = average / 1000
local seconds = average
local milliseconds = seconds * 1000
local microseconds = milliseconds * 1000

print("AoC 2025 Day 2 Part 1")
print(string.format("De average is: %f seconden, (of %f milliseconden), (of %f microseconden)", 
    seconds, milliseconds, microseconds))
