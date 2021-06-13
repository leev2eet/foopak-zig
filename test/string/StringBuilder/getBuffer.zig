const std = @import("std");
const string = @import("../../../src/string/string.zig");

const StringBuilder = string.StringBuilder;

const expectEqualStrings = std.testing.expectEqualStrings;

test "@StringBuilder.getBuffer should correctly return buffer" {
    const buffer = "Hello World!";
    var str = StringBuilder.init(buffer);

    try expectEqualStrings(str.getBuffer(), buffer);
}

test "@StringBuilder.getBuffer should correctly return buffer containing unicode characters" {
    const buffer = "Héllô Wórld‼";
    var str = StringBuilder.init(buffer);

    try expectEqualStrings(str.getBuffer(), buffer);
}
