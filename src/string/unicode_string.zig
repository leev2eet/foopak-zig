const std = @import("std");

const Utf8Iterator = std.unicode.Utf8Iterator;
const Utf8View = std.unicode.Utf8View;

pub const UnicodeString = struct {
    cache: []u21,
    characterCount: usize,
    iterator: Utf8Iterator,
    view: Utf8View,

    pub fn init(comptime buffer: []const u8) UnicodeString {
        var utf8View = Utf8View.initUnchecked(buffer);
        var cache = init: {
            var arr: [buffer.len]u21 = undefined;
            for (arr) |*v, i| {
                v.* = 0;
            }
            break :init arr;
        };

        return UnicodeString{
            .cache = &cache,
            .characterCount = 0,
            .iterator = utf8View.iterator(),
            .view = utf8View,
        };
    }

    pub fn getBuffer(self: *UnicodeString) []const u8 {
        return self.view.bytes;
    }

    pub fn charAt(self: *UnicodeString, index: usize) u21 {
        while (self.characterCount <= index) {
            const character = self.iterator.nextCodepoint() orelse 0;
            self.cache[self.characterCount] = character;
            self.characterCount += 1;
        }

        return self.cache[index];
    }
};
