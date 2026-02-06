//! yarn~ 2026
const std = @import("std");

pub fn main() void {
    const buf: [0x1000]u8 = undefined;




    std.debug.print("{}\n", .{buf[1]});
}
