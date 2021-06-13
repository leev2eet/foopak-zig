const std = @import("std");
const list = @import("../../../../src/list/linked_list.zig");

const LinkedList = list.LinkedList;

const expectEqual = std.testing.expectEqual;

test "@LinkedList.Iterator.copy should correctly copy iterator" {
    var linked_list = LinkedList(i32).create(null);

    linked_list.append(3);
    linked_list.append(5);
    linked_list.append(1);

    var it = linked_list.begin();
    var it_copy = it.copy();

    _ = it.next();

    try expectEqual(@as(i32, 5), it.current.item.?);
    try expectEqual(@as(i32, 3), it_copy.current.item.?);
}
