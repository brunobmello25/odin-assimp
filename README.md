# DONT USE THIS FORK

This fork is DEFINITELY not meant for production. I only forked it because of a hobby project I'm making where i needed to make some changes. I'll break APIs all the time, and I'll probably eventually ditch this binding and switch to the native cgltf vendor supported by odin

## Odin assimp bindings

Cross-platform Odin bindings for Assimp (tested with v4.1.0+)

Supports: **Linux** and **Windows**

## Usage

### Linux
Install assimp library via your package manager:

```bash
# Fedora
sudo dnf install assimp-devel

# Ubuntu/Debian
sudo apt install libassimp-dev

# Arch
sudo pacman -S assimp
```

### Windows
 * Clone: https://github.com/assimp/assimp/tree/v4.1.0
 * Build the x64 Visual Studio project
   - Cmake: `cmake -G"Visual Studio 15 Win64"`
 * Place `assimp-vc140-mt.lib` next to `assimp.odin`
 * Place the DLL next to your executable

## Example
```odin
import assimp "path/to/odin-assimp"

main :: proc() {
    scene := assimp.import_file("model.obj", 0)
    defer assimp.release_import(scene)

    // Use the scene data...
}
```

## Notes
 * These bindings are incomplete right now, and I have only tested the `import_file` and `release_import` functions.
 * Some of the types may not be right
 * Let me know if you find any issues, or submit a pull request

## Changes from Original
 * Added platform detection for Linux and Windows
 * On Linux: uses system-installed assimp library
 * On Windows: uses the original `assimp-vc140-mt.lib` approach
