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
                for k = 1, math.floor(lastDigit / 2) do
                    -- A palindrome of length 2 * k can be constructed by leftHalf * (10^k + 1)
                    -- So multiplying mirrors the k
                    local base = 10^k + 1

                    -- Get the valid range of leftHalf values such that leftHalf * base falls within [first, last]
                    -- We clamp this further to ensure leftHalf has exactly k digits
                    local minValue = math.max(math.ceil(first / base), 10^(k-1))
                    local maxValue = math.min(math.floor(last / base), 10^k - 1)

                    -- If we have any valid leftHalf values
                    if minValue <= maxValue then
                        -- Number of leftHalf values
                        local count = maxValue - minValue + 1

                        -- Sum the leftHalf values
                        local sum = (minValue + maxValue) * count / 2

                        -- Convert them back into actual palindromes by multiplying to the base
                        counter = counter + base * sum
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
