const std = @import("std");
const list = @import("../../../src/list/list.zig");

const LinkedList = list.LinkedList;

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

test "@LinkedList.create should correctly create new list" {
    var linked_list = LinkedList(i32).create(null);

    try expect(linked_list.head == null);
    try expectEqual(@as(usize, 0), linked_list.length);
}
