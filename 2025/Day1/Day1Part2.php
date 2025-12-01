<?php
function SolvePart2() : int{
    $input = file_get_contents('Day1Data.txt');
    $lines = explode("\n", $input);

    $dial = 50;
    $counter = 0;

    foreach ($lines as $line) {
        $direction = substr($line, 0, 1);

        // Sidenote: want to know why this is the only type hinted value? Because it decreases runtime
        // Why not type hint the rest? BECAUSE THAT INCREASES RUNTIME
        // WHY?
        $amount = (int)substr($line, 1);

        if ($direction == "L"){
            // Calculate passes trough 0 by doing disrance from dial to 0 modulo 100
            $passes = $dial % 100;

            // Decrease dial, wrapping around 0
            $dial = (($dial - $amount) % 100 + 100) % 100;
        }
        else if ($direction == "R"){
            // Calculate passes trough 0 by doing disrance from dial to 100 modulo 100
            $passes = (100 - $dial) % 100;

            // Increase dial, wrapping around 99
            $dial = ($dial + $amount) % 100;
        }

        // Prevent edge case where previous dial was 0
        if ($passes == 0) {
            $passes = 100;
        }

        // Counter for how many times we passed 0
        if ($amount >= $passes) {
            $counter += 1 + intdiv($amount - $passes, 100);
        }

    }

    return $counter;
}

// Benchmarking
$average = 0;

for ($i = 0; $i <= 1000; $i++){
    $timestart = microtime(true);

    echo SolvePart2(); //6789
    echo "\n";

    $time = (microtime(true) - $timestart);
    $average += $time;
    echo $time;
    echo "\n";
}

$average /= 1000;
$seconds = $average;
$milliseconds = $seconds * 1000;
$microseconds = $milliseconds * 1000;

echo "AoC 2025 Day 1 Part 2\n";
echo "De average is: $seconds seconden, (of $milliseconds milliseconden), (of $microseconds microseconden)\n";

