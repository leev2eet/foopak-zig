const std = @import("std");
const string = @import("../../../src/string/string.zig");

const StringBuilder = string.StringBuilder;

const expectEqualStrings = std.testing.expectEqualStrings;

test "@StringBuilder.getCharAt should correctly return characters for pure ascii string" {
    var str = StringBuilder.init("Hello World!");

    var char = str.getCharAt(4);

    try expectEqualStrings("o", char);
}

test "@StringBuilder.getCharAt should correctly return characters for strings containing unicode characters" {
    var str = StringBuilder.init("Héllô Wórld‼");

    const char = str.getCharAt(11);

    try expectEqualStrings("‼", char);
}

test "@StringBuilder.getCharAt should correctly return cached character" {
    var str = StringBuilder.init("Héllô Wórld‼");

    const char1 = str.getCharAt(11);
    const char2 = str.getCharAt(4);

    try expectEqualStrings("‼", char1);
    try expectEqualStrings("ô", char2);
}
