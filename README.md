# dkml-workflows-regular-example

A "regular" example for the [dkml-workflow](https://github.com/diskuv/dkml-workflows#dkml-workflows) GitHub Action
workflows. DKML helps you
distribute native OCaml applications on the most common operating systems.
In particular [dkml-workflow] builds:
* Windows libraries and executables with the traditional Visual Studio compiler, avoiding hard-to-debug runtime issued caused by compiler incompatibilities
* macOS libraries and executables for both Intel and ARM64 (Apple Silicon) architectures
* Linux libraries and executables on an ancient "glibc" C library, letting you distribute your software to most Linux users
  while avoiding the alternative approach of [static linking the system C library](https://gavinhoward.com/2021/10/static-linking-considered-harmful-considered-harmful/)

[dkml-workflow]: https://github.com/diskuv/dkml-workflows#dkml-workflows

The full list of examples is:

| Example                                                                                      | Who For                                                                                                    |
| -------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| [dkml-workflows-monorepo-example](https://github.com/diskuv/dkml-workflows-monorepo-example) | You want to cross-compile ARM64 on Mac Intel.<br>You are building [Mirage unikernels](https://mirage.io/). |
| [dkml-workflows-regular-example](https://github.com/diskuv/dkml-workflows-regular-example)   | Everybody else                                                                                             |

These workflows are **not quick** and won't improve unless you are willing to contribute PRs!
Expect to wait approximately:

| Build Step                                               | First Time | Subsequent Times |
| -------------------------------------------------------- | ---------- | ---------------- |
| setup-dkml / win32-windows_x86                           | `29m`      | sdf              |
| setup-dkml / win32-windows_x86_64                        | `29m`      | sdf              |
| setup-dkml / macos-darwin_all [1]                        | `29m`      | sdf              |
| setup-dkml / manylinux2014-linux_x86 (CentOS 7, etc.)    | `16m`      | sdf              |
| setup-dkml / manylinux2014-linux_x86_64 (CentOS 7, etc.) | `13m`      | sdf              |
| build / win32-windows_x86                                | `23m`      | sdf              |
| build / win32-windows_x86_64                             | `19m`      | sdf              |
| build / macos-darwin_all                                 | `27m`      | sdf              |
| build / manylinux2014-linux_x86 (CentOS 7, etc.)         | `09m`      | sdf              |
| build / manylinux2014-linux_x86_64 (CentOS 7, etc.)      | `09m`      | sdf              |
| release                                                  | `01m`      | sdf              |
| **TOTAL** *(not cumulative since steps run in parallel)* | `57m`      | sdf              |

You can see an example workflow at https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/package.yml

[1] `setup-dkml/macos-darwin_all` is doing double-duty: it is compiling x86_64 and arm64 systems.

## Status

| What             | Branch/Tag | Status                                                                                                                                                                                                      |
| ---------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Builds and tests |            | [![Builds and tests](https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/build.yml/badge.svg)](https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/build.yml) |
| Static checks    |            | [![Static checks](https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/static.yml/badge.svg)](https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/static.yml)  |
