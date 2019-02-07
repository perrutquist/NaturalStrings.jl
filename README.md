# Work In Progress

This documentation relates to code that is not yet written.

For a package that has a chance of working, see: https://github.com/simonster/NaturalSort.jl

# NaturalStrings

[![Build Status](https://travis-ci.com/perrutquist/NaturalStrings.jl.svg?branch=master)](https://travis-ci.com/perrutquist/NaturalStrings.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/perrutquist/NaturalStrings.jl?svg=true)](https://ci.appveyor.com/project/perrutquist/NaturalStrings-jl)
[![Codecov](https://codecov.io/gh/perrutquist/NaturalStrings.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/perrutquist/NaturalStrings.jl)

NaturalStrings is a Julia package for arranging strings in a [natural sort order](https://en.wikipedia.org/wiki/Natural_sort_order) where "a" sorts before "B" and "item 9" sorts before "item 10".

Iterating over a `NaturalString` will yield `NaturalChar`s. The `NaturalChar` type is a wrapper for either a character (graphmeme) or a `Substring` representing a number (which is treated as if it were a single "character").

In sorting, `NaturalChar`s compare alphabetically first. Accents and case only matter for otherwise identical letters. Numbers are sorted numerically and sort before all other characters.

The `length` of a `NaturalString` is computed counting all-digit substrings as single characters. It can therefore be smaller than the length of the wrapped string.

## Examples

```julia
julia> sort(["B", "a100", "a10", "a11", "á10", "a9"], by=NaturalString)
```

```julia
julia> for c in NaturalString("S10E01")
           println(c)
       end
```

## Performance

The `NaturalString` type is just a thin wrapper. Parsing takes place each time that the string is iterated over.

## Notes

The minus sign (`-`) and the period (`.`) are treated as a characters rather than parts of numbers, so `NaturalString("item-9")` sorts before `NaturalString("item-10")` and  `NaturalString("v0.9")` sorts before `NaturalString("v0.10")`.

Numbers are compared numerically, ignoring leading zeros. Therefore `NaturalString("S1E1") == NaturalString("S01E01")`. Use `===` to test for identical strings.

Indexing into a `NaturalString` is done in terms of code units, just as with a `String`. The difference is that digits count as code units that combine into `NumberChar`s, so indexing into the middle of a number will give a `StringIndexError`.

There is currently no support for numbers in bases other than 10.

Also, There is currently not much i18n support (e.g. digits other than the ones for which `isdigit` returns `true`).
