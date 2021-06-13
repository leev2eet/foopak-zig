const std = @import("std");
const string = @import("../../../src/string/string.zig");

const ConstString = string.ConstString;

const expectEqual = std.testing.expectEqual;

test "should correctly return characters for pure ascii string" {
    var str = ConstString.init("Hello World!");

    var char = try str.charAt(4);

    try expectEqual(@as(u21, 'o'), char);
}

test "should correctly return characters for strings containing unicode characters" {
    var str = ConstString.init("Héllô Wórld‼");

    const char = try str.charAt(11);

    try expectEqual(@as(u21, 0x203C), char);
}
