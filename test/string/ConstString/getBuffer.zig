const std = @import("std");
const string = @import("../../../src/string/string.zig");

const ConstString = string.ConstString;

const expectEqualStrings = std.testing.expectEqualStrings;

test "should correctly return buffer" {
    const buffer = "Hello World!";
    const str = ConstString.init(buffer);

    try expectEqualStrings(str.getBuffer(), buffer);
}

test "should correctly return buffer containing unicode characters" {
    const buffer = "Héllô Wórld‼";
    const str = ConstString.init(buffer);

    try expectEqualStrings(str.getBuffer(), buffer);
}
