const std = @import("std");
const string = @import("../../../src/string/string.zig");

const ConstString = string.ConstString;

const expectEqual = std.testing.expectEqual;

test "should correctly return characters for pure ascii string" {
    var str = ConstString.init("Hello World!");

    var char = str.charAt(4);

    try expectEqual(@as(u21, 'o'), char);
}

test "should correctly return characters for strings containing unicode characters" {
    var str = ConstString.init("Héllô Wórld‼");

    const char = str.charAt(11);

    try expectEqual(@as(u21, 0x203C), char);
}

test "should correctly return cached character" {
    var str = ConstString.init("Héllô Wórld‼");

    const char1 = str.charAt(11);
    const char2 = str.charAt(4);

    try expectEqual(@as(u21, 0x203C), char1);
    try expectEqual(@as(u21, 0xF4), char2);
}
