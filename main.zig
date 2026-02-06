//! yarn~ 2026
const std = @import("std");

pub fn main() !void {
    var args = std.process.args();
    _ = args.next();
    const fname = args.next() orelse return error.NoFileProvided;

    var buf: [0x1000]u8 = undefined;

    const file = try std.fs.cwd().openFileZ(fname, .{ .mode = .read_only });

    const bytes_read = try file.readAll(&buf);

    outer:
    for (0..0x1000/16) |i| {
        std.debug.print("{x:0>4}: ", .{ i * 16 });
        var cnt: u2 = 0;
        for (0..16) |j| {
            if (i * 16 + j > bytes_read) {
                std.debug.print("   ", .{});
            } else {
                std.debug.print("{x:0>2} ", .{ buf[16 * i + j] });
            }

            if (cnt == 3 and j < 15) {
                std.debug.print(" ", .{});
            }
            cnt +%= 1;
        }

        std.debug.print(" ", .{});

        for (0..16) |j| {
            if (i * 16 + j > bytes_read) {
                break :outer;
            }

            if (std.ascii.isAscii(buf[16 * i + j]) and !std.ascii.isControl(buf[16*i+j])) {
                std.debug.print("{c}", .{ buf[16 * i + j] });
            } else {
                std.debug.print(".", .{});
            }
        }

        std.debug.print("\n", .{});
    }

    std.debug.print("\n", .{});
}
