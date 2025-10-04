# libcue [![CI](https://github.com/floatdrop/libcue/actions/workflows/ci.yaml/badge.svg)](https://github.com/floatdrop/libcue/actions/workflows/ci.yaml)

This is [libcue](https://github.com/lipnitsk/libcue), packaged for [Zig](https://ziglang.org/).

## Getting parser and scanner

> TODO: These actions could be automated

To generate `cue_parser.c` and `cue_parser.h` invoke this command from upstream repository:

```sh
bison -d -o cue_parser.c cue_parser.y
```

To generate `cue_scanner.c` invoke this command from upstream repository:

```sh
flex -o cue_scanner.c cue_scanner.l
```

## Using library in Zig

Add library to your `build.zig` file:

```zig
const libcue_dep = b.dependency("libcue", .{
    .target = target,
    .optimize = optimize,
});
mod.linkLibrary(libcue_dep.artifact("cue"));
```

After that you will be able to import functions from `libcue.h`:

```zig
const cue = @cImport({
    @cInclude("libcue.h");
});
```

Glhf!
