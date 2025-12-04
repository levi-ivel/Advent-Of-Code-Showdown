const std = @import("std");

pub fn SolvePart2() !i32 {
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
    const lines_const = try lines_list.toOwnedSlice(alloc);
    defer alloc.free(lines_const);

    // const to mutable lines for replacment later
    const lines = try alloc.alloc([]u8, lines_const.len);
    defer alloc.free(lines);

    for (lines_const, 0..) |ln, i| {
        lines[i] = @constCast(ln);
    }

    var count: i32 = 0;
    var queue = std.ArrayList(struct { row: usize, col: usize }){};
    defer queue.deinit(alloc);

    // Get all initial @ positions and add them to the queue
    for (lines, 0..) |line, row| {
        for (line, 0..) |char, col| {
            if (char == '@') {
                try queue.append(alloc, .{ .row = row, .col = col });
            }
        }
    }

    while (queue.items.len != 0) {
        const pos = queue.items[queue.items.len - 1];
        queue.items.len -= 1;

        // Guard clauses for non candidates
        if (lines[pos.row][pos.col] != '@') continue;
        if (GetNeighbors(lines, pos.row, pos.col) >= 4) continue;

        // If candidate is found, replace them with a . before +1 count
        lines[pos.row][pos.col] = '.';
        count += 1;

        // Check the neighbors of destroyed @ and add them to the queue for rechecking
        const row_start = if (pos.row == 0) 0 else pos.row - 1;
        const row_end = @min(pos.row + 1, lines.len - 1);
        var row = row_start;

        // Shoutout https://www.geeksforgeeks.org/dsa/islands-in-a-graph-using-bfs/
        while (true) {
            if (lines[row].len != 0) {
                const max_col = lines[row].len - 1;
                const col_start = if (pos.col == 0) 0 else pos.col - 1;

                if (col_start <= max_col) {
                    const col_end = @min(pos.col + 1, max_col);
                    var col = col_start;
                    while (col <= col_end) : (col += 1) {
                        if (lines[row][col] == '@') {
                            try queue.append(alloc, .{ .row = row, .col = col });
                        }
                    }
                }
            }

            // Go to the next row or break
            if (row == row_end) break;
            row += 1;
        }
    }
    return count;
}

// Function to get all @ neighbors
fn GetNeighbors(lines: [][]u8, row: usize, col: usize) usize {
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
        std.debug.print("{any}\n", .{SolvePart2()}); // 9024
        const end = @as(f64, @floatFromInt(std.time.nanoTimestamp()));
        average += (end - start);
    }

    average /= 1000.0;

    const microseconden = average / 1_000.0;
    const miliseconden = microseconden / 1_000.0;
    const seconden = miliseconden / 1_000.0;

    std.debug.print("Advent of Code Day 4 Part 2\n", .{});
    std.debug.print("De average is {d} seconden (of {d} miliseconden of {d} microseconden)\n", .{ seconden, miliseconden, microseconden });
}
