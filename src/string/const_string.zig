pub const ConstString = struct {
    buffer: []const u8,

    pub fn init(buffer: []const u8) ConstString {
        return ConstString{
            .buffer = buffer,
        };
    }

    pub fn getBuffer(self: ConstString) []const u8 {
        return self.buffer;
    }
};
