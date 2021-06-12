const stdout = @import("./stdout.zig");

pub fn main() !u8 {
    try stdout.println("Not yet implemented");
    try stdout.printf("{s}{d}.{d}\n", .{ "v", 0, 0 });

    return 1;
}
