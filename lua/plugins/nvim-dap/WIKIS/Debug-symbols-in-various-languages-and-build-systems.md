For debugging advanced language features like macros, check the build system/compiler documentation.

### Languages

- [C](#c)
- [C++](#C++)
- [Rust](#Rust)
- [Zig](#Zig)

---

### Build systems

- [CMake](#CMake)
- [Meson](#Meson)

### C
```sh
clang/gcc/tcc.. -g # simpler C compilers like tcc dont have optimisation levels
clang/gcc -O0/O1/-O2/-O3 # prefer -O0 for getting more debugging symbols
```
### C++
```sh
clang/gcc -g
clang/gcc -O0/O1/-O2/-O3 # prefer -O0 for getting more debugging symbols
```
### Rust
```sh
RUSTFLAGS=-g cargo build # better use profiles in `Cargo.toml` 
RUSTFLAGS='-g --opt-level=1' cargo build # Both are slow to write and force debugging info for all projects.
```
### Zig
```sh
zig build-exe -O Debug 
```

---

### CMake
```sh
# `CMakeLists.txt` can require hard to understand stuff like `set(CMAKE_BUILD_TYPE "Release" CACHE STRING FORCE)` for debugging.
cmake -DCMAKE_BUILD_TYPE="Debug" # keep it simple. `RelWithDebInfo` also an option
```
### Meson
```sh
meson setup buildfolder ----buildtype debug # default is `debug`
meson configure ----buildtype `debug|debugoptimized` # default is debug
```
