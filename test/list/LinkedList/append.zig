const std = @import("std");
const list = @import("../../../src/list/list.zig");

const LinkedList = list.LinkedList;

const expectEqual = std.testing.expectEqual;

test "@LinkedList.append should correctly append to empty list" {
    var linked_list = LinkedList(i32).create(null);
    defer linked_list.destroy();

    linked_list.append(69); // lmao

    try expectEqual(@as(i32, 69), linked_list.head.next.item.?);
}

test "@LinkedList.append should correctly append to non-empty list" {
    var linked_list = LinkedList(i32).create(null);
    defer linked_list.destroy();

    linked_list.append(69); // lmao
    linked_list.append(420);

    try expectEqual(@as(i32, 69), linked_list.head.next.item.?);
    try expectEqual(@as(i32, 420), linked_list.head.next.next.item.?);
}
