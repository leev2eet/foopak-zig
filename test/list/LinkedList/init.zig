const std = @import("std");
const list = @import("../../../src/list/list.zig");

const LinkedList = list.LinkedList;

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

test "@LinkedList.init should correctly init" {
    var linked_list = LinkedList(i32).init();

    try expect(linked_list.head == null);
    try expectEqual(@as(usize, 0), linked_list.length);
}
