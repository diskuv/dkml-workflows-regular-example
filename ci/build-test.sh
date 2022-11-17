#!/bin/sh
set -euf

usage() {
    echo "'--opam-package OPAM_PACKAGE.opam --executable-name EXECUTABLE_NAME' where you have a (executable (public_name EXECUTABLE_NAME) ...) in some 'dune' file" >&2
    exit 3
}
OPTION=$1
shift
[ "$OPTION" = "--opam-package" ] || usage
OPAM_PACKAGE=$1
shift
OPTION=$1
shift
[ "$OPTION" = "--executable-name" ] || usage
EXECUTABLE_NAME=$1
shift

# shellcheck disable=SC2154
echo "
=============
build-test.sh
=============
.
---------
Arguments
---------
OPAM_PACKAGE=$OPAM_PACKAGE
EXECUTABLE_NAME=$EXECUTABLE_NAME
.
------
Matrix
------
dkml_host_abi=$dkml_host_abi
abi_pattern=$abi_pattern
opam_root=$opam_root
exe_ext=${exe_ext:-}
.
"

# PATH. Add opamrun
if [ -n "${CI_PROJECT_DIR:-}" ]; then
    export PATH="$CI_PROJECT_DIR/.ci/sd4/opamrun:$PATH"
elif [ -n "${PC_PROJECT_DIR:-}" ]; then
    export PATH="$PC_PROJECT_DIR/.ci/sd4/opamrun:$PATH"
elif [ -n "${GITHUB_WORKSPACE:-}" ]; then
    export PATH="$GITHUB_WORKSPACE/.ci/sd4/opamrun:$PATH"
else
    export PATH="$PWD/.ci/sd4/opamrun:$PATH"
fi

# Initial Diagnostics
opamrun switch
opamrun list
opamrun var
opamrun config report
opamrun exec -- ocamlc -config
xswitch=$(opamrun var switch)
if [ -x /usr/bin/cypgath ]; then
    xswitch=$(/usr/bin/cygpath -au "$xswitch")
fi
if [ -e "$xswitch/src-ocaml/config.log" ]; then
    echo '--- BEGIN src-ocaml/config.log ---' >&2
    cat "$xswitch/src-ocaml/config.log" >&2
    echo '--- END src-ocaml/config.log ---' >&2
fi

# Update
opamrun update

# Build and test
#
#     Because conf-pkg-config errors on manylinux2014 (CentOS 7):
#       No solution found, exiting
#       - conf-pkg-config
#       depends on the unavailable system package 'pkgconfig'.
#     we use `--no-depexts`. The dockcross manylinux2014 has package names
#     "pkgconfig.i686" and "pkgconfig.x86_64"; sadly that does not seem to match what
#     opam 2.1.0 is looking for (ie. "pkgconfig").
OPAM_PKGNAME=${OPAM_PACKAGE%.opam}
opamrun exec -- env
case "${dkml_host_abi}" in
linux_*) opamrun install "./${OPAM_PKGNAME}.opam" --with-test --yes --no-depexts ;;
*) opamrun install "./${OPAM_PKGNAME}.opam" --with-test --yes ;;
esac

# Copy the installed binary from 'dkml' Opam switch into dist/ folder:
#
# dist/
#   <dkml_host_abi>/
#      <file1>
#      ...
#
# For GitHub Actions specifically the structure is:
#
# dist/
#    <file1>
#      ...
# since the ABI should be the uploaded artifact name already in .github/workflows:
#   - uses: actions/upload-artifact@v3
#     with:
#       name: ${{ matrix.dkml_host_abi }}
#       path: dist/

if [ -n "${GITHUB_ENV:-}" ]; then
    DIST=dist
else
    DIST="dist/${dkml_host_abi}"
fi
install -d "${DIST}"
ls -l "${opam_root}/dkml/bin"
#   If (executable (public_name EXECUTABLE_NAME) ...) already has .exe then executable will
#   have .exe. Otherwise it depends on exe_ext.
case "$EXECUTABLE_NAME" in
*.exe) suffix_ext="" ;;
*) suffix_ext="${exe_ext:-}" ;;
esac
#   Copy executable
install -v "${opam_root}/dkml/bin/${EXECUTABLE_NAME}${suffix_ext}" "${DIST}/${EXECUTABLE_NAME}${suffix_ext}"
#   For Windows you must ask your users to first install the vc_redist executable.
#   Confer: https://github.com/diskuv/dkml-workflows#distributing-your-windows-executables
case "${dkml_host_abi}" in
windows_x86_64) wget -O "${DIST}/vc_redist.x64.exe" https://aka.ms/vs/17/release/vc_redist.x64.exe ;;
windows_x86) wget -O "${DIST}/vc_redist.x86.exe" https://aka.ms/vs/17/release/vc_redist.x86.exe ;;
windows_arm64) wget -O "${DIST}/vc_redist.arm64.exe" https://aka.ms/vs/17/release/vc_redist.arm64.exe ;;
esac

# Final Diagnostics
case "${dkml_host_abi}" in
linux_*)
    if command -v apk; then
        apk add file
    fi ;;
esac
file "${DIST}/${EXECUTABLE_NAME}${suffix_ext}"
