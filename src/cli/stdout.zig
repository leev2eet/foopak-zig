const std = @import("std");

const stdout = std.io.getStdOut().writer();

pub fn println(arg: []const u8) !void {
    try stdout.print("{s}\n", .{arg});
}

pub fn printf(comptime format: []const u8, args: anytype) !void {
    try stdout.print(format, args);
}
