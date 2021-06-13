const std = @import("std");
const list = @import("../../../../src/list/linked_list.zig");

const LinkedList = list.LinkedList;

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

test "@LinkedList.Iterator.next should correctly advance iterator" {
    var linked_list = LinkedList(i32).create(null);

    linked_list.append(3);
    linked_list.append(5);
    linked_list.append(1);

    var it = linked_list.begin();

    var item: ?i32 = null;

    item = it.next();
    try expectEqual(@as(i32, 3), item.?);
    item = it.next();
    try expectEqual(@as(i32, 5), item.?);
    item = it.next();
    try expectEqual(@as(i32, 1), item.?);
    item = it.next();
    try expect(item == null);
}
