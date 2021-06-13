const ConstCharacter = struct {
    buffer: []const u8,
    length: u8,
    offset: usize,

    pub fn init(buffer: []const u8, length: u8, offset: usize) ConstCharacter {
        return ConstCharacter{
            .buffer = buffer,
            .length = length,
            .offset = offset,
        };
    }
};
