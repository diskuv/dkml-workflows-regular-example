# Developing

## Upgrading the DKML scripts

```bash
opam install . --deps-only
opam upgrade dkml-workflows

# Regenerate the DKML workflow scaffolding
opam exec -- generate-setup-dkml-scaffold
opam exec -- dune build '@gen-dkml' --auto-promote
```
