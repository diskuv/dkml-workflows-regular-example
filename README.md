# dkml-workflows-regular-example

A "regular" example for the [dkml-workflows](https://github.com/diskuv/dkml-workflows#dkml-workflows)
collection of GitHub Action, GitLab CI/CD and desktop workflows. DKML helps you
distribute native OCaml applications on the most common operating systems.
In particular the [setup-dkml.yml@v1] of [dkml-workflows] builds:
* Windows libraries and executables with the traditional Visual Studio compiler, avoiding hard-to-debug runtime issued caused by compiler incompatibilities
* macOS libraries and executables for both Intel and ARM64 (Apple Silicon) architectures
* Linux libraries and executables on an ancient "glibc" C library, letting you distribute your software to most Linux users
  while avoiding the alternative approach of [static linking the system C library](https://gavinhoward.com/2021/10/static-linking-considered-harmful-considered-harmful/)

The full list of examples is:

| Example                                                                                      | Who For                                                                                                                                         |
| -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| [dkml-workflows-monorepo-example](https://github.com/diskuv/dkml-workflows-monorepo-example) | **Not ready for public use yet!**<br>You want to cross-compile ARM64 on Mac Intel.<br>You are building [Mirage unikernels](https://mirage.io/). |
| [dkml-workflows-regular-example](https://github.com/diskuv/dkml-workflows-regular-example)   | Everybody else                                                                                                                                  |

> Before using these examples be sure to read the [advantages and disadvantages of setup-workflow][setup-dkml.yml@v1].
> One particular limitation is that, as of today, [setup-dkml.yml@v1] only supports OCaml 4.12.1.

These workflows are **not quick** and won't improve unless you are willing to contribute PRs!
Expect to wait approximately:

| Build Step                                               | First Time | Subsequent Times |
| -------------------------------------------------------- | ---------- | ---------------- |
| setup-dkml / win32-windows_x86                           | `29m`      | `6m`             |
| setup-dkml / win32-windows_x86_64                        | `29m`      | `6m`             |
| setup-dkml / macos-darwin_all [1]                        | `29m`      | `6m`             |
| setup-dkml / manylinux2014-linux_x86 (CentOS 7, etc.)    | `16m`      | `5m`             |
| setup-dkml / manylinux2014-linux_x86_64 (CentOS 7, etc.) | `13m`      | `5m`             |
| build / win32-windows_x86                                | `23m`      | todo             |
| build / win32-windows_x86_64                             | `19m`      | todo             |
| build / macos-darwin_all                                 | `27m`      | todo             |
| build / manylinux2014-linux_x86 (CentOS 7, etc.)         | `09m`      | todo             |
| build / manylinux2014-linux_x86_64 (CentOS 7, etc.)      | `09m`      | todo             |
| release                                                  | `01m`      | todo             |
| **TOTAL** *(not cumulative since steps run in parallel)* | `57m`      | todo             |

You can see an example workflow at https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/package.yml

[1] `setup-dkml/macos-darwin_all` is doing double-duty: it is compiling x86_64 and arm64 systems.

For news about Diskuv OCaml,
[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/diskuv.svg?style=social&label=Follow%20%40diskuv)](https://twitter.com/diskuv) on Twitter.

## Sponsor

<a href="https://ocaml-sf.org">
<img align="left" alt="OCSF logo" src="https://ocaml-sf.org/assets/ocsf_logo.svg"/>
</a>
Thanks to the <a href="https://ocaml-sf.org">OCaml Software Foundation</a>
for economic support to the development of Diskuv OCaml.
<p/>

## Status

| What             | Branch/Tag | Status                                                                                                                                                                                                      |
| ---------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Builds and tests |            | [![Builds and tests](https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/build.yml/badge.svg)](https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/build.yml) |
| Static checks    |            | [![Static checks](https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/static.yml/badge.svg)](https://github.com/diskuv/dkml-workflows-regular-example/actions/workflows/static.yml)  |

[dkml-workflows]: https://github.com/diskuv/dkml-workflows#dkml-workflows
[setup-dkml.yml@v1]: https://github.com/diskuv/dkml-workflows/tree/v1#setup-dkml-auto-generating-github-releases-for-ocaml-native-executables
