const std = @import("std");

const Allocator = std.mem.Allocator;

pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            item: T,
            next: ?*Self.Node,
        };

        pub const Iterator = struct {
            current: ?*Self.Node,

            pub fn init(node: *Self.Node) Self.Iterator {
                return Self.Iterator{ .current = node };
            }

            pub fn next(self: *Self.Iterator) ?T {
                if (self.current == null) {
                    return null;
                }

                var item = &self.current.item;
                self.current = self.current.next;
                return item;
            }

            pub fn copy(self: *Self.Iterator) Self.Iterator {
                return Self.Iterator{
                    .current = self.current,
                };
            }
        };

        allocator: *Allocator,
        head: ?*Self.Node,
        length: usize,

        pub fn create(allocator: ?*Allocator) Self {
            return Self{
                .allocator = allocator orelse std.heap.c_allocator,
                .head = null,
                .length = 0,
            };
        }

        pub fn destroy(self: *Self) void {
            var node = self.head;

            while (node != null) {
                var next_node = node.?.next;
                self.allocator.destroy(node.?);
                node = next_node;
            }
        }

        pub fn prepend(self: *Self, item: T) void {
            var new_head = self.allocator.create(Self.Node) catch unreachable;

            new_head.item = item;
            new_head.next = self.head;
            self.head = new_head;
        }
    };
}
