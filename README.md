# Go Project Compiler Script

This PowerShell script simplifies the compilation process of Go projects for Windows, Web (WebAssembly), and Linux platforms. Designed to automate and streamline the build process, it allows for seamless compilation across different environments.

I admit this might be overkill, but I like to quickly test and debug and being able to just hit a Macro to compile with a single command is awesome. I may eventually set this script up to autolaunch all build targets as well. Also resetting up the web component each time was a pain.

## Prerequisites

Before using this script, ensure your development environment is correctly set up for the platforms you intend to compile for. Here's what you'll need:

### General Setup

- PowerShell 5.1 or newer.

### Windows and Linux Compilation

- Go programming language setup: Visit [Ebitengine's Installation Guide](https://ebitengine.org/en/documents/install.html) for detailed instructions on setting up your environment for Windows and Linux development.

### Installing Godot on Ubuntu (WSL)

- For compiling on Linux using Ubuntu via WSL, follow the instructions to [Install Go on Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-install-go-on-ubuntu-20-04). This guide provides a comprehensive walkthrough for installing Go and preparing your environment.

### Web Compilation

- To prepare for Web compilation using WebAssembly, consult the [WebAssembly with Ebitengine Guide](https://ebitengine.org/en/documents/webassembly.html). This document covers the necessary steps to compile Go projects for the web platform.

## Features

- Cross-platform compilation support for Windows, Web (WASM), and Linux.
- Automatic environment variable handling for Go cross-compilation.
- Option to overwrite the `dist` directory to maintain a clean build environment.
- Dynamic generation of an HTML wrapper for WebAssembly projects.

## Usage

Navigate to your Go project's root directory in PowerShell and execute the script with the desired parameters:

- **GAMENAME**: Sets the name for your compiled binaries.
- **OVERWRITE**: Deletes the existing `dist` directory before compilation.
- **WINDOWS**: Targets the Windows platform for compilation.
- **WEB**: Targets web platforms using WebAssembly.
- **LINUX**: Targets the Linux platform, requiring WSL for compilation.

Example:

```powershell
./go-compile.ps1 -OVERWRITE -WINDOWS -WEB -LINUX -GAMENAME "silent-echoes"
```

This will compile your project for Windows, Web, and Linux, overwrite the dist folder, and name the game "silent-echoes".
Process Overview

- The script prompts for a game name if not provided.
- With the OVERWRITE flag, it confirms before deleting dist.
- It compiles the project for each specified platform, managing environment variables accordingly.
- For WebAssembly, an HTML wrapper is created for browser execution.
- A summary of operations, including the duration, is displayed at the end.

Customization

This script can be modified to suit your project needs, such as adding more compilation targets or altering the WebAssembly HTML template.
License

This script is free to use and modify without attribution.

## Acknowledgements

Go team for the comprehensive toolchain.
The PowerShell community for resources and examples.