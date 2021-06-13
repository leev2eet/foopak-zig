const std = @import("std");

const Utf8Iterator = std.unicode.Utf8Iterator;
const Utf8View = std.unicode.Utf8View;

pub const UnicodeString = struct {
    cache: []?[]const u8,
    characterCount: usize,
    iterator: Utf8Iterator,
    view: Utf8View,

    pub fn init(comptime buffer: []const u8) UnicodeString {
        var utf8View = Utf8View.initUnchecked(buffer);
        var cache = init: {
            var arr: [buffer.len]?[]const u8 = undefined;
            for (arr) |*v, i| {
                v.* = null;
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

    pub fn getCharAt(self: *UnicodeString, index: usize) []const u8 {
        while (self.characterCount <= index) {
            const character = self.iterator.nextCodepointSlice();
            self.cache[self.characterCount] = character;
            self.characterCount += 1;
        }

        return self.cache[index] orelse "";
    }
};
