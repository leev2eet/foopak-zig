const std = @import("std");
const list = @import("../../../src/list/list.zig");

const LinkedList = list.LinkedList;

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

test "@LinkedList.begin should correctly create iterator" {
    var linked_list = LinkedList(i32).create(null);
    defer linked_list.destroy();

    linked_list.append(42);
    linked_list.append(69); // lmao
    linked_list.append(420);

    var begin = linked_list.begin();

    try expectEqual(linked_list.head.next, begin.current);
}
