const std = @import("std");
const list = @import("../../../../src/list/linked_list.zig");

const LinkedList = list.LinkedList;

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

test "@LinkedList.Iterator.peek should correctly peek iterator without advancing" {
    var linked_list = LinkedList(i32).create(null);

    linked_list.append(3);
    linked_list.append(5);
    linked_list.append(1);

    var it = linked_list.begin();

    var call1 = it.peek();
    var call2 = it.peek();

    try expectEqual(@as(i32, 3), call1.?);
    try expectEqual(@as(i32, 3), call2.?);
    try expectEqual(linked_list.head.next, it.current);
}
