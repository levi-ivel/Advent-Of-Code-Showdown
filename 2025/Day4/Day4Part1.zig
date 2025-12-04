const std = @import("std");

pub fn SolvePart1() !i32 {
    // All this just to read the lines man
    const alloc = std.heap.page_allocator;

    const input = try std.fs.cwd().readFileAlloc(alloc, "Day4Data.txt", std.math.maxInt(usize));
    defer alloc.free(input);

    var lines_list: std.ArrayList([]const u8) = .empty;

    // Split input into lines and store them in an array
    var it = std.mem.splitScalar(u8, input, '\n');
    while (it.next()) |line| {
        try lines_list.append(alloc, line);
    }

    // Allocate the memory for the array
    const lines = try lines_list.toOwnedSlice(alloc);
    defer alloc.free(lines);

    var count: i32 = 0;

    // For all characters, if the current character is @, check its neighbors
    // If there are less than 4 @ neighbors, +1 count
    for (lines, 0..) |line, row| {
        for (line, 0..) |_, col| {
            if (line[col] == '@') {
                if (GetNeighbors(lines, row, col) < 4) {
                    count += 1;
                }
            }
        }
    }

    return count;
}

// Function to get all @ neighbors
fn GetNeighbors(lines: [][]const u8, row: usize, col: usize) usize {
    var count: usize = 0;

    const max_row = lines.len;
    const max_col = lines[row].len;

    // Check each direction with pure conditionals, +1 if @ found

    // 3 abobe
    if (row > 0) {
        const prev_row = row - 1;
        if (col > 0 and lines[prev_row][col - 1] == '@') count += 1;
        if (lines[prev_row][col] == '@') count += 1;
        if (col + 1 < lines[prev_row].len and lines[prev_row][col + 1] == '@') count += 1;
    }

    // 2 next to
    if (col > 0 and lines[row][col - 1] == '@') count += 1;
    if (col + 1 < max_col and lines[row][col + 1] == '@') count += 1;

    // 3 below
    if (row + 1 < max_row) {
        const next_row = row + 1;
        if (col > 0 and lines[next_row][col - 1] == '@') count += 1;
        if (lines[next_row][col] == '@') count += 1;
        if (col + 1 < lines[next_row].len and lines[next_row][col + 1] == '@') count += 1;
    }

    return count;
}

// Benchmarking
pub fn main() !void {
    var average: f64 = 0;

    for (1..1000) |_| {
        const start = @as(f64, @floatFromInt(std.time.nanoTimestamp()));
        std.debug.print("{any}\n", .{SolvePart1()}); // 1486
        const end = @as(f64, @floatFromInt(std.time.nanoTimestamp()));
        average += (end - start);
    }

    average /= 1000.0;

    const microseconden = average / 1_000.0;
    const miliseconden = microseconden / 1_000.0;
    const seconden = miliseconden / 1_000.0;

    std.debug.print("Advent of Code Day 4 Part 1\n", .{});
    std.debug.print("De average is {d} seconden (of {d} miliseconden of {d} microseconden)\n", .{ seconden, miliseconden, microseconden });
}
