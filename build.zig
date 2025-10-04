const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("libcue", .{});
    const lib = b.addLibrary(.{
        .name = "cue",
        .linkage = .static,
        .root_module = b.createModule(.{
            .target = b.standardTargetOptions(.{}),
            .optimize = b.standardOptimizeOption(.{}),
            .link_libc = true,
        }),
    });
    lib.addCSourceFiles(.{
        .root = upstream.path(""),
        .files = &.{
            "cd.c",
            "cdtext.c",
            "rem.c",
            "time.c",
        },
    });
    lib.addIncludePath(upstream.path(""));
    lib.addCSourceFiles(.{ .files = &.{
        "cue_parser.c",
        "cue_scanner.c",
    } });
    lib.installHeadersDirectory(upstream.path(""), "", .{
        .include_extensions = &.{
            "libcue.h",
        },
    });
    b.installArtifact(lib);
}
