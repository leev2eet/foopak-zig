const std = @import("std");

const Allocator = std.mem.Allocator;

pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            item: ?T,
            next: *Self.Node,

            pub fn createEmpty(allocator: *Allocator) *Self.Node {
                return allocator.create(Self.Node) catch unreachable;
            }

            pub fn create(allocator: *Allocator, item: ?T, next: *Self.Node) *Self.Node {
                var node = Self.Node.createEmpty(allocator);

                node.item = item;
                node.next = next;

                return node;
            }

            pub fn destroy(self: *Self.Node, allocator: *Allocator) void {
                allocator.destroy(self);
            }
        };

        pub const Iterator = struct {
            current: *Self.Node,

            pub fn init(node: *Self.Node) Self.Iterator {
                return Self.Iterator{ .current = node };
            }

            pub fn next(self: *Self.Iterator) ?T {
                var item = self.current.item;
                self.current = self.current.next;
                return item;
            }

            pub fn copy(self: *Self.Iterator) Self.Iterator {
                return Self.Iterator{
                    .current = self.current,
                };
            }

            pub fn peek(self: *Self.Iterator) ?T {
                return self.current.item;
            }
        };

        allocator: *Allocator,
        head: *Self.Node,
        tail: *Self.Node,
        len: usize,

        pub fn create(opt_allocator: ?*Allocator) Self {
            var allocator = opt_allocator orelse std.heap.c_allocator;

            var head = Self.Node.createEmpty(allocator);
            var tail = Self.Node.createEmpty(allocator);

            head.item = null;
            tail.item = null;

            head.next = tail;
            tail.next = head;

            return Self{
                .allocator = allocator,
                .head = head,
                .tail = tail,
                .len = 0,
            };
        }

        pub fn destroy(self: *Self) void {
            var node = self.head.next;
            self.head.destroy(self.allocator);

            while (node.item != null) {
                var next_node = node.next;
                node.destroy(self.allocator);
                node = next_node;
            }
        }

        pub fn prepend(self: *Self, item: T) void {
            self.head.next = Self.Node.create(self.allocator, item, self.head.next);
            self.len += 1;
        }

        pub fn append(self: *Self, item: T) void {
            self.tail.item = item;
            var new_tail = Self.Node.create(self.allocator, null, self.head);
            self.tail.next = new_tail;
            self.tail = new_tail;
            self.len += 1;
        }

        pub fn begin(self: *Self) Self.Iterator {
            return Self.Iterator.init(self.head.next);
        }
    };
}
