<?php
function SolvePart1() : int{
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
            // Decrease dial, wrapping around 0
            $dial = (($dial - $amount) % 100 + 100) % 100;
        }
        else if ($direction == "R"){
            // Increase dial, wrapping around 99
            $dial = ($dial += $amount) % 100;
        }

        // Counter for how many times we landed on 0
        if ($dial == 0){
            $counter += 1;
        }
    }

    return $counter;
}

// Benchmarking
$average = 0;

for ($i = 0; $i <= 1000; $i++){
    $timestart = microtime(true);

    echo SolvePart1(); //1147
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

echo "AoC 2025 Day 1 Part 1\n";
echo "De average is: $seconds seconden, (of $milliseconds milliseconden), (of $microseconds microseconden)\n";

