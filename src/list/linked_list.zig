pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Node = struct {
            item: T,
            next: ?*Self.Node,
        };

        head: ?*Self.Node,
        length: usize,

        pub fn init() Self {
            return Self{
                .head = null,
                .length = 0,
            };
        }
    };
}
