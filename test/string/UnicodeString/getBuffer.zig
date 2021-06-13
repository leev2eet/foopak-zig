const std = @import("std");
const string = @import("../../../src/string/string.zig");

const UnicodeString = string.UnicodeString;

const expectEqualStrings = std.testing.expectEqualStrings;

test "@UnicodeString.getBuffer should correctly return buffer" {
    const buffer = "Hello World!";
    var str = UnicodeString.init(buffer);

    try expectEqualStrings(str.getBuffer(), buffer);
}

test "@UnicodeString.getBuffer should correctly return buffer containing unicode characters" {
    const buffer = "Héllô Wórld‼";
    var str = UnicodeString.init(buffer);

    try expectEqualStrings(str.getBuffer(), buffer);
}
